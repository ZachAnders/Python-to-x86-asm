from ..operations.helpers import call_func_asm

TAGS = ['BIG', 'BOOL', 'INT']

class AbstractAllocation(object):
    """ An abstract representation of an allocation. Designed to make the
        injection of raw values, and the projection of tagged values
        easier to manage. """

    def __init__(self, location):
        self.tag = None
        self.is_raw = True
        self.location = location

    def project(self, tag, force=False):
        assert tag in TAGS, "Invalid tag: " + str(tag)
        if self.tag != tag and not force:
            raise ValueError(self.tag + " Is Not " + tag)
        if not self.is_raw or force:
            project_code = call_func_asm('project_'+tag.lower(), [self.location], self.location) 
            self.is_raw = True
            return project_code 
        else:
            raise ValueError('Cannot Project Raw Allocation')

    def inject(self, tag, force=False):
        assert tag in TAGS, "Invalid tag: " + str(tag)
        if self.is_raw or force:
            self.tag = tag
            inject_code = call_func_asm('inject_'+tag.lower(),
                    [self.location],
                    self.location) 
            self.is_raw = False
            return inject_code 
        else:
            raise ValueError('Cannot Inject Already Tagged Allocation')

class RegisterAllocation(AbstractAllocation):
    """ Represents a variable that has been allocated into a register. """

    def __init__(self, register):
        self.register = register
        super(RegisterAllocation, self).__init__(str(self))

    def __repr__(self):
        return "%" + self.register

class StackAllocation(AbstractAllocation):
    """ Represents a variable that has been allocated into a stack memory
        locations. """

    def __init__(self, stack_pos):
        assert stack_pos > 0, "Cannot have negative stack pos!"
        self.stack_pos = stack_pos
        super(StackAllocation, self).__init__(str(self))

    def __repr__(self):
        return "-{num}(%ebp)".format(num=str(self.stack_pos))

import inspect

# Instances are used to represent the 'name' of anonymous stack variables
class AnonymousIdentifier():
    ANON_ID = 0
    def __init__(self):
        # We record the stack trace so we can identify who allocated us later
        self.allocated_at = inspect.stack()
        self.anonId = AnonymousIdentifier.ANON_ID
        AnonymousIdentifier.ANON_ID += 1

    def __repr__(self):
        return "<AnonVariable_{num}>".format(num=self.anonId)

class NamedIdentifier():
    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return "<NamedVariable_[{name}]>".format(name=self.name)



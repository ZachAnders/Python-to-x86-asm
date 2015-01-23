import inspect

# Instances are used to represent the 'name' of anonymous stack variables
class AnonymousIdentifier():
    def __init__(self):
        # We record the stack trace so we can identify who allocated us later
        self.allocated_at = inspect.stack()

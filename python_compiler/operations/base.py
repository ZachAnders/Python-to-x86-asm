class AbstractOperation():
    HAS_OUTPUT_KEY = False # Defaults to False
    SPILLABLE = False # Defaults to spillable

    def get_memory_operands(self):
        return []

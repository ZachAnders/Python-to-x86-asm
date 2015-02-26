class AbstractOperation():
    HAS_OUTPUT_KEY = False # Defaults to False
    HAS_TEMP_REG = False # Default to no temp reg

    def get_memory_operands(self):
        return []

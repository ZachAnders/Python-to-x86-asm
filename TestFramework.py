"""
TODO:
run compiler [test file]
Make Compare Program show red for extra lines
"""

import os, subprocess, argparse, random

def main():
    """
    Main
    """
    # Parse through arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("-gcc", help="Use gcc based python compiler", action="store_true")
    parser.add_argument("-clang", help="Use clang based python compiler", action="store_true")
    parser.add_argument("-tf", type=str, help="Use a test file set (.py, .in), no extensions needed")
    parser.add_argument("-tdir", type=str, help="Use a test directory, -tf will be ignored if used")
    parser.add_argument("-makein", type=str, help="Makes a .in file for a .py file")
    args = parser.parse_args() 
    # Handle Arguments
    if args.tf != None and args.tdir == None:
        RunTest(args.tf)
    elif args.tdir != None:
        tests = next(os.walk(args.tdir))[2]
        tests = set(os.path.splitext(os.path.basename(test))[0] for test in tests)
        for test in tests:
            if test[0] != ".":
                RunTest(test, args.tdir)

    if args.makein != None:
        GenInputFile(args.makein)
    #check_output = CheckOutput()
    #check_output.add("clang compiler", [1, 30129301283018230182301890, 4])
    #check_output.add("gcc compiler", [1, 3])
    #check_output.add("interpeter", [1, 3])
    #check_output.CompareLinesAreSame()

def RunTest(test_name, directory=""):
    """
    Runs a test set
    """
    print BColors.UNDERLINE + "Running Test File: " + test_name + BColors.ENDC
    if directory != "":
        directory += "/"
    test_file, test_input = directory+test_name+".py", directory+test_name+".in"
    inp = LoadInput(test_input)
    process = subprocess.Popen(['python', test_file], \
        stdout=subprocess.PIPE, stdin=subprocess.PIPE,\
        stderr=subprocess.PIPE)
    out, _ = process.communicate(input=inp)
    print out

def GenInputFile(file_name):
    f = open(file_name+".py", 'r')
    save = open(file_name+".in", 'w')

    for line in f:
        pos = 0
        for i in range(line.count("input()")):
            pos = line.find("input()")
            if (pos != 0 and line[pos-1] == " ") or (pos == 0):
                save.write(str(random.randint(-100,100)))
    f.close()
    save.close()
class BColors():
    """
    Provides color output for terminal
    """
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

class CheckOutput():
    """
    Checks Multiple Outputs for Consistentance
    """
    def __init__(self):
        self.outputs = {}

    def add(self, key, output):
        """
        add output
        """
        self.outputs[key] = output

    def remove(self, key):
        """
        remove output
        """
        if key in self.outputs.keys():
            del self.outputs[key]

    def CompareLinesAreSame(self):
        """
        Run Comparison
        """
        passed = True
        keys, outs = self.outputs.keys(), self.outputs.values()
        max_output_size = len(str(max(max(outs))))
        max_key_size = max(len(key) for key in keys)
        space_amount = 5 if max_output_size <= max_key_size + 5 else max_output_size - max_key_size + 5
        max_lines = max(len(str(len(out))) for out in outs)
        header = "#" * max_lines + " | " + "".join([key + " "*(space_amount) for key in keys])
        failed_lines = []

        for i in range(min(len(out) for out in outs)):
            if not all(out[i] == outs[0][i] for out in outs):
                failed_lines.append(i)
                passed = False

        if not all(len(out) == len(outs[0]) for out in outs):
            min_length = min(len(out) for out in outs)
            max_length = max(len(out) for out in outs)
            failed_lines += [i for i in range(min_length, max_length)]
            passed = False

        if not passed:
            print BColors.HEADER + "Inconsistent Results:" + BColors.ENDC
            print BColors.UNDERLINE + BColors.BOLD +header + BColors.ENDC
            for i in range(max(len(out) for out in outs)):
                safe_outs = [str(out[i]) if i < len(out) else "-" for out in outs] 
                is_error = BColors.FAIL if i in failed_lines else ""
                print is_error + str(i) + " " *(max_lines - len(str(i))) + " | " + \
                    "".join([str(safe_outs[j]) + " "*abs(space_amount + len(keys[j]) - len(safe_outs[j]))\
                    for j in range(len(keys))]) + \
                    BColors.ENDC
             
        return passed

def LoadInput(FileName):
    """
    Load .in file
    """
    f = open(FileName, 'r')
    result = "".join(f.read())
    f.close()
    return result

if __name__ == "__main__":
    main()

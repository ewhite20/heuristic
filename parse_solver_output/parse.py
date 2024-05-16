import sys
import re

def parse_output(output):
    lines = output.split('\n')
    result = ""
    filename = ""
    for line in lines:
        line = line.strip()
        if line.startswith('o '):
            result += filename +": "+ str(line.split()[1]) + "\n"
            filename = ""
        if line.startswith('c Instance: '):
            filename = line.split()[2]
    return result

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <output_file>")
        sys.exit(1)
    
    output_file = sys.argv[1]
    
    with open(output_file, 'r') as f:
        output = f.read()
    
    parsed_output = parse_output(output)
    
    print("Parsed Output:")
    print(parsed_output)

if __name__ == "__main__":
    main()
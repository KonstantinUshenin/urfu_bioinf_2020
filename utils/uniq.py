import sys

test_filename = 'test.txt'

in_filename = sys.argv[1] if len(sys.argv) >= 3 else test_filename
out_filename = sys.argv[2] if len(sys.argv) >= 3 else test_filename

with open(in_filename) as file:
    indexes = set(file.readlines())

with open(out_filename, 'w') as file:
    file.write(''.join(indexes))

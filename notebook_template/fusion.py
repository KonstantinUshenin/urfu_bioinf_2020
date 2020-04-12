import sys


def fusion(index_filename, fix_filename, out_filename):
    with open(index_filename) as file:
        indexes = list(file.readlines())

    with open(fix_filename) as file:
        fixes = list(file.readlines())

    new_indexes = []
    for index in indexes:
        if index not in fixes:
            new_indexes.append(index)

    with open(out_filename, 'w') as file:
        for index in new_indexes:
            file.write(index)


if __name__ == '__main__':
    index_filename = sys.argv[1] if len(sys.argv) >= 4 else snakemake.input[0]
    fix_filename = sys.argv[2] if len(sys.argv) >= 4 else snakemake.input[1]
    out_filename = sys.argv[3] if len(sys.argv) >= 4 else snakemake.output
    fusion(index_filename, fix_filename, out_filename)

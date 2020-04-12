import argparse


def uniq(in_filename, out_filename):
    with open(in_filename) as file:
        indexes = set(map(lambda s: s.strip(), file.readlines()))

    new_indexes = []
    for index in indexes:
        if index.find('.') < 0 or index[:index.find('.')] not in indexes:
            new_indexes.append(index)

    with open(out_filename, 'w') as file:
        file.write('\n'.join(new_indexes))
        file.write('\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Return uniques strings')
    parser.add_argument('in_filename', metavar='INPUT_FILE',
                        help='input file with indexes')
    parser.add_argument('out_filename', metavar='OUTPUT_FILE',
                        help='fasta file, ')
    args = parser.parse_args()
    uniq(args.in_filename, args.out_filename)

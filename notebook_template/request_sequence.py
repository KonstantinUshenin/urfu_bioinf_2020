#!/usr/bin/env python
# coding: utf-8
import argparse
from Bio import Entrez
from urllib.error import HTTPError
from bs4 import BeautifulSoup


Entrez.email = 'example@gmail.com'
MARKER = 'Textseq-id_accession'
PROTEIN = 'protein'
NUClEOTIDE = 'nucleotide'


def request_entrez(seq_id, db='protein', rettype='fasta'):
    try:
        with Entrez.efetch(db=db, id=seq_id, rettype=rettype) as response:
            print("Founded {} in {} by Entrez".format(seq_id, db))
            return response.read()
    except HTTPError:
        print("Don't found {} in {} by Entrez".format(seq_id, db))


def save_animal_name(fasta_text):
    lines = fasta_text.split('\n')
    lines[0] = lines[0].split()[0] + lines[0][lines[0].find('['):].replace(' ', '_')
    return '\n'.join(lines)


def find_linked_index(text):
    soup = BeautifulSoup(linked_text, 'xml')
    matched = soup.findAll(MARKER)
    if matched is not None:
        return matched[0].text if MAIN_DB is NUClEOTIDE else matched[1].text


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='This module downloads '
                                                 'sequences by their id in '
                                                 'some databases')
    parser.add_argument('in_filename', metavar='INPUT_FILE',
                        help='file with ids of sequences')
    parser.add_argument('out_filename', metavar='OUTPUT_FILE',
                        help='fasta file, when you want ot write sequences')
    parser.add_argument('main_db', metavar='MAIN_TYPE_OF_SEQUENCE',
                        help='the main db for searching sequences')

    args = parser.parse_args()
    MAIN_DB = args.main_db
    SECOND_DB = NUClEOTIDE if MAIN_DB == PROTEIN else PROTEIN
    print(f'Main db is {MAIN_DB}, Second db is {SECOND_DB}')

    with open(args.in_filename) as file:
        genes = list(map(lambda x: x.strip(), file.readlines()))

    handles = []

    for gene_id in genes:
        handle = request_entrez(gene_id, db=MAIN_DB)
        if handle is not None:
            handles.append(save_animal_name(handle))
        else:
            linked_text = request_entrez(gene_id, db=SECOND_DB, rettype='html')
            result = find_linked_index(linked_text)
            if result is not None and result not in genes:
                genes.append(result)

    with open(args.out_filename, 'w') as file:
        for handle in handles:
            file.write(handle)

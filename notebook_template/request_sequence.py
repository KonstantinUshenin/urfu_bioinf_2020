#!/usr/bin/env python
# coding: utf-8
import sys
import os
import argparse
from Bio import Entrez
from urllib.error import HTTPError
from bs4 import BeautifulSoup
sys.path.append(os.path.dirname(os.path.abspath(__file__[:__file__.rfind(r'/')])))
from config import request_seq


Entrez.email = 'example@gmail.com'
BASE_DB = request_seq['BASE_DB']
SECOND_DB = request_seq['SECOND_DB']
MARKER = request_seq['MARKER']
PROTEIN = request_seq['PROTEIN']
NUClEOTIDE = request_seq['NUClEOTIDE']


def request_entrez(seq_id, db=BASE_DB, rettype='fasta'):
    try:
        with Entrez.efetch(db=db, id=seq_id, rettype=rettype) as response:
            print("Founded {} in {} by Entrez".format(seq_id, db))
            return response.read()
    except HTTPError:
        print("Don't found {} in {} by Entrez".format(seq_id, db))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='This module downloads '
                                                 'sequences by their id in '
                                                 'some databases')
    parser.add_argument('in_filename', metavar='INPUT_FILE',
                        help='file with ids of sequences')
    parser.add_argument('out_filename', metavar='OUTPUT_FILE',
                        help='fasta file, when you want ot write sequences')
    args = parser.parse_args()

    with open(args.in_filename) as file:
        genes = list(map(lambda x: x.strip(), file.readlines()))

    handles = []

    for gene_id in genes:
        handle = request_entrez(gene_id)
        if handle is not None:
            data = handle.split('\n')
            data[0] = data[0].split()[0] + data[0][data[0].find('['):].replace(' ', '_')
            handles.append('\n'.join(data))
        else:
            other_text = request_entrez(gene_id, db=SECOND_DB, rettype='html')
            if other_text is not None:
                soup = BeautifulSoup(other_text, 'xml')
                res = soup.findAll(MARKER)
                if res is not None:
                    result = res[0].text if BASE_DB == NUClEOTIDE else res[1].text
                    if result not in genes:
                        genes.append(result)

    with open(args.out_filename, 'w') as file:
        for handle in handles:
            file.write(handle)

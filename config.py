#!/usr/bin/env python
# coding: utf-8

request_seq = {
    'PROTEIN': 'protein',
    'NUClEOTIDE': 'nucleotide',
    'MARKER': 'Textseq-id_accession',
}
request_seq['BASE_DB'] = request_seq['NUClEOTIDE']
request_seq['SECOND_DB'] = request_seq['PROTEIN']

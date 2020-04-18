import sys
import matplotlib.pylab as plt
from Bio import Phylo

in_filename = sys.argv[1] if len(sys.argv) >= 3 else snakemake.input
out_filename = sys.argv[2] if len(sys.argv) >= 3 else snakemake.output

Phylo.convert(in_filename, 'newick', out_filename, 'nexus')

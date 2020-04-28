import sys
from Bio import Phylo

'''Module dnd_convert is a utility module only
to convert newick format to NEXUS format.
It needs to plot phylogenetic trees with R module.'''

in_filename = sys.argv[1] if len(sys.argv) >= 3 else snakemake.input
out_filename = sys.argv[2] if len(sys.argv) >= 3 else snakemake.output

Phylo.convert(in_filename, 'newick', out_filename, 'nexus')

#!/usr/bin/env python
# coding: utf-8

# In[ ]:

import sys
import matplotlib.pylab as plt
from Bio import Phylo


# In[ ]:


in_filename = sys.argv[1] if len(sys.argv) >= 3 else snakemake.input
out_filename = sys.argv[2] if len(sys.argv) >= 3 else snakemake.output


# In[ ]:


tree = Phylo.read(in_filename, "newick")
Phylo.draw(tree, do_show=False)
plt.savefig(out_filename)


# In[ ]:





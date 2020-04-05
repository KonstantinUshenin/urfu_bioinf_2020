#!/usr/bin/env python
# coding: utf-8

# In[13]:
import sys
from Bio import Entrez
from urllib.error import HTTPError

Entrez.email = 'example@gmail.com'
DATABASENAME = 'nucleotide'


# In[ ]:


test_in_filename = "/home/kostanew/Documents/PIPELINE/urfu_bioinf_2020/dataset/Na/request.txt" 
test_out_filename = "./sample.txt"


# In[14]:


in_filename = sys.argv[1] if len(sys.argv) >= 3 else snakemake.input
out_filename = sys.argv[2] if len(sys.argv) >= 3 else snakemake.output


# In[15]:


genes = []
with open(in_filename) as file:
    # file.readline() #Pass .csv header
    for line in file.readlines():
        line = line.split(',')
        genes.append(line[0].strip())

genes = list(filter(lambda x: len(x) > 0, genes))


# In[16]:


handles = []
for gene_id in genes:
    try:
        with Entrez.efetch(db=DATABASENAME, id=gene_id, rettype="fasta") as handle:
            handles.append(handle.read())
    except HTTPError as e:
        print("Don't found {} by Entrez".format(gene_id))
        print(e)


# In[17]:


handles


# In[18]:


with open(out_filename, 'w') as file:
    for handle in handles:
        file.write(handle)


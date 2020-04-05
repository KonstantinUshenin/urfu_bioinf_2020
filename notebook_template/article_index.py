#!/usr/bin/env python
# coding: utf-8

# In[1]:
import sys
from bs4 import BeautifulSoup
import re

test_in_filename = "" 
test_out_filename = ""

in_filename = sys.argv[1] if len(sys.argv) >= 3 else snakemake.input
out_filename = sys.argv[2] if len(sys.argv) >= 3 else snakemake.output

with open(in_filename) as file:
    text = file.read()

# In[2]:


VARIATIONS = [
    'protein',
    'gene',
    'nuccore'  # Нуклеотид
]

HREFS = []


def href_filter(href):
    if href is not None:
        for structure_name in VARIATIONS:
            if structure_name in href:
                HREFS.append(href)
                return True
    return False


soup = BeautifulSoup(text, 'lxml')
soup.find_all('a', href=href_filter)


# In[3]:


indexes = []
for href in HREFS:
    index = href.split('/')[-1]
    if re.match(r'[A-Z]+_[0-9]+|\.[0-9]', index) is not None:
        indexes.append(index)


# In[ ]:


with open(out_filename, 'a') as file:
    for index in indexes:
        file.write(index + '\n')


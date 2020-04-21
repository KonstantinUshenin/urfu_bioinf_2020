# urfu_bioinf_2020
Pipeline for building of philogenetic trees

## Description
Using this pipeline you can create amazing phylogenetic trees of 
cell's channel.It's quite simple, you just need to add NCBI's indexes of 
genes or articles in the format html. At the output of the pipeline you 
can receive pictures with your phylogenetic trees. 
Pipeline can be configured for any phylogenetic tree creation.  

## Denpendences
* Snakemake
* Matplotlib
* Biopython
* ClustalW

## Installation

1. Clone this repository to your workflow

2. In the directory of this repository execute command for install
dependencies 
```sh
pip install requiments.txt
```
Нou will also need to install dependences for R:
```sh
Rscript --vanilla utils/build-dep-list.R R-requirements.txt 
```
After that compile libraries:
```sh
cd utils/
make
```
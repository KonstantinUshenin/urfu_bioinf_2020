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
`pip install requiments.txt`

## Usage

1. Make dir in folder `dataset` with name of your channel

2. In channel's directory add file with name `request.txt` and folder 
with name `article/`. In file `request.txt` add NCBI's indexes of nucleotides
and add to folder `article/` articles you are interested in

3.  That's all. You can tun pipeline by execute command
`snakemake --cores=1 --forceall`

# urfu_bioinf_2020
Pipeline for building of philogenetic treespip

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
pip install -r requiments.txt
```
Нou will also need to install dependences for R `version 3.6`:
```sh
Rscript --vanilla utils/build-dep-list.R R-requirements.txt 
```
After that compile libraries:
```sh
make
```
If your version older than use this commands (Ubuntu only):
```sh
sudo apt install apt-transport-https software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt update
sudo apt install r-base
```
To verify that the installation was successful run the following command which will print the R version:
```sh
R --version
```

## Usage

1. Make dir in folder `dataset` with name of your channel

2. In channel's directory add file with name `request.txt` and folder 
with name `article/`. In file `request.txt` add NCBI's indexes of nucleotides
and add to folder `article/` articles you are interested in

3.  That's all. You can tun pipeline by execute command


```sh
snakemake --cores=1 --forceall
```

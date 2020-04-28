FROM continuumio/miniconda3

# R instalation
RUN conda install -c r r-essentials

RUN conda install -c bioconda bioconductor-ggtree
RUN conda install --force-reinstall -c conda-forge r-ggridges=0.5.1
COPY requirements.txt ./

#clustalw installation
RUN wget http://www.clustal.org/download/current/clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
RUN tar -xf clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
RUN cp clustalw-2.1-linux-x86_64-libcppstatic/clustalw2 /bin/clustalw2

WORKDIR /opt
COPY . .

RUN apt-get update -y && apt-get install -y gcc
RUN pip install -r requirements.txt

ENTRYPOINT [ "bash" ]
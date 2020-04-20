FROM python:3.7-stretch

WORKDIR /opt

COPY requirements.txt ./

RUN pip3 install -r requirements.txt

#r instalation
RUN apt-get update && apt-get install -y r-base

#clustalw installation
RUN wget http://www.clustal.org/download/current/clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
RUN zcat clustalw-2.1-linux-x86_64-libcppstatic.tar.gz > clustalw

COPY . .

RUN snakemake --unlock --cores=1
ENTRYPOINT ["snakemake"]
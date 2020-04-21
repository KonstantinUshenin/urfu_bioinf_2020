FROM python:3.7-stretch

WORKDIR /opt

COPY requirements.txt ./

RUN pip3 install -r requirements.txt

#r instalation
RUN apt-get update && apt-get install -y r-base

#clustalw installation
RUN wget http://www.clustal.org/download/current/clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
RUN tar -xf clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
RUN cp clustalw-2.1-linux-x86_64-libcppstatic/clustalw2 /bin/clustalw2

COPY . .

RUN snakemake --unlock --cores=1
ENTRYPOINT ["bash"]

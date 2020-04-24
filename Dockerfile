FROM python:3.7-stretch

WORKDIR /opt

COPY requirements.txt ./

RUN pip3 install -r requirements.txt

#r instalation
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/'
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN sudo apt update
RUN sudo apt install r-base

#clustalw installation
RUN wget http://www.clustal.org/download/current/clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
RUN tar -xf clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
RUN cp clustalw-2.1-linux-x86_64-libcppstatic/clustalw2 /bin/clustalw2

COPY . .

RUN Rscript --vanilla utils/build-dep-list.R R-requirements.txt
RUN make

RUN snakemake --unlock --cores=1
ENTRYPOINT ["bash"]

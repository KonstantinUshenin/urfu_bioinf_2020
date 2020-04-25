# FROM r-base:3.6.1

# WORKDIR /opt

# COPY requirements.txt ./

# # python installation
# RUN apt-get update
# RUN apt-get install -y build-essential checkinstall
# RUN apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev \
#     libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
# RUN wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
# RUN tar xzf Python-3.8.2.tgz
# RUN bash Python-3.8.2/configure --enable-optimizations
# RUN make altinstall
# RUN echo "alias python='python3.8'" >> ~/.bashrc

# RUN python3.8 -m pip install -r requirements.txt

# #clustalw installation
# RUN wget http://www.clustal.org/download/current/clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
# RUN tar -xf clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
# RUN cp clustalw-2.1-linux-x86_64-libcppstatic/clustalw2 /bin/clustalw2

# COPY . .

# RUN apt install -y libcurl4-openssl-dev
# RUN apt-get install build-essential
# RUN add-apt-repository -y ppa:cran/imagemagick
# RUN apt-get update
# RUN apt-get install -y libmagick++-dev

# RUN Rscript --vanilla utils/build-dep-list.R R-requirements.txt
# RUN make

# # RUN snakemake --unlock --cores=1
# ENTRYPOINT ["bash"]

# 7 apt update
# 8 apt upgrade
# 9 apt install python3

# 16 apt install make
# 17 apt install python3-pip
# 18 pip3 install biopython
# 19 pip3 install snakemake
# 20 apt install apt-transport-https software-properties-common
# 21 apt-key adv —keyserver keyserver.ubuntu.com —recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# 22 add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
# 23 apt update
# 24 apt install r-base
# 25 R —version
# 26 cd home
# 27 cd Phylogenetic/
# 30 pip3 install -r requirements.txt
# 32 apt install libcurl4-openssl-dev
# 34 add-apt-repository -y ppa:cran/imagemagick
# 35 apt-get update
# 36 apt-get install -y libmagick++-dev
# 39 apt-get update -y
# 40 apt-get install -y clustalw
# 41 snakemake —cores=1 —forceall

# FROM openanalytics/r-base:3.6.1

# RUN apt update

# # python instalation
# RUN apt install -y python3
# RUN apt install -y python3-pip

# # R instalation
# # RUN apt install -y make
# # RUN apt install -y apt-transport-https software-properties-common
# # RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# # RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
# # RUN apt update
# # RUN apt install -y r-base

# WORKDIR /opt
# COPY requirements.txt ./

# # instaling dependencies
# RUN pip3 install -r requirements.txt

# RUN apt-get install -y software-properties-common
# RUN apt install -y gpg
# RUN add-apt-repository -y ppa:cran/imagemagick
# # RUN apt-get update
# RUN apt-get install -y libmagick++-dev
# RUN apt-get install -y clustalw

# COPY . . 

# # RUN Rscript --vanilla utils/build-dep-list.R R-requirements.txt
# RUN apt install -y make
# RUN make

# ENTRYPOINT [ "bash" ]


# FROM ubuntu:18.04

# #python installation
# RUN apt update
# RUN apt upgrade
# RUN apt install -y python3 python3-pip

# # R instalation
# RUN apt install -y make
# RUN apt install -y apt-transport-https software-properties-common gpg
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
# RUN apt update
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get install -y --no-install-recommends  build-essential r-base

# # RUN apt-get install libcurl4-openssl-dev
# # RUN add-apt-repository -y ppa:cran/imagemagick
# # RUN apt-get update
# # RUN apt-get install -y libmagick++-dev

# WORKDIR /opt
# COPY . .

# RUN make

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
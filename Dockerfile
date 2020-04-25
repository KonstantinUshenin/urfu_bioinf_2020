FROM ubuntu:18.04

LABEL maintainer="Vladislav Zaripov"

COPY . home/Phylogenetic

# Change entrypoint
ENTRYPOINT ["bin/bash"]
library(data.tree)
library(ape)
library(ggtree)
library(ggimage)
library(ggridges)

args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

anotherTree <- read.nexus(args[1])
jpeg(args[2])
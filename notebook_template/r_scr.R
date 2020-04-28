 #   library(data.tree)
    library(ape)
    library(ggtree)
    library(ggimage)
    library(phytools)
  #  library(ggridges)
        
    library(dendextend)

args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

anotherTree <- read.nexus(args[1])
anotherTree <- compute.brtime(anotherTree, method="coalescent", force.positive=TRUE)
is.ultrametric(anotherTree)
is.binary(anotherTree)
is.rooted(anotherTree)
  
anotherTree<-multi2di(anotherTree)


#Tree.ultra <- chronos(anotherTree)  сообщает об отрицательных длинах

# вытянуть ветки до края  


  is.ultrametric(anotherTree)
  is.binary(anotherTree)
  is.rooted(anotherTree)

  dend <- as.hclust(anotherTree)
  dend <- as.dendrogram(dend)
  #anotherTree <- hang.dendrogram(dend, hang = 0.1)
      
  
#dend <- as.hclust.phylo(anotherTree)

#dend <- as.dendrogram(anotherTree) 

dend %>%
  set("labels_col", value = c("skyblue", "orange", "grey", "red"), k=4) %>%
  set("branches_k_color", value = c("skyblue", "orange", "grey", "red"), k = 4) %>%
  plot(horiz = TRUE)
  
jpeg(args[2])
dev.off()
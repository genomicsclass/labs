# biocLite("SpikeIn")
library(SpikeIn)
data("SpikeIn95")
##from previous data exploration we know that array 55 is bad. we pick
##two groups with same  52-55 and 56-59
int=pm(SpikeIn95)[,52:59] ###int for intensity
spikeInDesign=pData(SpikeIn95)[52:59,]

cdfname <- getCdfInfo(SpikeIn95)
psets <- as.list(cdfname)
psets <- psets[order(names(psets))]
index <- unlist(sapply(psets, function(x) x[, 1]), use.names = FALSE)
locations <- indices2xy(index,cdf="hgu95acdf")

save(int,spikeInDesign,locations,file="spikeInSubset.rda")

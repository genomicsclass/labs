library(DiffBind)
setwd(system.file("extra", package="DiffBind"))
read.csv("tamoxifen.csv")
list.files("peaks")
ta <- dba(sampleSheet="tamoxifen.csv")
head(ta$peaks[[1]])

pks <- GRanges(ta$peaks[[1]]$V1, 
                  IRanges(ta$peaks[[1]]$V2,
                          ta$peaks[[1]]$V3))

table(seqnames(pks))

# find the distances between peaks
plot(start(pks))
dists <- start(pks)[-1] - start(pks)[-length(pks)]
max(dists)
which.max(dists)
abline(h=start(pks)[which.max(dists)])
abline(h=start(pks)[which.max(dists) + 1])


library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
g <- genes(txdb)

# find the gene which peak 500 is within
idx <- which(g %over% pks[500])
g[idx]
pks[500]

# find the nearest gene to peak 
idx <- nearest(pks[475], g)
pks[475]
g[idx]
distance(pks[475], g[idx])

# same as
distanceToNearest(pks[475], g)





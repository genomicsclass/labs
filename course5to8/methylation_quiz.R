library(coloncancermeth)
data(coloncancermeth)
X <- model.matrix(~pd$Status)
chr <- as.factor(seqnames(gr))
pos <- start(gr)
library(bumphunter)
cl <- clusterMaker(chr,pos,maxGap=500)
res <- bumphunter(meth,X,chr=chr,pos=pos,cluster=cl,cutoff=0.1,B=0)

# the sixth region
head(res$table[6,])

cols=ifelse(pd$Status=="normal",1,2)
Index=(res$table[6,7]-3):(res$table[6,8]+3)
matplot(pos[Index],meth[Index,,drop=TRUE],
        col=cols,pch=1,xlab="genomic location",ylab="Methylation",ylim=c(0,1))

# what are the averages?
Index=(res$table[6,7]):(res$table[6,8])
mean(meth[Index,pd$Status=="cancer"])
mean(meth[Index,pd$Status=="normal"])

# which cancer samples have the smallest rank of methylation?
ranks <- t(apply(meth[Index,], 1, rank))
# the average ranks
averanks <- colMeans(ranks)
averanks[pd$Status=="cancer"]

# the smallest:
which.min(averanks[pd$Status=="cancer"])

# the two smallest
order(averanks[pd$Status=="cancer"])[1:2]
i = order(averanks[pd$Status=="cancer"])[1:2]

patid <- pd$bcr_patient_barcode
patid[pd$Status=="cancer"][i]

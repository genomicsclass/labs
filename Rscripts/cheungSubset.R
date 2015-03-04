library(Biobase)
library(GSE5859)
library(hgfocus.db) ##get the gene chromosome
data(GSE5859)
annot <- select(hgfocus.db, keys=featureNames(e), keytype="PROBEID",
                columns=c("CHR", "CHRLOC", "SYMBOL"))[,-4]
##for genes with multiples, pick on
annot <-annot[match(featureNames(e),annot$PROBEID),]
annot$CHR <- ifelse(is.na(annot$CHR),NA,paste0("chr",annot$CHR))
y<- colMeans(exprs(e)[which(annot$CHR=="chrY"),])
sex <- ifelse(y<4.5,"F","M")

sampleInfo <- pData(e)
sampleInfo$group <- ifelse(sex=="F",1,0)

batch <- format(pData(e)$date,"%y%m")
ind<-which(batch%in%c("0506","0510"))
set.seed(1)
N <- 12; N1 <-3; M<-12; M1<-9
ind <- c(sample(which(batch=="0506" & sex=="F"),N1),
         sample(which(batch=="0510" & sex=="F"),N-N1),
         sample(which(batch=="0506" & sex=="M"),M1),
         sample(which(batch=="0510" & sex=="M"),M-M1))

geneExpression <- exprs(e)[,ind]
sampleInfo <- sampleInfo[ind,]
geneAnnotation <- annot

save(geneExpression,sampleInfo,geneAnnotation,file="GSE5859Subset.rda")

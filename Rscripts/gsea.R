tab <- read.delim("gseacelfiles/reannotate_select_cal.gct",as.is=TRUE,skip=2)
library(affy)
fns <- list.celfiles(path="gseacelfiles")
 
sns <- gsub("\\.CEL\\.gz","",fns)
tmp<-strsplit(names(tab)[-c(1,2)],"\\.")
sns2 <- sapply(tmp,function(x)x[2])
tmp2 <- data.frame(t(sapply(tmp,function(x) strsplit(x[1],"_")[[1]])))
filenames <- fns[match(sns2,sns)]
ab<- ReadAffy(filenames=filenames,celfile.path="gseacelfiles")
e<-rma(ab)
dates<-vector("character",ncol(exprs(e)))
for(i in seq(along=dates)){
    tmp<-affyio::read.celfile.header(file.path("gseacelfiles",filenames[i]),info="full")
    dates[i]<-strsplit(tmp$ScanDate,"\ ")[[1]][1]
}
dates<-as.Date(dates,"%m/%d/%y")

tmp2$dates <- dates

pData(e)<-tmp2


save(e,file="gsea.rda")

##adding MAS 5.0
library(simpleaffy)
m <- justMAS(ab)
pData(m)<-tmp2
save(m,file="gseamas5.rda")

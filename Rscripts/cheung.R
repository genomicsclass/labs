library(GEOquery)
gse <- getGEO("GSE5859")
pd<-pData(gse[[1]])
library(affy)
filenames<-file.path("GSE5859",basename(as.character(pd[,38])))
e=justRMA(filenames=filenames)
dates<-vector("character",ncol(exprs(e)))
for(i in seq(along=dates)){
    tmp<-affyio::read.celfile.header(filenames[i],info="full")
    dates[i]<-strsplit(tmp$ScanDate,"\ ")[[1]][1]
}
dates<-as.Date(dates,"%m/%d/%y")

###ethnicity info obtained from Jeff Leek
eth <- readLines("fulldata_reprecent.txt",n=1)
eth=strsplit(eth,"\ ")[[1]]
eth=t(sapply(strsplit(eth,"_"),function(x) x))

gmnames<-gsub("_rep[12]","",as.character(pd[,1]))

eth2<-eth[match(gmnames,eth[,2]),1]
eth2[is.na(eth2)]<-"HAN" ##from LA, checked here
##http://ccr.coriell.org/Sections/Search/Advanced_Search.aspx?PgId=175


pd=data.frame(ethnicity=eth2,date=dates,filename=I(basename(filenames)))
pData(e)<-pd
save(e,file="GSE5859.rda")

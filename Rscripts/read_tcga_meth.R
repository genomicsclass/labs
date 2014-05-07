library(minfi)
## DOwnload
## colon/DNA_Methylation/JHU_USC__HumanMethylation450/Level_1/
## from tcga and put in datadir
datadir="/datadir"


clinicalDir=file.path(datadir,"Clinical/Biotab")
sample_tab=read.delim(file.path(clinicalDir,"biospecimen_sample_coad.txt"),sep="\t",stringsAsFactors=FALSE)
keep=sample_tab$sample_type %in% c("Primary Tumor", "Solid Tissue Normal")
sample_tab=sample_tab[keep,]

patient_id=unique(sapply(strsplit(sample_tab$bcr_sample_barcode,split="-"), function(x) paste(x[1:3],collapse="-")))

tumor_sample_id=sample_tab$bcr_sample_uuid[sample_tab$sample_type=="Primary Tumor"]
normal_sample_id=sample_tab$bcr_sample_uuid[sample_tab$sample_type=="Solid Tissue Normal"]

# read tumor data
tumor_tab=read.delim(file.path(clinicalDir,"biospecimen_tumor_sample_coad.txt"),sep="\t",stringsAsFactors=FALSE)

tab=merge(sample_tab, tumor_tab, by="bcr_sample_uuid", suffixes=c(".sample",".tumor"),all.x=TRUE)

# read normal data
normal_tab=read.delim(file.path(clinicalDir,"biospecimen_normal_control_coad.txt"),sep="\t",stringsAsFactors=FALSE)
tab=merge(tab, normal_tab, by="bcr_sample_uuid", suffixes=c(".tumor",".normal"),all.x=TRUE)

tab$bcr_patient_barcode=tab$bcr_patient_barcode.tumor

ii=is.na(tab$bcr_patient_barcode)
tab$bcr_patient_barcode[ii]=tab$bcr_patient_barcode.normal[ii]

# read patient data
patient_tab=read.delim(file.path(clinicalDir,"clinical_patient_coad.txt"),sep="\t",stringsAsFactors=FALSE)
names(patient_tab)=paste("patient",names(patient_tab),sep=".")
tmp=merge(tab,patient_tab,by.x="bcr_patient_barcode",by.y="patient.bcr_patient_barcode",all.x=TRUE,suffixes=c(".sample",".patient"))
tab=tmp

# read meth metadata
methMetaDir=file.path(datadir,"METADATA/JHU_USC__HumanMethylation450")
methMeta_tab=read.delim(file.path(methMetaDir,"jhu-usc.edu_COAD.HumanMethylation450.1.4.0.sdrf.txt"),sep="\t",stringsAsFactors=FALSE)

sample_barcode=sapply(strsplit(methMeta_tab$Comment..TCGA.Barcode.,split="-"),function(x) paste(x[1:4],collapse="-"))
m=match(tab$bcr_sample_barcode,sample_barcode)
tab$Basename=gsub("_Grn\\.idat","",methMeta_tab$Array.Data.File[m])
tab=tab[!is.na(tab$Basename),]

basedir=file.path(datadir,"DNA_Methylation/JHU_USC__HumanMethylation450/Level_1")
tab$Basename=file.path(basedir,tab$Basename)
keep=file.exists(paste(tab$Basename,"_Grn.idat",sep=""))
colon_targets=tab
objs=grep("tab",ls(),value=TRUE)
rm(list=objs)
objs=grep("dir",ls(),value=TRUE,ignore=TRUE)
rm(list=objs)

nms=names(colon_targets)
targets=colon_targets[nms]

targets$Status=factor(ifelse(targets$sample_type=="Primary Tumor","cancer","normal"),levels=c("normal","cancer"))
targets$Tissue=tolower(targets$patient.tumor_tissue_site)
targets$Sex=targets$patient.gender

datadir="rdas"
save(targets,colon_targets,breast_targets,lung_targets,file=file.path(datadir,"targets.rda"))

##read raw data
rgset <- read.450k(targets$Basename,verbose=TRUE)
pData(rgset)<-targets

#normalize with illumina default
mset1<-preprocessIllumina(rgset)
mset1<-mapToGenome(mset1)
meth <- getBeta(mset1,type="Illumina")
gr <- granges(mset1)
pd <- pData(mset1)

save(meth,gr,pd,file="coloncancermeth.rda")

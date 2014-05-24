library(minfi)
datadir="/home/bst/other/hcorrada/methyl/exps/tcga/raw_data/colon"

clinicalDir=file.path(datadir,"Clinical/Biotab")
sample_tab=read.delim(file.path(clinicalDir,"biospecimen_sample_coad.txt"),sep="\t",stringsAsFactors=FALSE)
keep=sample_tab$sample_type %in% c("Primary Tumor", "Solid Tissue Normal")
sample_tab=sample_tab[keep,]

patient_id=unique(sapply(strsplit(sample_tab$bcr_sample_barcode,split="-"), function(x) paste(x[1:3],collapse="-")))

tumor_sample_id=sample_tab$bcr_sample_uuid[sample_tab$sample_type=="Primary Tumor"]
normal_sample_id=sample_tab$bcr_sample_uuid[sample_tab$sample_type=="Solid Tissue Normal"]

# read tumor data
tumor_tab=read.delim(file.path(clinicalDir,"biospecimen_tumor_sample_coad.txt"),sep="\t",stringsAsFactors=FALSE)

###make it slightly harder by changing a name
write.csv(tumor_tab,file="tumor_tab.csv",row.names=FALSE)
write.csv(sample_tab,file="sample_tab.csv",row.names=FALSE)





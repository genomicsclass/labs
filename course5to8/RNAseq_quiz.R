link <- "http://bowtie-bio.sourceforge.net/recount/ExpressionSets/wang_eset.RData"
if (!file.exists("wang_eset.RData")) download.file(link, "wang_eset.RData")
load("wang_eset.RData")

library(Biobase)
library(GenomicRanges)
# the SimpleList part is only necessary for Bioc <= 2.13
se <- SummarizedExperiment(SimpleList(counts = exprs(wang.eset)))
colData(se) <- DataFrame(pData(wang.eset))

table(colData(se)$cell.type)

tissues <- c("cerebellum","breast","colon","heart","liver","skeletal.muscle")
se <- se[,colData(se)$cell.type %in% tissues]

table(colData(se)$cell.type)

test <- colData(se)$cell.type == "cerebellum"
lvls <- c("not","cerebellum")
condition <- factor(ifelse(test,"cerebellum","not"), levels=lvls)
colData(se)$condition <- condition

library(DESeq2)
dds <- DESeqDataSet( se, design = ~ condition )
dds <- DESeq( dds )
res <- results( dds )

res[order(res$pvalue)[1:10],]

# Bioc 2.13        baseMean log2FoldChange     lfcSE      stat        pvalue
# ENSG00000143858 1727.5839       7.937566 0.2794747  28.40173 1.924967e-177
# ENSG00000176749  733.8875       6.352004 0.2298648  27.63366 4.387200e-168
# ENSG00000187730 2766.0323      10.587430 0.3875275  27.32046 2.423703e-164
# ENSG00000161509 1229.6361       8.146916 0.3313924  24.58390 1.878103e-133
# ENSG00000170616 1288.3151       9.776143 0.4349104  22.47852 6.734571e-112

# Bioc 2.14        baseMean log2FoldChange     lfcSE      stat        pvalue
# ENSG00000143858 1727.5839       8.003262 0.3027984  26.43099 6.035903e-154
# ENSG00000176749  733.8875       6.391632 0.2502764  25.53830 7.407303e-144
# ENSG00000187730 2766.0323      10.767926 0.4252847  25.31933 1.956629e-141
# ENSG00000161509 1229.6361       8.244928 0.3546406  23.24868 1.466793e-119
# ENSG00000170616 1288.3151       9.988089 0.4793187  20.83809  1.954636e-96


top <- rownames(res)[order(res$pvalue)[1:10]]
top[1]

stripchart(log10(counts(dds,normalized=TRUE)[top[1],] + 1) ~ se$condition,
           vertical=TRUE, method="jitter")

# averages for each group
tapply(counts(dds,normalized=TRUE)[top[2],],
       colData(dds)$condition,
       mean)

library(org.Hs.eg.db)
keytypes(org.Hs.eg.db)
columns(org.Hs.eg.db)

# gene names
map <- select(org.Hs.eg.db, keys=top, 
              columns=c("SYMBOL", "GENENAME"), keytype="ENSEMBL")
map

map <- select(org.Hs.eg.db, keys=top[3], 
              columns=c("GO"), keytype="ENSEMBL")

# The following gives the GO terms:
map$GO

# this gives the meaning of these:
library(GO.db)
as.list(GOTERM[map$GO])

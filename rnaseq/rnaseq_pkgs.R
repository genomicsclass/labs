# 2 CRAN packages
cranpkgs <- c("ggplot2","pheatmap")
install.packages(cranpkgs)

# rafalib from github (not strictly necessary, but useful for plots)
install.packages("devtools")
library(devtools)
install_github("ririzarr/rafalib")

# the rest are Bioconductor packages
biocpkgs <- c("Rsamtools",
              "GenomicFeatures",
              "GenomicAlignments",
              "Rsubread",
              "airway",
              "pasilla",
              "DESeq2",
              "DEXSeq",
              "vsn",
              "sva",
              "org.Hs.eg.db",
              "cummeRbund",
              "pasillaBamSubset",
              "TxDb.Dmelanogaster.UCSC.dm3.ensGene")
source("http://bioconductor.org/biocLite.R")
biocLite(biocpkgs)
# note that Rsubread does not have a binary for Windows. This package is not required for class.

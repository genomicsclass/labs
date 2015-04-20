# 2 CRAN packages
cranpkgs <- c("ggplot2","pheatmap")
install.packages(cranpkgs)

# rafalib from github (not strictly necessary, but useful)
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
              "org.Hs.eg.db",
              "cummeRbund")
source("http://bioconductor.org/biocLite.R")
biocLite(biocpkgs)


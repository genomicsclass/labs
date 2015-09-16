library(VariantTools)
library(LungCancerLines)
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- gmapR::TP53Genome()
bams <- LungCancerLines::LungCancerBamFiles()
bam <- bams$H1993

tally.param <- TallyVariantsParam(genome, 
                                  high_base_quality = 23L)                                
call23 <- callVariants(bam, tally.param)
length(call23)
mean(mcols(call23)$raw.count)

# what's the average raw count with higher filter on quality
tally.param <- TallyVariantsParam(genome, 
                                  high_base_quality = 32L)                                
call32 <- callVariants(bam, tally.param)
length(call32)
mean(mcols(call32)$raw.count)




library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
library(VariantAnnotation)
fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
vcf <- readVcf(fl, genome="hg19")
seqlevels(vcf) <- paste0("chr", seqlevels(vcf))


# what is the gene whose promoter overlaps the first variant in vcf?
loc <- locateVariants(vcf, txdb, PromoterVariants())
loc

# ?promoter tells us that the promoter is 2000 bp upstream from the gene
# start and 200 bp downstream. note that gene start

# how far is this variant from this gene?
rowData(vcf[197])
g <- genes(txdb)
idx <- as.character(mcols(g)$gene_id) == "79174"
g[idx]

# this gives us the distance to the gene start
distance(rowData(vcf[197]), flank(g[idx], 0))

# it gives the same as this...
distance(rowData(vcf[197]), g[idx])

# however, theoretically if the variant was less 
# than 200 bp downstream from the TSS, and the 
# gene was very short, the variant could end up
# closer to the gene end. so the first line of code
# is safer.
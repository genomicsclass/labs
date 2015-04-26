# RSEM transcript alignment

RSEM homepage:

http://deweylab.biostat.wisc.edu/rsem/

RSEM paper:

http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3163565/

prepare-reference help:

http://deweylab.biostat.wisc.edu/rsem/rsem-prepare-reference.html

calculate-expression help:

http://deweylab.biostat.wisc.edu/rsem/rsem-calculate-expression.html

RSEM expects a GTF file with only exons, which are each assigned to a `transcript_id`.

Note that we only align to chromosome 1 for demonstration purposes.

```
awk '$3 == "exon"' gtf/Homo_sapiens.GRCh38.79.chrom1.gtf > gtf/Homo_sapiens.GRCh38.79.chrom1.exons.gtf
```

RSEM will then prepare a reference transcriptome against which to align reads.

```
mkdir rsemGenome
rsem-prepare-reference --gtf gtf/Homo_sapiens.GRCh38.79.chrom1.exons.gtf genome/Homo_sapiens.GRCh38.dna.chromosome.1.fa rsemGenome/GRCh38.79.chrom1
```

```
rsem-calculate-expression -p 12 --paired-end fastq/SRR1039508_1.fastq fastq/SRR1039508_2.fastq rsemGenome/GRCh38.79.chrom1 SRR1039508
```


# RSEM transcript alignment

RSEM expects a GTF file with only exons, which are each assigned to a `transcript_id`. 

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

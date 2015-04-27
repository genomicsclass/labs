# STAR commands

The STAR homepage:

https://github.com/alexdobin/STAR

The STAR paper:

http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3530905/

The STAR manual:

https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf

Downloading genome FASTA and GTF files from ENSEMBL:

http://ensembl.org

http://ensembl.org/info/data/ftp/index.html

Generating the genome:

Note the `sjdbOverhang` is used for constructing the splice junction database. It should be set to (read length - 1), and according to the manual a general value of 100 will work as well.

For this limited demonstration, I am only going to align to the genes on chromosome 1, so I subset the GTF file:

```
grep -P '^1\t' Homo_sapiens.GRCh38.79.gtf > Homo_sapiens.GRCh38.79.chrom1.gtf
```

We then moved files in subdirectories, and created one for the STAR genome index:

```
mkdir gtf
mkdir genome
mv *.gtf gtf
mv *.fa genome
mkdir GRCh38.79.chrom1
```

The STAR command to generate the genome index:

```
STAR --runMode genomeGenerate \
--genomeDir GRCh38.79.chrom1 \
--genomeFastaFiles genome/Homo_sapiens.GRCh38.dna.chromosome.1.fa \
--sjdbGTFfile gtf/Homo_sapiens.GRCh38.79.chrom1.gtf \
--sjdbOverhang 62 
```

Mapping the reads:

```
STAR --runThreadN 12 \
--genomeDir GRCh38.79.chrom1 \
--readFilesIn fastq/SRR1039508_1.fastq fastq/SRR1039508_2.fastq
```

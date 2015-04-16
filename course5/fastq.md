# Fastq files

## Links for this experiment

Study information at the Sequence Read Archive:

http://www.ncbi.nlm.nih.gov/Traces/sra/?study=SRP033351

Himes et al paper at PubMed Central:

http://www.ncbi.nlm.nih.gov/pubmed/24926665 

Example sample table stored in our course repo on github:

https://github.com/genomicsclass/labs/blob/master/course5/airway_sample_table.csv

Details on creating such a sample table from SRA and GEO:

http://www.bioconductor.org/packages/release/data/experiment/vignettes/airway/inst/doc/airway.html

The European Nucleotide Archive (EMBL-EBI):

http://www.ebi.ac.uk/ena 

The Sequence Read Archive (NCBI):

http://www.ncbi.nlm.nih.gov/sra/ 

## Fastq file commands

Downloading from the ENA:

```
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR103/008/SRR1039508/SRR1039508_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR103/008/SRR1039508/SRR1039508_2.fastq.gz
```

Alias for ls:

```
alias ll='ls -lGh'
```

Unzipping:

```
gunzip *.fastq.gz
```

Looking at the FASTQ files:

```
less SRR1039508_1.fastq
wc -l SRR1039508_1.fastq
```

Quality control with [fastqc](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

```
fastqc --noextract SRR1039508_1.fastq SRR1039508_2.fastq
```


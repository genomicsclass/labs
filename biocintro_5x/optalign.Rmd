# Short video of mapping RNA-Seq reads

Note that the commands used in this lab require you have a lot of free disk space (the FASTQ files alone are 28 GB) and many cores available for running the alignment program. We do not expect students to replicate the commands in this video. We do not expect students install the alignment software on their machines. Much of the software for processing NGS data is designed for Linux systems. Note that the case studies (in particular the variant discovery and genotyping case study) will go into more depth on using Linux for processing NGS data.

The FASTQ file we are looking at in the beginning of this screencast was downloaded from:

http://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR1177756

This is a human RNA-Seq sample from a [study](http://trace.ncbi.nlm.nih.gov/Traces/sra/?study=SRP032775) of naturally acquired immunity to malaria.

We discuss the following software in the screencast:

* fastq-dump from the [SRA toolkit](http://www.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=show&f=software&m=software&s=software)
* [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
* [Tophat2](http://ccb.jhu.edu/software/tophat/index.shtml)
* [Samtools](http://samtools.sourceforge.net/)

To extract the FASTQ files from the SRA file, we used the following line. The `--split-files` argument is used to extract two files for the two paired-ends of the fragments which were sequenced.

```
fastq-dump --split-files SRR1177756.sra
```

The call for running Tophat2 was:

```
export BOWTIE2_INDEXES=/path/to/your/Bowtie2Index

tophat2 -o SRR1177756_tophat_out -p 10 genome SRR1177756_1.fastq SRR1177756_2.fastq
```

To view the reads we used Samtools:

```
samtools view accepted_hits.bam | head -1000 | less
```

For demonstration purposes (you wouldn't necessarily repeat these lines in a typical workflow), we merged the mapped and unmapped reads into a single sorted file. For this we used the following calls:

```
samtools sort -n accepted_hits.bam accepted_hits_name_sorted
samtools sort -n unmapped.bam unmapped_name_sorted
samtools merge -n all_reads.bam accepted_hits_name_sorted.bam unmapped_name_sorted.bam
```


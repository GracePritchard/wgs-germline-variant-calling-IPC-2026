#!/bin/bash

# Alineamiento de las lecturas contra el genoma de referencia hg38 con BWA-MEM2.
# Input: data/raw/{sample_id}_R1.fastq.gz, data/raw/{sample_id}_R2.fastq.gz, data/reference/hg38.fa
# Output: results/bam/{sample_id}.bam, results/bam/{sample_id}.bam.bai

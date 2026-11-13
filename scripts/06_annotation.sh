#!/bin/bash

# Anotación funcional de variantes con Ensembl VEP (usando dbSNP y la caché local de VEP).
# Input: results/vcf/{sample_id}.filtered.vcf.gz, data/reference/dbsnp.vcf.gz, data/reference/vep_cache
# Output: results/vcf/{sample_id}.annotated.vcf.gz

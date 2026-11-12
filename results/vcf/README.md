# results/vcf
 
En esta carpeta se encuentran los ficheros de variantes (VCF) generados en las tres últimas etapas del pipeline:
 
1. `{sample_id}.raw.vcf.gz`: variantes obtenidas con GATK HaplotypeCaller (`04_variant_calling.sh`).
2. `{sample_id}.filtered.vcf.gz`: variantes tras el filtrado con GATK VariantFiltration (`05_variant_filtering.sh`).
3. `{sample_id}.annotated.vcf.gz`: variantes filtradas y anotadas con VEP (`06_annotation.sh`).
Cada fichero se acompaña de su índice (`.tbi`).
 
Estos ficheros se han excluido del repositorio mediante el `.gitignore`.

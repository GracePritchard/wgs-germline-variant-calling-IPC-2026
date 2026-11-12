# results/bam
 
En esta carpeta se encuentran los ficheros de alineamiento generados por `scripts/02_alignment.sh` (las lecturas alineadas contra el genoma de referencia hg38 con BWA-MEM2).
 
Para cada muestra se generan dos ficheros: `{sample_id}.bam` y su índice `{sample_id}.bam.bai`. Estos ficheros se utilizan como entrada del control de calidad (`03_bam_qc.sh`) y de la llamada de variantes (`04_variant_calling.sh`).
 
Dado que los ficheros BAM de WGS ocupan decenas de GB por muestra, se han excluido del repositorio mediante el `.gitignore`.

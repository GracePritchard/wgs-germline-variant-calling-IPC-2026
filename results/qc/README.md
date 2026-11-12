# results/qc
 
En esta carpeta se encuentran los informes de control de calidad generados en dos etapas del pipeline:
 
1. `{sample_id}_R1_fastqc.html` y `{sample_id}_R2_fastqc.html`: informes de FastQC sobre las lecturas en bruto (`01_fastq_qc.sh`).
2. `{sample_id}_metrics.txt`: métricas del alineamiento obtenidas con Picard (`03_bam_qc.sh`).

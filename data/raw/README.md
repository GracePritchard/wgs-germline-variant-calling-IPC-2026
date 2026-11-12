# data/raw
 
En esta carpeta se encuentran los datos de secuenciación en bruto (FASTQ) que se utilizan como entrada del pipeline.
 
Los ficheros siguen la nomenclatura `{sample_id}_R1.fastq.gz` y `{sample_id}_R2.fastq.gz` (lecturas *paired-end*), donde `sample_id` debe coincidir con el indicado en `config/samples.tsv`.
 
*Nota*: Dado que los ficheros FASTQ de WGS ocupan varios GB por muestra, se excluyen del repositorio mediante el `.gitignore`. 

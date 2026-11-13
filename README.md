# Detección de variantes germinales (SNVs e INDELs) en genoma completo (WGS)

[![Genoma de referencia](https://img.shields.io/badge/genoma-hg38-blue)](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.26/)
[![Datos](https://img.shields.io/badge/datos-WGS-green)](data/)
![Variantes](https://img.shields.io/badge/variantes-SNV%20%7C%20INDEL-purple)
[![Entorno](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)
[![Scripts](https://img.shields.io/badge/scripts-Bash-4EAA25?logo=gnubash&logoColor=white)](scripts/)
![Estado](https://img.shields.io/badge/estado-proyecto%20docente-orange)
[![Licencia: MIT](https://img.shields.io/badge/licencia-GPLv3-yellow.svg)](LICENSE)

Este repositorio contiene un pipeline para la detección de variantes germinales de tipo SNV (*single nucleotide variants*) e INDEL (inserciones y deleciones) a partir de datos de secuenciación de genoma completo (WGS), utilizando como referencia el genoma humano hg38.

> [!WARNING]
> **Proyecto docente: simulación con fines exclusivamente académicos.**
>
> Este repositorio se ha creado para la asignatura _Introducción a la Programación Científica_ del Máster en Bioinformática de la UNIR, con el objetivo de practicar el uso de Git y GitHub. **No es un pipeline funcional ni validado.**
>
> Los scripts son esqueletos (pueden estar vacíos) y los resultados son ficheros de ejemplo. **No debe usarse para análisis científicos ni clínicos.**


## Objetivo

El objetivo del proyecto es, a partir de los ficheros FASTQ de cada muestra, obtener un fichero VCF con las variantes filtradas y anotadas.

## Pipeline

El pipeline consta de seis pasos, cada uno implementado en un script de la carpeta `scripts/`:

1. `01_fastq_qc.sh`: control de calidad de las lecturas en bruto (FastQC).
2. `02_alignment.sh`: alineamiento contra hg38 (BWA-MEM2).
3. `03_bam_qc.sh`: control de calidad del alineamiento (Picard).
4. `04_variant_calling.sh`: llamada de variantes (GATK HaplotypeCaller).
5. `05_variant_filtering.sh`: filtrado de variantes (GATK VariantFiltration).
6. `06_annotation.sh`: anotación de variantes (VEP).

## Estructura del repositorio

```
config/  # configuración del pipeline (config.yaml, samples.tsv)
data/    # datos de entrada: FASTQ (raw/) y referencia (reference/)
envs/    # entorno conda con las herramientas necesarias
results/ # resultados: control de calidad (qc/), BAM (bam/) y VCF (vcf/)
scripts/ # scripts de cada paso del pipeline
```

Cada carpeta contiene un README con la descripción de los ficheros que se encuentran en ella. Dado que los ficheros FASTQ, BAM y VCF ocupan varios GB por muestra, se han excluido del repositorio mediante el `.gitignore`.

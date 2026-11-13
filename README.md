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

```mermaid
flowchart LR
    FASTQ[("FASTQ<br/>lecturas en bruto")]
    REF[("hg38.fa<br/>referencia")]
    DBSNP[("dbSNP")]
    CACHE[("Caché de VEP")]

    S1["01 · FastQC<br/>control de calidad"]
    S2["02 · BWA-MEM2<br/>alineamiento"]
    S3["03 · Picard<br/>métricas del BAM"]
    S4["04 · HaplotypeCaller<br/>llamada de variantes"]
    S5["05 · VariantFiltration<br/>filtrado"]
    S6["06 · VEP<br/>anotación"]

    BAM[("BAM")]
    RAW[("raw.vcf.gz")]
    FIL[("filtered.vcf.gz")]
    ANN[("annotated.vcf.gz")]

    FASTQ --> S1
    FASTQ --> S2
    REF --> S2
    S2 --> BAM
    BAM --> S3
    BAM --> S4
    REF --> S4
    DBSNP --> S4
    S4 --> RAW
    RAW --> S5
    S5 --> FIL
    FIL --> S6
    CACHE --> S6
    S6 --> ANN

    classDef paso fill:#dbeafe,stroke:#1d4ed8,color:#000
    classDef dato fill:#fef9c3,stroke:#a16207,color:#000
    classDef final fill:#dcfce7,stroke:#15803d,color:#000

    class S1,S2,S3,S4,S5,S6 paso
    class FASTQ,REF,DBSNP,CACHE,BAM,RAW,FIL dato
    class ANN final
```

## Estructura del repositorio

```
config/  # configuración del pipeline (config.yaml, samples.tsv)
data/    # datos de entrada: FASTQ (raw/) y referencia (reference/)
envs/    # entorno conda con las herramientas necesarias
results/ # resultados: control de calidad (qc/), BAM (bam/) y VCF (vcf/)
scripts/ # scripts de cada paso del pipeline
```

Cada carpeta contiene un README con la descripción de los ficheros que se encuentran en ella. Dado que los ficheros FASTQ, BAM y VCF ocupan varios GB por muestra, se han excluido del repositorio mediante el `.gitignore`.

## Instalación

### Requisitos

- [Conda](https://docs.conda.io/) (o [Miniconda](https://docs.conda.io/en/latest/miniconda.html))
- Sistema Linux (algunas herramientas, como BWA-MEM2, están pensadas para Linux x86_64 )
- Espacio en disco para la referencia, la caché de VEP y los resultados (varios GB por muestra)

### Pasos

1. Clona el repositorio:

   ```bash
   git clone https://github.com/<usuario>/wgs-germline-variant-calling-IPC-2026.git
   cd wgs-germline-variant-calling-IPC-2026
   ```

2. Crea el entorno con todas las herramientas:

   ```bash
   conda env create -f envs/environment.yml
   ```

3. Actívalo:

   ```bash
   conda activate wgs-germline-variant-calling
   ```

4. Comprueba que las herramientas están disponibles:

   ```bash
   fastqc --version
   bwa-mem2 version
   samtools --version
   gatk --version
   vep --help
   ```

## Preparación de los datos

Los datos no se incluyen en el repositorio (ver [`data/`](data/)). Antes de ejecutar el pipeline hay que:

1. Colocar los FASTQ de cada muestra en `data/raw/`.
2. Descargar el genoma hg38 en `data/reference/` y generar sus índices:

   ```bash
   samtools faidx data/reference/hg38.fa
   gatk CreateSequenceDictionary -R data/reference/hg38.fa
   bwa-mem2 index data/reference/hg38.fa
   ```

3. Descargar dbSNP y la caché de VEP en `data/reference/`:

   ```bash
   vep_install -a cf -s homo_sapiens -y GRCh38 -c data/reference/vep_cache
   ```

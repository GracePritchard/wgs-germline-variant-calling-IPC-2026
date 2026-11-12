# data/reference
 
En esta carpeta se encuentran los ficheros de referencia y las bases de datos necesarias para ejecutar el pipeline:
 
- **Genoma de referencia hg38** (`hg38.fa`), junto con sus índices (`.fai`, `.dict` y los índices de BWA-MEM2).
- **dbSNP** (`dbsnp.vcf.gz`), que se utiliza para asignar los identificadores rs a las variantes.
- **Caché de VEP** (`vep_cache/`), necesaria para la anotación de las variantes.
Las rutas a cada uno de estos ficheros se definen en `config/config.yaml`.
 
Dado que se trata de ficheros de gran tamaño, se excluyen del repositorio mediante el `.gitignore`.

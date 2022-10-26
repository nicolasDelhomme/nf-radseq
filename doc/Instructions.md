# Geese project

## Note 
`nextflow` version >= 22 is needed

## Setup

1. Link the raw_data to the project:
  ```{bash}
  ln -s /mnt/picea/projects/labs/gspong/P22652_Bean_Goose_RAD raw_data
  ```
2. Use the `src/R/metadata_creation.R` script to generate the metadata and link the raw data to the `data/fastq` folder

## Run
```{bash}
nextflow run main.nf
```

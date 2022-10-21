#' ---
#' title: "Metadata creation"
#' author: "Nicolas Delhomme"
#' date: "`r Sys.Date()`"
#' output:
#'  html_document:
#'    toc: true
#'    number_sections: true
#'    code_folding: hide
#' ---
#' # Setup
#' * Libraries
suppressPackageStartupMessages({
  library(dplyr)
  library(here)
  library(readr)
})

#' * Sample info
samples <- read_tsv(here("raw_data/00-Reports/G.Spong_21_01_sample_info.txt"),
         col_names=c("NGI_ID","User_ID"),skip=1,
         col_types=cols_only(NGI_ID=col_character(),
                             User_ID=col_character())) %>% 
  filter(!grepl("NaSAC",User_ID))

#' # Metadata
metadata <- t(sapply(samples$NGI_ID,function(smpl){
  files <- list.files(here("raw_data/trimmomatic"),pattern=smpl,full.names=TRUE)
  names <- sub("R2_001","trimmed_2",sub("R1_001","trimmed_1",sub("trim_","",basename(files))))
  file.symlink(files,here("data/fastq/",names))
  return(file.path("data/fastq",list.files(here("data/fastq"),pattern=smpl)))
}))
colnames(metadata) <- c("RF","RS")

metadata <- cbind(metadata,data.frame(
  Id=rownames(metadata),
  NumId=1:nrow(metadata),
  Population="default"))

#' # Export
write_csv(file=here("data/metadata.csv"),metadata)

#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```

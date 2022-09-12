library("tidyverse")

install.packages("tidyverse")
install.packages("BiocManager")

BiocManager::install("SummarizedExperiment")
BiocManager::install("tidyverse")

rna <- read_csv("data/rnaseq.csv")
rna

## select

select(rna, 
       gene, sample, tissue, 
       expression)

rna[, 
    c("gene", 
      "sample", 
      "tissue", 
       "expression")]

## filter

filter(rna, sex == "Male")

rna[rna$sex == "Male", ]

unique(rna$sex)
table(rna$sex)


filter(rna, 
       sex == "Male" & 
         infection == "NonInfected")

names(rna)

rna$hsapiens_homolog_associated_gene_name

## Ex: filter onservations that do 
## have a human homolog

is.na(c(1, 2, 3, NA))

!is.na(c(1, 2, 3, NA))

rna_no_na <- filter(rna, 
       !is.na(hsapiens_homolog_associated_gene_name))

## Ex: of those observations, only show 
## gene and hsapiens_homolog_associated_gene_name

select(rna_no_na, gene, 
       hsapiens_homolog_associated_gene_name)

## pipe operators: %>%, |>

filter(rna, 
       !is.na(hsapiens_homolog_associated_gene_name)) %>% 
  select(gene, hsapiens_homolog_associated_gene_name)

rna %>% 
  filter(!is.na(hsapiens_homolog_associated_gene_name)) %>% 
  select(gene, hsapiens_homolog_associated_gene_name)

## Filter (keep) male observations and display
## gene, sample, tissue and expression in 
## one single command using the %>%


filter(rna, sex == "Male") %>% 
  select(gene, sample, tissue, expression)

rna %>% 
  filter(sex == "Male") %>% 
  select(gene, sample, tissue, expression)

## Using pipes, subset the rna data to 
## keep genes with an expression higher 
## than 50000 in female mice at time 0, 
## and retain only the columns gene, 
## sample, time, expression and age

rna %>% 
  filter(sex == "Female" & 
           expression > 50000 &
           time == 0) %>% 
  select(gene, sample, time, expression,
         age, sex)

rna %>% 
  filter(sex == "Female", 
         expression > 50000,
         time == 0) %>% 
  select(gene, sample, time, expression,
         age, sex)

## mutate

rna %>% 
  mutate(time_hours = time * 24) %>% 
  select(time, time_hours)

rna %>% 
  mutate(time_hours = time * 24) %>%
  mutate(time_mn = time_hours * 60) %>% 
  select(time, time_hours, time_mn)

rna %>% 
  mutate(time_hours = time * 24,
         time_mn = time_hours * 60) %>% 
  select(time, time_hours, time_mn)


## Create a new data frame from the rna 
## data that meets the following criteria: 
## contains only the gene, chromosome_name, 
## phenotype_description, sample, and expression 
## columns and a new column giving the log 
## expression of the genes. This data frame must 
## only contain genes located on autosomes and 
## associated with a phenotype_description.










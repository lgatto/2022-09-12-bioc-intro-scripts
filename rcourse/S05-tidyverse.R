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

rna %>% 
  filter(chromosome_name != "X" &
           chromosome_name != "Y")

rna %>% 
  filter(chromosome_name != "X",
         chromosome_name != "Y",
         !is.na(phenotype_description))

rna %>% 
  filter(!chromosome_name %in% c("X", "Y")) %>% 
  filter(!is.na(phenotype_description)) %>% 
  mutate(log_expression = log(expression)) %>% 
  select(gene, chromosome_name,
         phenotype_description, 
         sample, 
         log_expression)


## group_by and summarise

rna %>% 
  group_by(gene)

rna %>% 
  group_by(sample)

rna %>% 
  group_by(sample, gene)

rna %>% 
  group_by(gene) %>% 
  summarise(mean_expression = 
              mean(expression))

rna %>% 
  group_by(gene) %>% 
  summarise(mean_expression = 
              mean(expression), 
            media_expression = 
              median(expression))

table(rna$gene)

rna %>% 
  filter(gene == "Atat1") %>% 
  pull(expression) %>% 
  mean()

rna %>% 
  group_by(gene) %>% 
  summarise(mean_expression = 
              mean(expression)) %>% 
  filter(gene == "Atat1")

rna %>% 
  group_by(gene, 
           infection, 
           time) %>% 
  summarise(mean_expression = 
              mean(expression))

## Calculate the mean and median expression 
## levels of gene “Dok3” by timepoints.


rna %>% 
  group_by(gene, time) %>% 
  summarise(mean_e = mean(expression),
            med_e = median(expression)) %>% 
  filter(gene == "Dok3")

rna %>% 
  group_by(time) %>% 
  filter(gene == "Dok3") %>% 
  summarise(mean_e = mean(expression),
            med_e = median(expression))

rna %>% 
  group_by(gene, time, expression)

## count, arrange, desc

rna %>% 
  count()

rna %>% 
  count(infection)

rna %>% 
  group_by(infection) %>% 
  summarise(n = n())

rna %>% 
  count(infection, time)
rna %>% 
  count(infection, time) %>% 
  arrange(time)

rna %>% 
  count(infection, time) %>% 
  arrange(desc(time))

## Ex 1

count(rna, sample)

rna %>% 
  count(sample)

## Ex 2

rna %>% 
  group_by(sample) %>% 
  summarise(depth = sum(expression)) %>% 
  arrange(desc(depth)) %>% 
  head(1)
  
rna %>% 
  filter(sample) %>% 
  summarise(depth = sum(expression)) %>% 
  filter(depth == max(depth))

## Ex 3

rna %>% 
  filter(sample == "GSM2545336") %>% 
  count(gene_biotype)

## Ex 4

rna %>% 
  filter(phenotype_description == 
           "abnormal DNA methylation") %>% 
  mutate(log_e = log(expression)) %>% 
  group_by(time, gene) %>% 
  summarise(mean_e = mean(log_e))

rna %>% 
  filter(phenotype_description == 
           "abnormal DNA methylation") %>% 
  group_by(time, gene) %>% 
  summarise(mean_e = mean(log(expression)))

## reshaping data: 
##  pivot_wider() and pivot_longer()


rna_exp <- rna %>% 
  select(gene, sample, expression)

rna_wide <- rna_exp %>% 
  pivot_wider(names_from = sample, 
              values_from = expression)

rna %>% 
  select(gene, sample, expression) %>% 
  pivot_wider(names_from = sample, 
              values_from = expression)

rna_wide
        
anyNA(rna_wide)

rna_long <- rna_wide %>% 
  pivot_longer(names_to = "sample", 
               values_to = "expression",
               -gene)
rna_long

rna_wide %>% 
  pivot_longer(names_to = "sample", 
               values_to = "expression",
               2:23)

rna_wide %>% 
  pivot_longer(names_to = "sample", 
               values_to = "expression",
               starts_with("GSM"))


## Ex 

rna_xy <- rna %>% 
  filter(chromosome_name == "X" |
           chromosome_name == "Y") %>% 
  group_by(sex, chromosome_name) %>% 
  summarise(mean = mean(expression))

rna_xy %>% 
  pivot_wider(names_from = sex,
              values_from = mean)

## export  

write_csv(rna_wide, 
          file = "data_output/rna_wide.csv")  

write.csv(rna_wide, 
          file = "data_output/rna_wide2.csv")  






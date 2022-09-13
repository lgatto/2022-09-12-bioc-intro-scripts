rna <- read_csv("data/rnaseq.csv")

counts <- rna %>%
  select(gene, sample, expression) %>%
  pivot_wider(names_from = sample, 
              values_from = expression)
count_matrix <- counts %>%
  select(-gene) %>%
  as.matrix()
rownames(count_matrix) <- counts$gene

# sample annotation
sample_metadata <- rna %>%
  select(sample, organism, age, sex, 
         infection, strain, time, tissue, mouse) %>%
  distinct()

# gene annotation
gene_metadata <- rna %>%
  select(gene, chromosome_name, gene_biotype) %>%
  distinct()

library(SummarizedExperiment)
# BiocManager::install("SummarizedExperiment")

all(colnames(count_matrix) == sample_metadata$sample)
all(rownames(count_matrix) == gene_metadata$gene)

count_matrix <- count_matrix[, sample_metadata$sample]

se <- SummarizedExperiment(
  assays = list(counts = count_matrix),
  colData = sample_metadata, 
  rowData = gene_metadata
)

se[1:5, 1:3]

sesub <- se[1:5, 1:3]
assays(sesub)$counts
rowData(sesub)
colData(sesub)

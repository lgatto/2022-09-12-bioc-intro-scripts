download.file(url = "https://github.com/Bioconductor/bioconductor-teaching/raw/master/data/GSE96870/rnaseq.csv",
              destfile = "data/rnaseq.csv")

# Folder not existing
download.file(url = "https://github.com/Bioconductor/bioconductor-teaching/raw/master/data/GSE96870/rnaseq.csv",
              destfile = "data2/rnaseq.csv")

rna <- read.csv("data/rnaseq.csv")
rna
head(rna)
str(rna)
dim(rna)
names(rna)
head(rownames(rna))
summary(rna)

rna[1, 1]
rna[1, ]
rna[c(2, 4, 7), ]
rna[, 1]
head(rna[, 1, drop = FALSE])
rna[, "gene"]
unique(rna[, "gene"])
str(unique(rna[, "gene"]))
length(unique(rna[, "gene"]))
rna$gene

write.csv(rna, file = "data_output/my_rna.csv")



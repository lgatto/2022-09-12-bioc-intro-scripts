library(tidyverse)
rna <- read_csv("data/rnaseq.csv")

# ggplot(data = <DATA>,
#        mapping = aes(<MAPPING>)) +
#   <GEOM>()

ggplot(data = rna, mapping = aes(x = expression)) + 
  geom_histogram()

my_plot <- ggplot(data = rna, mapping = aes(x = expression)) + 
  geom_histogram()
my_plot

ggplot(data = rna, mapping = aes(x = expression)) + 
  geom_histogram(bins = 10)
ggplot(data = rna, mapping = aes(x = expression)) + 
  geom_histogram(binwidth = 5000)

ggplot(data = rna, mapping = aes(x = expression)) + 
  geom_histogram(binwidth = 10)

## Exercise: generate a new data set as follows:
# 1. Add a column expression_log =  log2(expression + 1)
# 2. Keep only gene, time, gene_biotype, expression_log columns
# 3. Calculate the mean expression for each gene at each time point (don't lose the biotype!)
# 4. Reshape so that each time point is in its own column
# 5. Calculate the two log-fold changes (8-0 and 4-0) and add as columns
rna_fc <- rna %>% 
  mutate(expression_log = log2(expression + 1)) %>%
  select(gene, time, gene_biotype, expression_log) %>%
  group_by(gene, time, gene_biotype) %>%
  summarize(mean_exp = mean(expression_log)) %>%
  pivot_wider(names_from = time, 
              values_from = mean_exp) %>%
  mutate(time_8_vs_0 = `8` - `0`, 
         time_4_vs_0 = `4` - `0`)

rna_fc2 <- rna %>% 
  mutate(expression_log = log2(expression + 1)) %>%
  select(gene, time, gene_biotype, expression_log) %>%
  mutate(time = paste("time_", time, sep = "")) %>%
  group_by(gene, time, gene_biotype) %>%
  summarize(mean_exp = mean(expression_log)) %>%
  pivot_wider(names_from = time, 
              values_from = mean_exp) %>%
  mutate(time_8_vs_0 = time_8 - time_0, 
         time_4_vs_0 = time_4 - time_0)

ggplot(rna_fc, aes(x = time_4_vs_0, y = time_8_vs_0)) + 
  geom_point()

ggplot(rna_fc, aes(x = time_4_vs_0, y = time_8_vs_0)) + 
  geom_point(color = "blue", alpha = 0.5)

ggplot(rna_fc, aes(x = time_4_vs_0, y = time_8_vs_0)) + 
  geom_point(aes(color = gene_biotype))

ggplot(rna_fc, aes(x = time_4_vs_0, y = time_8_vs_0,
                   color = gene_biotype)) + 
  geom_point()

ggplot(rna_fc) + 
  geom_point(aes(x = time_4_vs_0, y = time_8_vs_0,
                 color = gene_biotype))

## Take the rna data, add an expression_log column as
## before, make a scatter plot of expression_log 
## vs sample ID
rna <- rna %>%
  mutate(expression_log = log2(expression + 1))
ggplot(rna, aes(x = sample, y = expression_log)) + 
  geom_point(aes(color = gene_biotype))

ggplot(rna, aes(x = sample, y = expression_log)) + 
  geom_boxplot() + 
  geom_jitter(color = "red")

ggplot(rna, aes(x = sample, y = expression_log)) + 
  geom_boxplot() + 
  geom_jitter(color = "red") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

## Line plots
## Find genes to plot
genes_to_keep <- rna_fc %>%
  arrange(desc(time_8_vs_0)) %>%
  pull(gene) %>%
  head(10)
sub_rna <- rna %>%
  filter(gene %in% genes_to_keep)
mean_exp_by_time <- sub_rna %>%
  group_by(gene, time) %>%
  summarize(mean_exp = mean(expression_log))

ggplot(mean_exp_by_time, 
       aes(x = time, y = mean_exp)) + 
  geom_line()

ggplot(mean_exp_by_time, 
       aes(x = time, y = mean_exp, group = gene)) + 
  geom_line()

ggplot(mean_exp_by_time, 
       aes(x = time, y = mean_exp, color = gene)) + 
  geom_line()

ggplot(mean_exp_by_time, 
       aes(x = time, y = mean_exp)) + 
  geom_line() + 
  facet_wrap(~gene)

ggplot(mean_exp_by_time, 
       aes(x = time, y = mean_exp)) + 
  geom_line() + 
  facet_wrap(~gene, scales = "free")

ggsave(filename = "mean_exp_over_time_2.png")

my_plot <- ggplot(mean_exp_by_time, 
                  aes(x = time, y = mean_exp)) + 
  geom_line() + 
  facet_wrap(~gene, scales = "free")
ggsave(filename = "mean_exp_over_time_3.png", plot = my_plot)

pdf("my_multipage_plot.pdf")
my_plot
my_plot
dev.off()




1+2
13/7
weight_kg <- 55
weight_kg
2.2 * weight_kg
weight_lb <- 2.2 * weight_kg
weight_lb
weight_kg <- 60
weight_lb
# Update weight_lb
weight_lb <- 2.2 * weight_kg
weight_lb

sqrt(12)

round(3.14)
round(3.14, digits = 1)
round(digits = 1, x = 3.14)
round(1, 3.14)
round(3.14, 1)

# Vectors
weight_kg <- c(50, 60, 65, 82)
length(weight_kg)

molecules <- c("rna", "dna", "protein")
class(weight_kg)
class(molecules)

num_char <- c(1, 2, 3, "hello")
class(num_char)

my_logical <- TRUE
num_log <- c(1, 2, 3, TRUE)

# Challenge
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

# Subsetting
molecules <- c("dna", "rna", "peptide", "protein")
molecules[2]
molecules[c(2, 4)]
molecules[c(1, 4, 3, 2, 4, 3, 1)]
molecules
molecules_sub <- molecules[c(2, 4)]

molecules[-2]
molecules[c(-2, -4)]
molecules[0]
molecules[5]

molecules[2]
molecules[c(FALSE, TRUE, FALSE, FALSE)]
molecules == "rna"
molecules != "rna"
molecules[molecules != "rna"]
toKeep <- molecules != "rna"
molecules[toKeep]

weight_g <- c(30, 35, 36, 32)
mouse_sex <- c("M", "M", "F", "F")
weight_g[mouse_sex == "M"]

weight_g > 31
weight_g >= 35
weight_g < 32
weight_g <= 32

(mouse_sex == "M") & (weight_g > 32)

molecules
molecules == "rna"
molecules == "rna" | molecules == "dna"
molecules %in% c("rna", "dna")
## Don't do this
molecules == c("rna", "dna")
molecules == c("rna", "dna", "peptide", "protein")

# Names
x <- c(1, 3, 7, 2)
names(x)
names(x) <- c("A", "B", "C", "D")
x
names(x)
x["B"]
x[2]

# Missing values
heights <- c(2, 4, 4, NA, 6)
mean(heights)
max(heights)
mean(heights, na.rm = TRUE)

c(1, 3, 5)
c(1, 2, 1, 2, 1, 2)
rep(c(1, 2), 3)
c(1, 2, 3, 4, 5)
1:5
seq(from = 1, to = 5, by = 2)


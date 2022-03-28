
# Load Packages and Data --------------------------------------------------

# Load Packages
library(psych)
library(tidyverse)
library(skimr)

# Load Data
df <- read_csv("data/bfi.csv")

# Descriptive Statistics
summary(df)

# Explore Data (skimr)
skim(df)

# Pre-processing ----------------------------------------------------------

# Select Data
df_factor <- df %>%
  select(-c(gender, education, age))

# Create Correlation
cor_factor <- cor(df_factor)
cor_factor

# Assumption Test ---------------------------------------------------------

# KMO Test
KMO(cor_factor)

# 0.00 to 0.49 unacceptable
# 0.50 to 0.59 miserable
# 0.60 to 0.69 mediocre
# 0.70 to 0.79 middling
# 0.80 to 0.89 meritorious
# 0.90 to 1.00 marvelous

# Bartlett’s test
cortest.bartlett(cor_factor, n = 2236)

# Factor Analysis ---------------------------------------------------------

# Determine number of factor (Scree Plot)
scree(df_factor, pc = FALSE, hline = -1)

# Determine number of factor (Parralel)
fa.parallel(df_factor)

# Factor Analysis
efa <- fa(r = cor_factor, nfactors = 6)

# Show Result
efa

# Loads
loads <- efa$loadings
fa.diagram(loads)

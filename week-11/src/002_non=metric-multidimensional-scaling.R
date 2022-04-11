# Non Metric  Multidimensional Scaling (Nominal or Ordinal)

# Load Packages and Data --------------------------------------------------

# Load Packages
library(tidyverse)
library(MASS)
library(ggpubr)

# Import Data
df <- read_csv("data/chocolate.csv")

# Measure Distance
distance <- df %>%
  t() %>%
  dist()

# Kruskal’s Non-Metric Multidimensional Scaling ---------------------------

# Compute Kruskal’s Non-Metric Multidimensional Scaling
mds <- distance %>%
  isoMDS() 

# Check Stress Value
mds[["stress"]]

# > 20 : Very Poor (not worth doing)
# 10 - 19.9 : Fair
# 5 - 9.9 : Good
# 2.5 - 4.9 : Good
# 0 - 2.49 : Near Perfect Fit

# Make it as dataframe
df_mds <- mds[["points"]] %>%
  as_tibble() %>%
  rename(dim1 = V1, dim2 = V2)

# Visualize
df_mds %>%
  ggscatter( x = "dim1", y = "dim2", 
             label = colnames(df),
             repel = TRUE)

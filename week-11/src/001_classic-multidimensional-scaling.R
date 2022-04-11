# Classical/Metric Multidimensional Scaling (Interval or Ratio)

# Load Packages and Data --------------------------------------------------

# Load Packages
library(tidyverse)
library(haven)
library(ggpubr)

# Import Data
df <- read_sav("data/tv-indonesia.sav") %>%
  dplyr::select(-FACTORS) 

# Measure Distance
distance <- df  %>%
  t() %>%
  dist()

# Classic Multidimensional Scaling ----------------------------------------

# Compute Classic Multidimensional Scaling
mds <- distance %>%
  cmdscale() 

# Make it as dataframe
df_mds <- mds %>%
  as_tibble() %>%
  rename(dim1 = V1, dim2 = V2)

# Visualize
df_mds %>%
  ggscatter( x = "dim1", y = "dim2", 
          label = colnames(df),
          repel = TRUE)
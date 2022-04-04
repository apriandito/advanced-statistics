# Load library
library(tidyverse)
library(janitor)
library(cluster)
library(factoextra)

# Import data
df <- read_csv("data/mall-customer.csv") %>%
  clean_names()

# View Data
df

# Melihat Data dengan glimpse
glimpse(df)

# Standardisasi
df_scaled <- df %>%
  select(-c(customer_id, gender)) %>%
  mutate_at(c("age", "annual_income_k", "spending_score_1_100"), scale)
head(df_scaled)

# Mencari jumlah kluster optimal dengan elbow method
fviz_nbclust(df_scaled, kmeans, method = "wss")

# Mencari nilai kluster optimal dengan silhouette method
fviz_nbclust(df_scaled, kmeans, method = "silhouette")

# Melakukan kmean clustering
cluster <- kmeans(df_scaled, centers = 8)
cluster

# Visualisasi cluster
fviz_cluster(cluster, data = df_scaled, geom = "point")

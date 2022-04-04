
# Load Package and Data ---------------------------------------------------

# Load library
library(tidyverse)
library(readxl)
library(cluster)
library(factoextra)

# Import data
df <- read_csv2("data/income-spend.csv")

# Melihat Keseluruhan Data
df

# Lihat Deskriptif Statistik
summary(df)

# Visualisasi Dalam Scatter Plot
df %>%
  ggplot(aes(x = Income, y = Spending)) +
  geom_point()

# Select Data
df_cluster <- df %>%
  select(Income, Spending)
head(df_cluster)

# K-Means Clustering ------------------------------------------------------

# Mencari jumlah kluster optimal dengan elbow method
fviz_nbclust(df_cluster, kmeans, method = "wss")

# Mencari nilai kluster optimal dengan silhouette method
fviz_nbclust(df_cluster, kmeans, method = "silhouette")

# Melakukan kmean clustering
kmeans_cluster <- kmeans(df_cluster, centers = 2)
kmeans_cluster

# Visualisasi cluster
fviz_cluster(kmeans_cluster,
  data = df_cluster,
  geom = "point"
)

# Hierarchical Clustering -------------------------------------------------

# Mencari jumlah kluster optimal dengan elbow method
fviz_nbclust(df_cluster, hcut, method = "wss")

# Mencari nilai kluster optimal dengan silhouette method
fviz_nbclust(df_cluster, hcut, method = "silhouette")

# Melakukan Hierarchical clustering
h_cluster <- hcut(
  df_cluster,
  k = 2,
  hc_func = "agnes"
)
h_cluster

# Dendogram
fviz_dend(h_cluster)

# Visualisasi cluster
fviz_cluster(h_cluster,
  data = df_cluster,
  geom = "point"
)

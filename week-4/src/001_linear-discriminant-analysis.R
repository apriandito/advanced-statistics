# Set Parameter -----------------------------------------------------------

# Set Seed
set.seed(123)

# Load Packages -----------------------------------------------------------

library(tidyverse)
library(easystats)
library(MVN)
library(MASS)
library(biotools)
library(mvnormalTest)

# Import Data -------------------------------------------------------------

df <- read_csv("data/iris.csv") %>%
  mutate(Species = as_factor(Species))

# Assumption Test ---------------------------------------------------------

# Multivariate Normality (1)
df %>%
  dplyr::select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) %>%
  mhz()

# Multivariate Normality (2)
df %>%
  dplyr::select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) %>%
  mvn(univariateTest = "SW")

# Homogeneity of Variance/Covariance
boxM(
  data = df[c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")],
  grouping = df[["Species"]]
)

# Split Data --------------------------------------------------------------

# Create Split Index
split_index <- sort(sample(nrow(df), nrow(df) * 0.7))

# Create Train Data
df_train <- df[split_index, ]

# Create Test Data
df_test <- df[-split_index, ]

# Linear Discriminant Analysis --------------------------------------------

lda_model <- lda(Species ~ ., data = df_train)
lda_model

plot(lda_model,
  col = as.integer(df_train[["Species"]])
)

# Evaluation --------------------------------------------------------------

# Make a prediction
df_pred <- predict(lda_model, newdata = df_test)

# Confusion Matrix
c_table <- table(
  actual = df_test[["Species"]],
  predicted = df_pred[["class"]]
)

# Get Performance Statistics
confusionMatrix(c_table)

# Set Parameter -----------------------------------------------------------

# Set Seed
set.seed(123)

# Load Packages -----------------------------------------------------------

library(tidyverse)
library(janitor)
library(skimr)
library(readxl)
library(GGally)
library(car)

# Import Data -------------------------------------------------------------

# Import Excel Data
df <- read_xlsx("data/pima-indians.xlsx")

# Data Exploration --------------------------------------------------------

# Show first 6 row
head(df)

# Check data type
glimpse(df)

# Check data
skim(df)

# Pair Plot
ggpairs(df)

# Data Preprocessing ------------------------------------------------------

# Fix Data
df_fix <- df %>%
  dplyr::select(-c(triceps, insulin)) %>%
  mutate(diabetes = case_when(
    diabetes == "pos" ~ 1,
    diabetes == "neg" ~ 0
  )) %>%
  mutate(diabetes = as_factor(diabetes)) %>%
  drop_na()

# Split Data --------------------------------------------------------------

# Create Split Index
split_index <- sort(sample(nrow(df_fix), nrow(df_fix) * 0.7))

# Create Train Data
df_train <- df_fix[split_index, ]

# Create Test Data
df_test <- df_fix[-split_index, ]

# Logistic Regression -----------------------------------------------------

# Create Logistic Regression Model
lr_model <- glm(diabetes ~ pregnant + glucose + mass + pedigree, data = df_train, family = binomial)

# Check Model Summary
summary(lr_model)

# Plot Residual
plot(lr_model, 1)

# Plot QQ-plot
plot(lr_model, 2)

# Check Multicolinerity
vif(lr_model)

# Evaluation --------------------------------------------------------------

# Make a prediction
pred <- predict(lr_model,
  newdata = df_test,
  type = "response"
)

# Convert to a Class
df_pred_class <- ifelse(pred > 0.5, 1, 0)

# Confusion Matrix
c_table <- table(
  actual = df_test[["diabetes"]],
  predicted = df_pred_class
)

# Get Performance Statistics
confusionMatrix(c_table)

# Predict New Data --------------------------------------------------------

# Create New Obaservation
df_new_obs <- tibble(
  pregnant = 1,
  glucose = 89,
  mass = 33,
  pedigree = 2.288
)

# Make a prediction
new_pred <- tibble(prob = predict(lr_model,
  newdata = df_new_obs,
  type = "response"
)) %>%
  mutate(class = ifelse(new_pred > 0.5, 1, 0))

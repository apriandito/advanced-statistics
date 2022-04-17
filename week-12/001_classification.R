# Load Packages and Import Data -------------------------------------------

# Load package
library(tidyverse)
library(tidymodels)
library(rpart)
library(rpart.plot)

# Import Data
df <- read_csv("data/customer-churn.csv")

# Explore Data ------------------------------------------------------------

# Show first 5 row
head(df)

# Check Data
glimpse(df)

# Please find out number of customer churn and not churn

# Do more exploration

# Split Data --------------------------------------------------------------

# Set Seed
set.seed(1234)

# Split Data 70:30
df_split <- initial_split(df, prop = 0.7)
df_split

# Show Training Data
df_split %>%
  training() %>%
  glimpse()

# Set Target and Predictor
df_recipe <- training(df_split) %>%
  recipe(Churn ~ tenure + MonthlyCharges + Contract) %>%
  prep()
df_recipe

# Apply to training data
df_training <- juice(df_recipe)
glimpse(df_training)

# Apply to testing data
df_testing <- df_recipe %>%
  bake(testing(df_split))
glimpse(df_testing)


# Training ----------------------------------------------------------------

# Set Model
dt <- decision_tree() %>%
  set_engine("rpart") %>%
  set_mode("classification")

# Create Workflow
workflow <- workflow() %>%
  add_model(dt) %>%
  add_recipe(df_recipe)

# Train
model <- fit(workflow, training(df_split))

# Show Model
tree_fit <- model %>%
  extract_fit_parsnip()
rpart.plot(tree_fit$fit)

# Evaluation --------------------------------------------------------------

# Make A Prediction
model %>%
  predict(df_testing) %>%
  bind_cols(df_testing)

# Set Evaluation Metric
multi_metrics <- metric_set(accuracy, precision, recall, specificity, f_meas)

# Show Model Performance
model %>%
  predict(df_testing) %>%
  bind_cols(df_testing) %>%
  multi_metrics(truth = Churn, estimate = .pred_class)

# Use Model for Prediction ------------------------------------------------

# Import New Data
df_new <- read_csv("data/customer-churn.csv")
head(df_new)

# Make A prediction
df_predicted <- predict(model, df_new) %>%
  bind_cols(df_new)

# See the prediction
df_predicted

# Save prediction result
write_csv(df_predicted, "data/customer-churn_predicted.csv")

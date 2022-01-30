
# Install & Load Package --------------------------------------------------

# Install Packages
install.packages("tidyverse")
install.packages("easystats", repos = "https://easystats.r-universe.dev")

# Load Packages
library("tidyverse")
library("easystats")

# Load Data ---------------------------------------------------------------

# Load Data
df <- read_csv("data/heart.csv") %>%
  select(-...1)

# Statistical Report
report(df)

# Check Correlation
correlation(df)

# Modelling

# Create Model
model <- lm(heart.disease ~ biking + smoking, data = df)

# Check Model -------------------------------------------------------------

# Check Parameter
model_parameters(model)

# Plot Parameters
plot(parameters(model))

# Model Report
report(model)

# Check Model Assumption
check_model(model)

# Check Normality
check_normality(model)

# Check Heteroscedasticity
check_heteroscedasticity(model)

# Check multicollineariy
check_collinearity(model)

# Check Autocorrelation
check_autocorrelation(model)

# Model Performance
model_performance(model)

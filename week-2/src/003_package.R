
# Install and Load Packages -----------------------------------------------

# Install packages from CRAN
install.packages("tidyverse")

# Load Packages
library("tidyverse")

# Check Package Section

# Install Packages from another Repo
install.packages("easystats", repos = "https://easystats.r-universe.dev")

library("easystats")

# Use Package -------------------------------------------------------------

# Load Data
df <- read_csv("data/heart.csv")

# Fix Data
df_fix <- df %>%
  select(-...1)

# Get Data Report
report(df_fix)

# Box Plot
df_fix %>%
  ggplot(aes(y = biking)) +
  geom_boxplot()

# Scatter Plot
df_fix %>%
  ggplot(aes(x = biking, y = heart.disease)) +
  geom_point(color = "red")

# Correlation
df_cor <- correlation(df_fix)

# Correlation Details
df_cor

# Correlation Matrix
summary(df_cor, redundant = TRUE)

# Correlation Plot
df_cor %>%
  summary(redundant = TRUE) %>%
  plot()

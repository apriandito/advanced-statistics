
# Load Packages -----------------------------------------------------------

# Load Packages
library(lavaan)
library(tidyverse)
library(semPlot)

# Load Data
data(PoliticalDemocracy)

# Structural Equation Modeling --------------------------------------------

# Create Model
model <- '
  # measurement model
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + y6 + y7 + y8
  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60
  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'

# Fit Model
fit <- sem(model, data = PoliticalDemocracy)

# CFI ≥ .90 (Bentler, 1992; Byrne, 2001)
# RMSEA ≤ .06 (Hu & Bentler, 1999)
# SRMR ≤ .08 (MacCallum et al., 1996; Hu & Bentler, 1999)

# AIC/BIC bisa digunakan untuk membandingkan dengan model yang lain
# AIC/BIC semakin rendah semakin baik/parsimoni

# See Result
summary(fit, fit.measures = TRUE, standardized=TRUE)

# Correlation
inspect(fit, what="cor.all")

# See Plot
semPaths(fit)





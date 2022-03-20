# Load Packages -----------------------------------------------------------

# Load Packages
library(seminr)
library(tidyverse)

# Import Data
education <- read_csv("data/education.csv")

# Print Data
print(education)


# Create Construct --------------------------------------------------------

# Create Measurement Model
education_mm <- constructs(
  reflective("Advising", multi_items("adv.",c("comp","acces","comm","qual"))),
  reflective("Tutoring", multi_items("tut.",c("prof","sched","stud","qual"))),
  reflective("Value", multi_items("val.",c("devel","deci","meet", "info"))),
  reflective("Satisfaction", multi_items("sat.",c("glad","expe","over"))))

# Create Structural Model
education_sm <- relationships(
  paths(from = "Tutoring", to = c("Value","Satisfaction")),
  paths(from = "Advising",to = c("Value","Satisfaction")),
  paths(from = "Value",to = "Satisfaction"))


# PLS ---------------------------------------------------------------------

# Create PLS Model
education_pls <- estimate_pls(
  data = education,
  measurement_model = education_mm,
  structural_model = education_sm
)

# See Model Summary
ms <- summary(education_pls)

# Loadings 
ms$loadings

# Composite Reliability
ms$reliability 

# Cross Loadings / Discriminant Validity
ms$cross_loadings 

# Multicolinearity
model_summary$vif_items

# R Square
model_summary$path 


# Bootstrapping -----------------------------------------------------------

# Botsraping
education_bm <- bootstrap_model(seminr_model = education_pls,
                                seed = 123)

# Summary of bootsrap model
summary(education_bm)
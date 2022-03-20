# Install Packages
install.packages("conjoint")
install.packages("tidyverse")

# Load Packages
library(conjoint)
library(tidyverse)
library(fpc)

# Import Data
data(ice)

# Lihat masing-masing data
iprof
ilevn
ipref

# Utilities
utilities <- caUtilities(y=ipref, x=iprof, z=ilevn)

# Importance
importance <- caImportance(y = ipref, x = iprof)
importance

# Visualize Importance
barplot(importance, 
        names.arg = c("flavour", "price", "container", "topping"),
        ylab = "Average Importance", xlab = "Attributes")

# Complete Result
Conjoint(y=ipref, x=iprof, z=ilevn)

# Membuat Cluster
segments <- caSegmentation(y=ipref, x=iprof,c = 2)
segments

# Visualisasi Cluster
plotcluster(segments$util,segments$sclu)
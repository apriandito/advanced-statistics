# Import Data to R Environment --------------------------------------------

# Load Data
df <- read.csv("data/heart.csv")

# Show Data
View(df)

# Show the first 6 rows
head(df)

# Fix Data ----------------------------------------------------------------

# Select Variable Biking, Smoking, Heart Disease
df_fix <- df[c("biking", "smoking", "heart.disease")]

# Show Data
View(df_fix)

# Explore Data ------------------------------------------------------------

# Check Missing Values
sum(is.na(df))

# Find Out Mean
mean_biking <- mean(df_fix[["biking"]])

# Print Mean
mean_biking

# Find Out Median
median_biking <- median(df_fix[["biking"]])
median_biking

# Show All Basic Statistics Information (Central Tendency)
summary(df_fix)

# Variance
variance_biking <- var(df_fix[["biking"]])
variance_biking

# Plot Box Plot
boxplot(df_fix[["biking"]])

# Plot Distribution
plot(density(df_fix[["heart.disease"]]))

# Check Normality QQplot
qqnorm(df_fix[["heart.disease"]])
qqline(df_fix[["heart.disease"]], col = "red")

# Normality Test (Shapiro-Wilk)
shapiro.test(df_fix[["biking"]])

# Visualize Scatter Plot
plot(df_fix[["biking"]], df_fix[["heart.disease"]])

# Correlation Matrix
df_cor <- cor(df_fix, method = "pearson")

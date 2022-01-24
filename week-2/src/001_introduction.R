# Say Hi To R!
print("Hi R!")

# This is a comment, You can write whatever you want after "#"

# Try to run this code, well dont block it. Just enjoy the flow
1 * 2
3 * 3
4 * 5

# Write your own code

# This is a section (Ctrl + Shift + R) ------------------------------------

# Help separate our code or analysis sections


# Variable Assignment -----------------------------------------------------

# Can use "<-"
variable_1 <- 10

# Can use "=", But please be consistent
variable_2 <- 20

# Print Variable
print(variable_1)

# Or Directly write the name
variable_1

# Use Case
jumlah_penumpang <- 10
harga_tiket <- 20000

total_harga <- jumlah_penumpang * harga_tiket
total_harga

# Data Type ---------------------------------------------------------------

# Declare Variable
var_numeric <- 1
var_integer <- 1L
var_character <- "1"

# Check Data type
typeof(var_character)

# So what? You might get an error if .....
var_new <- var_character + var_integer

# Other Data Type
var_logical <- TRUE

# Plese check it

# Data Structure ----------------------------------------------------------

# How to store multiple value at 1 variable?

# Vector (Only one data type) use "c()"
ex_vector <- c(1, 2, 3)
age <- c(23, 24, 26, 34, 21)

# List (Multiple data types) use "list()"
ex_list <- list(1, "2", TRUE)

# Table? use Dataframe, put some vector on in
ex_dataframe <- data.frame(
  nama = c("Dito", "Pute", "Rosidi"),
  usia = c(23, 24, 27)
)

# Get mean of age
mean(age)

# Get mean of usia in dataframe
mean(ex_dataframe$usia)

# Get mean of usia in dataframe (Another Way)
mean(ex_dataframe[["usia"]])

# Now you are a Ranger ---------------------------------------------------

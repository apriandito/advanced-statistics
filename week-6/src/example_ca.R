# Library
library(conjoint)

# Run with Ctrl + Enter

experiment<-expand.grid(
  durasi= c("1 jam","2 jam","3 jam"),
  pengajar =c("Akademisi","Praktis"),
  harga = c("100 Ribu","200 Ribu","300 Ribu"),
  sertifikat=c("yes","no"))

design = caFactorialDesign(data=experiment, type="orthogonal")

level <- tibble(levels = c("1 jam","2 jam","3 jam", "Akademisi","Praktis",
                           "100 Ribu","200 Ribu","300 Ribu", "yes","no"))

responden <- read_csv2("data/pref.csv")

Conjoint(y = responden, x = design, z = level)

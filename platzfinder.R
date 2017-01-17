library(dplyr)
library(ggplot2)

colN <- c("Bibliothek", "Belegt", "Leer", "Datum")
d <- read.csv2("data.csv", stringsAsFactors = TRUE, col.names = colN, colClasses = c("factor", "numeric", "numeric", "POSIXct"), header = FALSE, encoding = "UTF-8", na.strings = "Geschlossen")



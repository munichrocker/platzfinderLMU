library(dplyr)
library(ggplot2)
library(lubridate)

colN <- c("Bibliothek", "Belegt", "Leer", "Datum")
d <- read.csv2("data.csv", stringsAsFactors = TRUE, col.names = colN, colClasses = c("factor", "numeric", "numeric", "POSIXct"), header = FALSE, encoding = "UTF-8", na.strings = "Geschlossen")

#Remove Test-Data and create new columns
d %>% 
  filter(Datum > "2016-12-17 23:45:29") %>% 
  mutate(weekday = weekdays.POSIXt(Datum), hour = hour(Datum)) -> w

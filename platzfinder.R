library(dplyr)
library(ggplot2)
library(lubridate)

colN <- c("Bibliothek", "Belegt", "Leer", "Datum")
d <- read.csv2("data.csv", stringsAsFactors = TRUE, col.names = colN, colClasses = c("factor", "numeric", "numeric", "POSIXct"), header = FALSE, encoding = "UTF-8", na.strings = "Geschlossen")

#Remove Test-Data and create new columns
d %>% 
  filter(Datum > "2016-12-17 23:45:29") %>% 
  mutate(weekday = weekdays.POSIXt(Datum), hour = hour(Datum)) -> w

# create tbl_df for weekend and weekday with mean per hour
w %>% 
  select(Bibliothek, Belegt, weekday, hour) %>% 
  filter(complete.cases(.)) %>% 
  filter(weekday != "Samstag" & weekday != "Sonntag") %>% 
  group_by(hour) %>% 
  summarise(mean(Belegt)) -> week

#Make copy of w-df
w_nas <- w
#replace NAs with 0
w_nas[is.na(w_nas$Belegt),]$Belegt <- 0

for (i in 8:23){
  w_help = NULL
  
  w_nas %>% 
    filter(hour==i) %>% 
    group_by(Bibliothek) %>% 
    summarise(mean(Belegt)) -> w_help
  
  ggplot(w_nas, aes(mean(Belegt)))
}

w_nas %>% 
  filter(hour==11) %>% 
  group_by(Bibliothek) %>% 
  summarise(mean = mean(Belegt)) -> w_help

png("test.png", width = 500, units = "px", pointsize = 14)
ggplot(w_help, aes(Bibliothek, mean)) +
  geom_bar(stat="identity", fill = "#008659") +
  coord_flip() +
  theme(axis.title = element_blank(), plot.title = element_text(hjust = 2.7, face = "bold", size = 18)) +
  labs(title = paste("Besetze Plätze in den UB-Bibs um", "11", "Uhr")) +
  scale_y_continuous(limits = c(0, 100))
dev.off()
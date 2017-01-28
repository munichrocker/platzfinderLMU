library(dplyr)
library(ggplot2)
library(lubridate)
library(extrafont)
library(grid)

colN <- c("Bibliothek", "Belegt", "Leer", "Datum")
d <- read.csv2("data.csv", stringsAsFactors = TRUE, col.names = colN, colClasses = c("factor", "numeric", "numeric", "POSIXct"), header = FALSE, encoding = "UTF-8", na.strings = "Geschlossen")

#Remove Test-Data and create new columns, filter out Christmas-Time
d %>% 
  filter(Datum > "2016-12-17 23:45:29") %>% 
  filter(Datum <= "2016-12-23 23:59:59" | Datum >= "2017-01-02 00:00:00") %>% 
  mutate(weekday = weekdays.POSIXt(Datum), hour = hour(Datum)) -> w

w$weekday <- factor(w$weekday, levels = c("Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"))

# create tbl_df for weekend and weekday with mean per hour
w %>% 
  select(Bibliothek, Belegt, weekday, hour, Datum) %>%
  filter(Datum <= "2016-12-23 23:59:59" | Datum >= "2017-01-02 00:00:00") %>% 
  filter(complete.cases(.)) %>% 
  filter(weekday != "Samstag" & weekday != "Sonntag") %>% 
  group_by(hour) %>% 
  summarise(mean(Belegt)) -> week

## Plotting Weekday vs Weekend
ggplot() +
  geom_line(data = weekend, aes(hour, `mean(Belegt)`), color = "#590086", size = 1.3) +
  geom_area(data = weekend, aes(hour, `mean(Belegt)`), color = "#dd9aff", alpha = 0.2) +
  geom_line(data = week, aes(hour, `mean(Belegt)`), color = "#865900", size = 1.3) +
  geom_area(data = week, aes(hour, `mean(Belegt)`), fill = "#ffd686", alpha = 0.6) +
  labs(title = "Belegung im Tagesverlauf", subtitle = "Braun: Werktag, Blau: Wochenende") +
  ylab("Belegung in Prozent") + 
  xlab("Stunden") +
  theme_bw() +
  theme(text = element_text(size = 12),
        plot.margin = unit(c(1, 1, 4, 1), "lines"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.border = element_blank())

## Plotting Every day by hour
w %>% 
  select(Bibliothek, Belegt, weekday, hour, Datum) %>%
  filter(Datum <= "2016-12-23 23:59:59" | Datum >= "2017-01-02 00:00:00") %>% 
  filter(complete.cases(.)) %>% 
  group_by(weekday, hour) %>% 
  summarise(mean = mean(Belegt)) -> weekday_by_hour

# gelöst mit Facets ggbfalls mit nrow rumspielen
ggplot(weekday_by_hour, aes(hour, mean)) +
  geom_line() +
  facet_wrap(~ weekday, nrow = 1) +
  ylab("Belegung in Prozent") +
  xlab("Zeit")

# gelöst in einem Plot
svg("weekday_per_hour.svg", pointsize = 28, width = 11.78, height = 8.39)
g1 <- ggplot(weekday_by_hour, aes(x = interaction(weekday, hour, lex.order = TRUE), y = mean, group = 1)) +
  geom_line(colour = "#008659", size = 1.3) +
  geom_area(fill = "#86ffd6", alpha = 0.5) +
  coord_cartesian(ylim = c(0, 65), expand = FALSE) +
  annotate(geom = "text", x = seq_len(nrow(weekday_by_hour)), y = -1, label = weekday_by_hour$hour, size = 2) +
  annotate(geom = "text", x = 9 + 16 * (0:6), y = -4, label = unique(weekday_by_hour$weekday), size = 5) +
  theme_bw() +
  theme(text = element_text(size = 12),
        plot.margin = unit(c(1, 1, 4, 1), "lines"),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.border = element_blank()) +
  geom_hline(yintercept = mean(weekday_by_hour$mean), linetype = 3) +
  ylab("Durchschnittsbelegung in Prozent") +
  ggtitle("Bib-Belegung im Wochenmittel")

g2 <- ggplot_gtable(ggplot_build(g1))
g2$layout$clip[g2$layout$name == "panel"] <- "off"
grid::grid.draw(g2)
dev.off()
##
# Create PNG for each Hour of the Day
###
#Make copy of w-df
w_nas <- w
#replace NAs with 0
w_nas[is.na(w_nas$Belegt),]$Belegt <- 0

#Debugging needed for the hjust of plot.title
for (i in 8:23){
  w_help = NULL

  w_nas %>% 
    filter(hour==i) %>% 
    group_by(Bibliothek) %>% 
    summarise(mean = mean(Belegt)) -> w_help
  print(head(w_help))
  
  png(paste0(i,".png"), width = 500, units = "px")
  p <- ggplot(w_help, aes(Bibliothek, mean)) +
    geom_bar(stat="identity", fill = "#008659") +
    coord_flip() +
    theme(text = element_text(family = "Arial"), axis.title = element_blank(), plot.title = element_text(face = "bold", size = 18)) +
    labs(title = paste("Besetzte UB-Plätze um", i, "Uhr")) +
    scale_y_continuous(limits = c(0, 100))
  print(p)
  dev.off()
}

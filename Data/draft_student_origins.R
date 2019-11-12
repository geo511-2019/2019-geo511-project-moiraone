library(readr)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(RColorBrewer)

origins <- read_csv("suny_student_origins.csv")

ggplot(origins, aes(x = Region, y = Value, 
               fill = Key))+
  geom_col(position = position_stack(reverse = FALSE))+
  scale_fill_brewer(palette = "Paired")+
  theme(axis.text.x = element_text(angle = 90, 
                                   hjust = 1),
        axis.text = element_text(size = 7),
        legend.text = element_text(size = 7),
        legend.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 7),
        axis.ticks = element_blank(),
        plot.caption = element_text(size = 6)
          )+
  labs(title = "SUNY Student Origins by Region",
       y = "Percent of Total Students",
       caption = "Data: Rockefeller Impact Report"
       )
  
  
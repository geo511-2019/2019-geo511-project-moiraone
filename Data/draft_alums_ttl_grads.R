library(readr)
library(ggplot2)
library(dplyr)
library(RColorBrewer)

grad_retention <- read_csv("grad_retention_percent_ttl_grads.csv")

view(grad_retention)

ggplot(grad_retention, aes(x = Region, y = Value,
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
        plot.caption = element_text(size = 6),
        legend.key.size = unit(0.4, "cm")
  )+
  labs(title = "SUNY Alums as a Percent of Regional Graduates",
       y = "Percent of Total Graduates",
       caption = "Data: Rockefeller Impact Report")
---
title: 'A regionalized SUNY Impact Assessment'
author: "Moira O'Neill"
date: "11/7/2019"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Introduction

The State University of New York (SUNY) is one of the largest public higher education systems in the country, with 64 total institutions spread across 10 state regions.  These regions are highly varied, and include a megacity, the rural periphery, and several old industrial cities experiencing population loss.  The institutions are varied too, and include research universities, comprehensive colleges, community colleges, and technical institutes.

SUNY's heterogenous geographic and institutional structure is designed to facilitate access and cultivate human capital at several degree levels.  This is explicit in SUNY's stated mission: to recognize the "fundamental role of its responsibilities in undergraduate education and [to provide] a full range of graduate and professional education that reflects the opportunity for individual choice and the needs of society" (suny.edu).

How well does the SUNY system fulfill this mission at the regional and state scales?  The following study offers a preliminary regionalized assessment of how effectively the system promotes geographic access, contributes to an educated workforce, and matches human capital to area labor market demand.  A conclusion section highlights the strengths of the system as well as several opportunities for improvement.


```{r map, echo = TRUE}

# population map, outline regions, institutional locations

```

## Where do SUNY students come from?

The majority of SUNY students attend college within their own region.  The two exceptions are New York City, which draws the most out-of-state students, and Southern Tier, which is home to Cornell University and attracts the largest number of international students.  

Mohawk Valley, home to the well-regarded comprehensive college SUNY Geneseo, draws a large number of non-regional in-state students.

```{r students, echo = TRUE}

#stacked bar plot

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

```

## Where do SUNY students end up?

The relative importance of SUNY alumni - and regional schools - to sub-state labor markets varies widely.  For example, SUNY graduates make up a dispropotionate part of total graduates in rural parts of the state like Mohawk Valley and North Country.  Despite making up a smaller share of total graduates in the Capital District, SUNY graduates are about 35% of the total workforce there (which is highly educated on the whole).  

SUNY graduates in New York City were mostly educated outside of the region.  The opposite is true of Western New York; of the more than 60% of area graduates that are SUNY alums, about 55% were educated at regional schools.  

```{r suny alums grads, echo = TRUE}

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

```

``` {r suny alums workforce, echo = TRUE}

library(readr)
library(ggplot2)
library(dplyr)
library(RColorBrewer)

grad_retention <- read_csv("grad_retention_percent_ttl_workforce.csv")

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
  labs(title = "SUNY Alums as a Percent of Regional Workforce",
       y = "Percent of Total Workforce",
       caption = "Data: Rockefeller Impact Report")


```

The level of educational attainment matters, too.  Graduates of technical, community, and comprehensive colleges are all more likely than research university graduates to remain in New York state 10 years after graduation.  

Of course, there is likely significant self-selection bias at work here, as students who prefer to remain close to home may opt to attend smaller local schools.  However, rather than diminish SUNY's role, such cases demonstrate the importance of providing a range of localized options to meet these students' needs.  Higher wage premiums (versus national median wages) at all levels of education reinforce the benefits of access.

``` {r institutional level and wages, retention, echo = TRUE}

library(readr)
library(knitr)
library(kableExtra)
library(latex2exp)

wage_retention <- read_csv("institution_retention_wages.csv")

kable(wage_retention, "latex", booktabs = T)


```


## How well do skills of local SUNY graduates match regional labor market needs?

An important dimension of any public university's impact is whether the skills of their graduates match labor market demand.  By comparing the types degrees held by alums as a percent of total regional jobs requiring a related degree (this data comes from the NY Department of Labor via the Rockefeller Center) to SUNY alums as a percent of total regional graduates (the dashed reference line), the series of bar plots below depict this skills (mis)match.

Overall, there is an impressive consistency between SUNY graduates' skills and regional labor markets.  But there are some notable mismatches.  In all cases, there is an oversupply of agricultural and art degrees.  The largest and most consistent undersupply is in hospitality.  Mohawk Valley, Long Island, and Western New York demonstrate the least perfect relationship between skills supplied and skills demanded. 
Because of how significant alums are to Mohawk Valley's labor pool, the skills mismatch in business, healthcare, education, law and public service, and social services is likely constraining economic growth in this region most dramatically.

```{r skillsmatch, echo = TRUE}

library(readr)

#load Skills Match Data from CSV file
skills <- read_csv("suny_skills_match_by_region.csv")

library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(egg)
library(gridExtra)

ggplot(skills) + 
  geom_col(aes(x = Field , y = Degrees, fill = Field), 
           position = "dodge")+
  scale_fill_brewer(palette = "Paired")+
  labs(x = "Field", 
       y = "SUNY Degrees as a % of Jobs Requiring One",
       caption = "--- SUNY graduates as a proportion of total regional graduates")+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank()
        )+
  geom_hline(aes(yintercept = Percent), 
             col = "Black", linetype = "dashed")+
  facet_wrap(~Region)+
  theme(legend.position = "bottom", 
        legend.box = "horizontal", 
        legend.text = element_text(size = 8),
        legend.key.size = unit(0.4, "cm"),
        legend.title = element_blank(),
        plot.caption = element_text(size = 7),
        axis.title.x = element_text(size = 10),
        axis.title.y = element_text(size = 10)
        )+
  ggtitle("Matching SUNY Graduates' Skills to Area Labor Markets")

```

## Regional Education Attainment and Income

There is abundant evidence that the social returns to education exceed the private returns, as higher educational attainment rates lead to productivity and wage gains for the entire workforce (Moretti 2004, 2012).  

Between 2005 and 2017, New York State's median educational attainment and income rates have consistently exceeded national rates.  But there is some variation within the state.  

[MORE HERE]

``` {r NY educational attainment, echo = TRUE}

library(readr)
library(dplyr)
library(ggplot2)
library(RColorBrewer)

regional_ed <- read_csv("suny_regional_education_tidy.csv")

#isolate NY and USA

NY <- regional_ed %>%
  filter(Region == "NY State")

USA <- regional_ed %>%
  filter(Region == "USA")

regional_ed1 <- regional_ed %>%
  filter(Region != "NY State") %>%
  filter(Region != "USA")

#plot education rates in each region

plot <- ggplot(data = regional_ed1, 
       aes(x = Year, 
           y = bach_or_higher, 
           col = Region))+ geom_line()+
  scale_color_brewer(palette = "Paired")

plot + geom_line(data = NY, 
                 aes(x = Year, y = bach_or_higher), 
                 col = "Black", size = 1)+
  geom_line(data = USA, 
            aes(x = Year, y = bach_or_higher), 
            col = "Black", linetype = "dashed", size = 1)+
  theme(panel.grid.major = element_blank())+
  labs(x = "Year", 
       y = "% Population with Bachelor's or Higher", 
       title = "Educational Attainment in New York State",
       caption = "Data compiled from US Census 5-year ACS Estimates"
         )

```


``` {r income, echo = TRUE}

#load necessary packages
library(readr)
library(tidyverse)
library(dplyr)

#load income data from .csv file
regional_income <- read_csv("suny_regional_income_data_tidy.csv")

#View data
View(regional_income)
colnames(regional_income)

#isolate NY and USA

NY <- regional_income %>%
  filter(Region == "NY State")

USA <- regional_income%>%
  filter(Region == "USA")

regional_income1 <- regional_income %>%
  filter(Region != "NY State") %>%
  filter(Region != "USA")

#load additional packages

library(RColorBrewer)
library(ggplot2)
library(directlabels)
library(lattice)

#build line graphs by year, with NY and USA as reference lines

base_plot <- ggplot(data = regional_income1, 
       aes(x = Year, y = Income, col = Region))+
  geom_line()

#add NY State and USA as reference lines

base_plot +
  geom_line(data = NY, 
            aes(x = Year, y = Income), 
            col= "Black", size = 1)+
  scale_color_brewer(palette = "Paired")+
  geom_line(data = USA, 
            aes(x = Year, y = Income), 
            col = "Black", linetype="dashed", size = 1)+
  theme(panel.grid.major = element_blank())+
  labs(x = "Year", 
       y = "Median Income", 
       title = "Median Incomes in New York State",
       caption = "Data compiled from U.S. 5-year ACS Estimates"
         )

```

## Conclusion

The SUNY system's ability to attract, shape, and retain human capital varies between regions.  

The system facilitates resident access through the strategic placement of the institutions themselves, and by offering a range of programs of study at various levels of depth.

[MORE HERE]



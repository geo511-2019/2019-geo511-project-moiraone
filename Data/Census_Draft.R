install.packages('tigris')

library(sp)
library(tigris)
library(tidyverse)
library(acs)
library(leaflet)
library(tidycensus)
library(RColorBrewer)

census_api_key("7912510ff91a51de560cf1e9160860875f062880")

ny_counties <- counties(state = 'NY')

plot(ny_counties)

county_pop <- get_estimates(geography = "county", 
              state = "NY", 
              product = "population",
              geometry = TRUE
              )

join <- geo_join(ny_counties, 
                 county_pop, "GEOID", "geometry")


ggplot()+
  geom_sf(data = join, aes(fill = "population"))+
  geom_sf(data = tidycensus:: county_laea,
          fill = NA,
          color = "black",
          lwd = 0.1) +
  scale_fill_brewer(palette = "Paired", 
                    direction = -1) +
  scale_color_brewer(palette = "Paired",
                     direction = -1,
                     guide = FALSE) +
  coord_sf(datum = NA) +
  labs(title = "Population",
       fill = "Population")






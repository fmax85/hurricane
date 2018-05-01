# Load and tidy ebrtk data
#
library(magrittr)
library(dplyr)
library(readr)
library(tidyr)
library(stringr)
library(lubridate)
#
# read source data
ext_tracks_widths <- c(7, 10, 2, 2, 3, 5, 5, 6, 4, 5, 4, 4, 5, 3, 4, 3, 3, 3,
                       4, 3, 3, 3, 4, 3, 3, 3, 2, 6, 1)
ext_tracks_colnames <- c("storm_id", "storm_name", "month", "day",
                         "hour", "year", "latitude", "longitude",
                         "max_wind", "min_pressure", "rad_max_wind",
                         "eye_diameter", "pressure_1", "pressure_2",
                         paste("radius_34", c("ne", "se", "sw", "nw"), sep = "_"),
                         paste("radius_50", c("ne", "se", "sw", "nw"), sep = "_"),
                         paste("radius_64", c("ne", "se", "sw", "nw"), sep = "_"),
                         "storm_type", "distance_to_land", "final")
ext_tracks <- read_fwf("ebtrk_atlc_1988_2015.txt",
                       fwf_widths(ext_tracks_widths, ext_tracks_colnames),
                       na = "-99")
#
# refactor quadrant radii
features <- c("storm_name", "year", "month", "day", "hour", "latitude", "longitude")
tmp <- ext_tracks %>% select(features, starts_with("radius_")) %>%
    filter(storm_name == "IKE") %>%
    gather(key, value, -features) %>%
    extract(key, c("wind_speed", "quadrant"), "(\\d+)_(..)") %>%
    spread(quadrant, value)
#
# add (remove) new (old) features
ike <- tmp %>% mutate(date = as.character(make_datetime(as.integer(year), as.integer(month),
                                                           as.integer(day), as.integer(hour)))) %>%
    mutate(longitude = -longitude) %>%
    mutate(storm_id = paste(str_to_title(storm_name), year, sep = "-")) %>%
    select(storm_id, date, latitude, longitude, wind_speed, ne, nw, se, sw)
#
# pick a single observation
ike_1 <- ike %>% filter(latitude > 29 & latitude < 30)

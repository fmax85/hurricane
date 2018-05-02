# Plot Louisiana map with Ike storm observation
#
library(ggmap)
library(ggplot2)
library(hurricane)
#
# pick a single observation
ike_1 <- ike %>% filter(latitude > 29 & latitude < 30)
title <- paste0(ike_1$date, ", scale_radii = 0.5")
h <- 3
#
map_plot <- get_map("Lousiana", zoom = 6, maptype = "toner-background", source = "stamen")
map <- map_plot %>% ggmap(extent = "device") +
    geom_hurricane(data = ike_1, mapping = aes(x = longitude, y = latitude, r_ne = ne,r_se = se, r_sw = sw,
                                               r_nw = nw, fill = wind_speed, colour = wind_speed,
                                               scale_radii = 0.5)) +
    scale_color_manual(name = "Wind speed (kts)", values = c("red", "orange", "yellow")) +
    scale_fill_manual(name = "Wind speed (kts)", values = c("red", "orange", "yellow")) +
    ggtitle(title)
ggsave("ike-13sep.png", width = 16/9*h, height = h)

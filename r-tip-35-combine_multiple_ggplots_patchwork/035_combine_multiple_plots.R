# Libraries ----
library(patchwork)
# library(ggridges)
# library(ggrepel)
# library(maps)
library(tidyverse)
# library(lubridate)

# Data transformation ----
txhousing_tbl <- txhousing %>% 
  dplyr::mutate(date = lubridate::make_date(year, month))

# Make Sub plots ----

## ** Time Series Plot ----

gg_tx_ts <- txhousing_tbl %>% 
  ggplot2::ggplot(ggplot2::aes(date, median, group = city)) +
  ggplot2::geom_line(color = "grey20", alpha = 0.25) +
  ggplot2::geom_smooth(
    ggplot2::aes(group = NULL),
    method = "loess",
    span = 0.1,
    se = FALSE,
    size = 2.5,
    color = "black"
  ) +
  hrbrthemes::theme_ipsum() +
  ggplot2::scale_y_continuous(labels = scales::dollar_format()) +
  ggplot2::labs(x = "", y = "", title = "Median house price over time")

gg_tx_ts

## ** Top cities Ridgeline plot ----

gg_tx_ridge <- txhousing_tbl %>% 
  tidyr::drop_na() %>% 
  # factor reorder city by median
  dplyr::mutate(
    city = factor(city) %>% 
      forcats::fct_reorder(median) %>% 
      forcats::fct_rev()
  ) %>% 
  # filter top 10 cities
  dplyr::filter(as.integer(city) %in% 1:10) %>% 
  
  ggplot2::ggplot(ggplot2::aes(x = median, y = forcats::fct_rev(city))) +
  ggridges::geom_density_ridges(
    color = "#18BC9C",
    fill = "gray10",
    alpha = 0.75,
    size = 1
  ) +
  hrbrthemes::theme_ipsum() +
  ggplot2::scale_x_continuous(labels = scales::dollar_format()) +
  ggplot2::labs(
    x = "Median House Price",
    y = "", 
    title = "Top 10 Cities by Medium House Price"
  )

gg_tx_ridge

## ** Texas Map ----

summarise_tbl <- txhousing_tbl %>% 
  dplyr::group_by(city) %>% 
  dplyr::summarise(median = median(median, na.rm = TRUE)) %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(city = stringr::str_to_lower(city))

tx_lon_lat_tbl <- maps::us.cities %>% 
  dplyr::filter(country.etc == "TX") %>% 
  dplyr::mutate(
    name = name %>% 
      stringr::str_sub(end = nchar(name) - 3) %>% 
      stringr::str_to_lower() %>% 
      stringr::str_trim()
  ) %>% 
  dplyr::left_join(summarise_tbl, by = c("name" = "city"))

texas_outline_tbl <- ggplot2::map_data("state", region = "texas") %>% 
  dplyr::as_tibble()

gg_tx_map <- tx_lon_lat_tbl %>% 
  tidyr::drop_na() %>% 
  
  ggplot2::ggplot(ggplot2::aes(x = long, y = lat, size = median)) +
  ggplot2::geom_polygon(
    data = texas_outline_tbl,
    ggplot2::aes(x = long, y = lat, group = group, size = NULL),
    color = "black",
    size = 1.5,
    fill = "#18BC9C"
  ) +
  ggplot2::geom_point() +
  ggrepel::geom_text_repel(
    ggplot2::aes(label = stringr::str_to_title(name)),
    max.overlaps = 5
  ) +
  ggplot2::coord_map() +
  ggplot2::theme_void() +
  ggplot2::labs(title = "Median Home Price by City", x = "", y = "") +
  ggplot2::theme(legend.position = "none")

gg_tx_map

# Patchwork ----

gg_tx_map +
  (gg_tx_ts/gg_tx_ridge) +
  patchwork::plot_layout(widths = c(3,2), tag_level = "new") +
  patchwork::plot_annotation(
    title = "Texas Real-Estate Statistics",
    subtitle = "The untold secrets of prime-real estate in Texas\n",
    tag_levels = "A",
    tag_prefix = "Fig. ",
    tag_suffix = ":"
  ) &
  ggplot2::theme(plot.tag.position = c(0,1),
                 plot.tag = ggplot2::element_text(size = 8, hjust = 0, vjust = 0))


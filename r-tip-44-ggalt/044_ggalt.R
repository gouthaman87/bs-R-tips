library(magrittr)
# 1.0 Data Wrangling ----
mpg <- ggplot2::mpg %>% 
  dplyr::select(hwy, year, model, class) %>% 
  tidyr::pivot_wider(
    names_from = year,
    values_from = hwy,
    id_cols = c(class, model),
    values_fn = function(x) mean(x, na.rm = TRUE),
    names_prefix = "year"
  ) %>% 
  dplyr::mutate(model = forcats::fct_reorder(model, year2008)) %>% 
  tidyr::drop_na()

mpg  


# 2.0 Visualization Dumbell plot ----

mpg %>% 
  ggplot2::ggplot(ggplot2::aes(x = year1999, xend = year2008, y = model, group = model)) +
  
  ggalt::geom_dumbbell(
    color = "#a3c4dc",
    colour_xend = "#0e668b",
    size = 2.0,
    dot_guide = TRUE,
    dot_guide_size = 0.15,
    dot_guide_colour = "grey60"
  ) +
  
  ggplot2::labs(
    title = "Change Vehicle Fuel Economy between 1999 & 2008",
    x = "Fuel Economy", y = "Vehicle Model"
  ) +
  tidyquant::theme_tq() +
  ggplot2::theme(
    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank(),
    panel.grid.minor.x = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
  )

# libraries ----

library(tidyverse)
library(ggdist)
library(tidyquant)

# Raincloud plots ----
# - Very powerful for visulaizing modality of distribution

mpg %>%
  dplyr::filter(cyl %in% c(4, 6, 8)) %>%
  ggplot2::ggplot(ggplot2::aes(x = factor(cyl), y = hwy, fill = factor(cyl))) +

  # add half violin from (ggdist) package
  ggdist::stat_halfeye(
    ## custom bandwidth
    adjust = 0.5,
    ## move geom to the right
    justification = -.2,
    ## remove slab interval
    .width = 0,
    point_colour = NA
  ) +
  ggplot2::geom_boxplot(
    width = .15,
    # remove outliers
    outlier.color = NA,
    alpha = 0.5
  ) +
  # add dot plots from (ggdist) package
  ggdist::stat_dots(
    ## orientation to the left
    side = "left",
    ## move geom to the left
    justification = 1.1,
    ## adjust grouping (binning) of observation
    binwidth = .25
  ) +
  tidyquant::scale_fill_tq() +
  tidyquant::theme_tq() +
  ggplot2::labs(
    title = "Raincloud plot",
    subtitle = "Showing the Bi-Modal distribution for 6 Cylinder vehicles",
    x = "Engine Size (# of Cylinders)",
    y = "Highway Fuel Economy (MPG)",
    fill = "Cylinders"
  ) +
  ggplot2::coord_flip()

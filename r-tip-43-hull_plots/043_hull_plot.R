# libraries ----

library(tidyverse)
library(ggforce)
library(tidyquant)

# Data ----

mpg

# Hull plot progression ----

ggplot2::mpg %>% 
  dplyr::mutate(engine_size = paste0("Cylinder: ", cyl)) %>% 
  
  ## Make base plot ----
  ggplot2::ggplot(ggplot2::aes(displ, hwy)) +
  ggplot2::geom_point() +
  
  ## Add cluster assignment ----
  ggforce::geom_mark_hull(
    ggplot2::aes(fill = engine_size, label = engine_size),
    concavity = 3
  ) +
  
  ## Add Theme & formating ----
  ggplot2::geom_smooth(se = FALSE, span = 1.0) +
  ggplot2::expand_limits(y = 50) +
  tidyquant::theme_tq() +
  tidyquant::scale_fill_tq() +
  ggplot2::labs(
    title = "Fuel Economy (MPG) Trends by Engine Size & Displacement",
    subtitle = "Hull plot to indicate clusters / group assignment",
    y = "Highway Fuel Economy (MPG)",
    x = "Engine Displacement Volume (Litres)",
    caption = "Engine size has a negative relationship to fuel economy."
  )
  

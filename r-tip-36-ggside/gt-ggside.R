# Youtube Link: https://www.youtube.com/watch?v=uojdfPZZBUE
# Blog Link: https://www.business-science.io/code-tools/2021/05/18/marginal_distributions.html?utm_content=bufferea3cc&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer

# Library ----
library(magrittr)
library(ggplot2)

# Data ----
ggplot2::mpg

# 1.0 ggside ----

## 1.1 Side Density ----
ggplot2::mpg %>% 
  ggplot2::ggplot(ggplot2::aes(hwy, cty, color = class)) +
  ggplot2::geom_point(size = 2, alpha = 0.3) +
  ggplot2::geom_smooth(ggplot2::aes(color = NULL), se = TRUE) +
  ggside::geom_xsidedensity(
    ggplot2::aes(y = ggplot2::after_stat(density), fill = class),
    alpha = 0.5,
    size = 1,
    position = "stack"
  ) +
  ggside::geom_ysidedensity(
    ggplot2::aes(x = ggplot2::after_stat(density), fill = class),
    alpha = 0.5,
    size = 1,
    position = "stack"
  ) +
  tidyquant::scale_color_tq() +
  tidyquant::scale_fill_tq() +
  tidyquant::theme_tq() +
  ggplot2::labs(
    title = "Fuel Economy by Vehicle Type",
    subtitle = "ggside density",
    x = "Highway MPG", y = "City MPG"
  ) +
  ggplot2::theme(
    ggside.panel.scale.x = 0.4,
    ggside.panel.scale.y = 0.4
  )

## 1.2 Side Box plot ----
ggplot2::mpg %>% 
  ggplot2::ggplot(ggplot2::aes(cty, hwy, color = class)) +
  ggplot2::geom_point() +
  ggplot2::geom_smooth(ggplot2::aes(color = NULL), se = TRUE) +
  ggside::geom_xsideboxplot(size = 1, alpha = 0.5) +
  tidyquant::scale_color_tq() +
  tidyquant::scale_fill_tq() +
  tidyquant::theme_tq() +
  ggplot2::facet_grid(cols = ggplot2::vars(cyl), scales = "free_y") +
  ggplot2::labs(title = "Fuel Economy by Engine Size (Cylinders)")
 
  
  
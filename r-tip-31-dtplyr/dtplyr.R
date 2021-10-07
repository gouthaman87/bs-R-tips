# Youyube link:https://www.youtube.com/watch?v=r0ricexnF6A

# Libraries ----

library(magrittr)
library(ggplot2)

# 1.0 Data Table ----

mpg_dt <- dtplyr::lazy_dt(ggplot2::mpg)

# Data wrangling ----

mpg_summary_dt <- mpg_dt %>% 
  dplyr::group_by(manufacturer, cyl) %>% 
  dplyr::summarise(
    dplyr::across(
      .cols = c(displ, cty:hwy),
      .fns = list(mean, median),
      .names = "{.fn}_{.col}"
    )
  ) %>% 
  dplyr::ungroup()

# Show the data.table transaltion
mpg_summary_dt %>% dplyr::show_query()

# Collect and convert to tibble
mpg_summary_df <- mpg_summary_dt %>% dplyr::collect()

# 2.0 ggplot ----

# * City Fuel Mileage Heat map ----

mpg_summary_df %>% 
  ggplot2::ggplot(ggplot2::aes(factor(cyl), manufacturer)) +
  ggplot2::geom_tile(ggplot2::aes(fill = mean_cty)) +
  ggplot2::geom_text(ggplot2::aes(label = round(mean_cty, 1)), size = 3) +
  viridis::scale_fill_viridis(direction = 1) +
  ggplot2::theme_minimal() +
  ggplot2::labs(
    title = "Average City Fuel Mileage by Engine Size",
    x = "Engine Size (Cylinders)",
    y = "Manufacturer",
    fill = "Average City Mileage"
  ) +
  ggplot2::theme(legend.position = "bottom")

# Libraries ----

library(tidyverse)
library(performance)
library(tidymodels)

# Data ----

mpg

# Fit Linear model ----

model_lm <- lm(hwy ~ displ + class, data = mpg)

model_lm

performance::check_model(model_lm)

# Tidymodel ----

model_lm_tidy <- parsnip::linear_reg(mode = "regression") %>% 
  parsnip::set_engine("lm") %>% 
  parsnip::fit(hwy ~ displ + class, data = mpg)

performance::check_model(model_lm_tidy)


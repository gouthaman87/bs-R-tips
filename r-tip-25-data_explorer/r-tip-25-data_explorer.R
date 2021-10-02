# Blog Link:https://www.business-science.io/code-tools/2021/03/02/use-dataexplorer-for-EDA.html?utm_content=buffer5598d&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer
# Youtube Link: https://www.youtube.com/watch?v=ssVEoj54rx4

# Libraries ----
library(DataExplorer)
library(tidyverse)
library(magrittr)

# Data ----
forcats::gss_cat

forcats::gss_cat %>% dplyr::glimpse()

# EDA Report ----
forcats::gss_cat %>% 
  DataExplorer::create_report(
    output_file = "gss_survey",
    output_dir = "r-tip-25-data_explorer/",
    y = "rincome",
    report_title = "EDA Report - GSS Demographic Survey"
  )

# Data Introduction ----

forcats::gss_cat %>% DataExplorer::introduce()

forcats::gss_cat %>% DataExplorer::plot_intro()

# Missing values ----

forcats::gss_cat %>% DataExplorer::plot_missing()

forcats::gss_cat %>% DataExplorer::profile_missing()

# Continuous features ----

forcats::gss_cat %>% DataExplorer::plot_density()

forcats::gss_cat %>% DataExplorer::plot_histogram()

# Categorical features ----

forcats::gss_cat %>% DataExplorer::plot_bar()

# Relationships ----

forcats::gss_cat %>% DataExplorer::plot_correlation()

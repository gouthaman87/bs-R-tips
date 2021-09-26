# Blog Link: https://www.youtube.com/watch?v=yoX1-xzsGUc
# Blog Link: https://www.business-science.io/r/2021/09/14/parallel-processing-furrr.html

# Library ----
library(tidyverse)
library(magrittr)
library(timetk)
library(lubridate)
library(furrr)
library(tictoc)

# data ----
sales_data_tbl <- timetk::walmart_sales_weekly %>% 
  dplyr::select(id = id, date = Date, value = Weekly_Sales) 

# 1.0 purrr ----
tictoc::tic()
sales_data_tbl %>% 
  tidyr::nest(data = c(date, value)) %>% 
  dplyr::mutate(
    model = purrr::map(data, function(df){
      Sys.sleep(1)
      lm(value ~ lubridate::month(date) + as.numeric(date), data = df)
    })
  )
tictoc::toc()

# 2.0 furrr (parallel processing) ----
plan(multisession, workers = 4)
tictoc::tic()
sales_data_tbl %>% 
  tidyr::nest(data = c(date, value)) %>% 
  dplyr::mutate(
    model = furrr::future_map(data, function(df){
      Sys.sleep(1)
      lm(value ~ lubridate::month(date) + as.numeric(date), data = df)
    })
  )
tictoc::toc()
  
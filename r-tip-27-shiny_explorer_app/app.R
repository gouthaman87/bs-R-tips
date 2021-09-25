
# Libraries ---------------------------------------------------------------

library(shiny)
library(bslib)
library(modeldata)
library(DataExplorer)
library(plotly)
library(tidyverse)

# Data --------------------------------------------------------------------

utils::data("stackoverflow", "car_prices", "Sacramento", package = "modeldata")

data_list <- list(
  "StackOverflow" = stackoverflow,
  "Car Prices" = car_prices,
  "Sacramento" = Sacramento
)

# 1.0 User Interface ----

ui <- shiny::navbarPage(
  
  title = "Data Explorer",
  
  theme = bslib::bs_theme(version = 4, bootswatch = "minty"),
  
  shiny::tabPanel(
    title = "Explore",
    
    shiny::sidebarLayout(
      
      shiny::sidebarPanel(
        width = 3,
        
        shiny::h1("Explore a Dataset"),
        
        # Requires reactive programming knowledge
        shiny::selectInput(
          inputId = "dataset_choice",
          label = "Data Connection",
          choices = c("StackOverflow", "Car Prices", "Sacramento")
        ),
        
        # Requires Bootstrap knowledge
        shiny::hr(),
        shiny::h3("Apps by LEGO")
      ),
      
      shiny::mainPanel(
        shiny::h1("Correlation"),
        plotly::plotlyOutput("corrplot", height = 700)
      )
    )
  )
)


# 2.0 Server ----

server <- function(input, output) {
  
  # Reactive Programming ----
  rv <- shiny::reactiveValues()
  
  shiny::observe(
    {
      rv$data_set <- data_list %>% purrr::pluck(input$dataset_choice)
    }
  )
  
  output$corrplot <- plotly::renderPlotly({
    g <- DataExplorer::plot_correlation(rv$data_set)
    
    plotly::ggplotly(g)
  })
  
}

# 3.0 Run the Application ----
shiny::shinyApp(ui = ui, server = server)
  
  
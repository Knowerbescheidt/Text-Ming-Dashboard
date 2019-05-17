require(shiny)
require(data.table)
source(
  paste0(
    "C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/",
    "collocations.R"
  ),
  local = TRUE
)

find_collocationUI <- function(id) {
  ns <- NS(id)
  tagList(
    actionButton(ns("get_coll"), label = "Show Collocations"),
    numericInput(
      ns("size"),
      label = "Size of the Collocation",
      min = 2,
      value = 3,
      max = 10,
      step = 1,
      width = 100
    ),
    textInput(
      ns("min_count"),
      placeholder = "lower cases",
      label = "Minimum Count of the Collocation",
      value = "10,20,30",
      width = 300
    ),
  dataTableOutput(ns("coll_table"),width = 300)  
    
  )
}

find_collocation <- function(input, output, session) {
  col_datatable <- eventReactive(input$get_coll, {
    if (typeof(input$min_count) == "double") {
      col_dataframe <- find_coll(
        Token_object = Token_data,
        size = input$size,
        min_count = input$min_count
      )
    col_datatable <- setDT(col_dataframe)
    return(col_datatable)
      }})
  output$coll_table <- renderDataTable(col_datatable)
    
  }

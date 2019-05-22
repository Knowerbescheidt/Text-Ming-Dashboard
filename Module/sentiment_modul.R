require(shiny)
require(data.table)
source(
  paste0(
    "C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/",
    "sentiment_analysis.R"
  ),
  local = TRUE
)

analyse_sentimentUI <- function(id) {
  ns <- NS(id)
  tagList(
    actionButton(ns("get_sentiment"), label = "Show Sentiment"),
    plotlyOutput(ns("bar_chart_sentiment"))
    
  #hier kann später noch ein Intervall hin--------
    )
}

analyse_sentiment <- function(input, output, session) {
  plot <- eventReactive(input$get_sentiment, {
    sentiment_analysis(Token_data)
  })
  output$bar_chart_sentiment <- renderPlotly({plot()})
  
}
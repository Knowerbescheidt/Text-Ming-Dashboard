source(paste0(getwd(),
              "/Funktionen/",
              "sentiment_analysis.R"),
       local = TRUE)
source(paste0(getwd(),
              "/Funktionen/",
              "data_prep_dfm.R"),
       local = TRUE)
#UI-------------------
analyse_sentimentUI <- function(id) {
  ns <- NS(id)
  tagList(actionButton(ns("get_sentiment"), label = "Show Sentiment"),
          plotlyOutput(ns("bar_chart_sentiment")))
}

#Server---------------
analyse_sentiment <- function(input, output, session) {
  plot <- eventReactive(input$get_sentiment, {
    sentiment_analysis(Token_data())
  })
  output$bar_chart_sentiment <- renderPlotly({
    plot()
  })
  
}

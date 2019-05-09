require(shiny)
source(paste0("C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/", "PlotteWord",".R"), local = TRUE)
source(paste0("C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/", "Data_prep",".R"), local = TRUE)

plot_wordUI <- function(id) {
  ns <- NS(id)
  tagList(
    textInput(
      ns("word_search"),
      placeholder = "lower cases",
      label = "word",
      value = "Beispiel",
      width = 600
    ),
    selectInput(
      ns("intervall_words"),
      label = "Intervall",
      choices = list(month = "month", year = "year")
    ),
    actionButton(ns("refresh_plot"), label = "Update Plot"),
    plotlyOutput(ns("bar_chart_word"))
    
 )
}

plot_word <- function(input, output, session) {
  
  word_runtime <-
    eventReactive(input$refresh_plot, {
      (plotte_word(input$word_search, dfm_data(), input$intervall_words))
    })
  output$bar_chart_word <- renderPlotly({
    word_runtime()
  })
}

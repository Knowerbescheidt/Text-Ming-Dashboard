require(shiny)
source(
  paste0(getwd(),
    "/Funktionen/",
    "plot_word.R"
  ),
  local = TRUE
)
source(
  paste0(getwd(),
    "/Funktionen/",
    "data_prep_dfm.R"
  ),
  local = TRUE
)

plot_wordUI <- function(id) {
  ns <- NS(id)
  tagList(
    textInput(
      ns("word_search"),
      placeholder = "lower cases",
      label = "Word for timeseries",
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
      if (existsFunction("dfm_data") == TRUE) {
        (plot_word_func(input$word_search, dfm_data(), input$intervall_words))
      }
      else{
        shinyalert(
          title = "No Dataset ",
          text = "Please select a dataset",
          showConfirmButton = TRUE,
          timer = 5000
        )
      }
    })
  output$bar_chart_word <- renderPlotly({
    word_runtime()
  })
}

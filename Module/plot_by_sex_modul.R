source(
  paste0(getwd(),
    "/Funktionen/",
    "plot_word_sex.R"
  ),
  local = TRUE
)

#UI-----------------
plot_by_sexUI <- function(id, dictionary_id) {
  ns <- NS(id)
  tagList(box(
    textInput(
      ns("word_ts"),
      placeholder = "lower cases",
      label = "Word for timeseries",
      value = "Beispiel",
      width = 600
    ),
    selectInput(
      ns("intervall"),
      label = "Intervall",
      choices = list(month = "month", year = "year")
    ),
    actionButton(ns("refresh_metadata_plot"), label = "Update Plot"),
    radioButtons(
      ns("radio_button"),
      label = "Select your Metadata",
      choiceNames = c("none", "Sex"),
      choiceValues = c(0, 1)
    ),
    box(plotlyOutput(ns("bar_chart_word")), width = 500)
  ))
}

#Server-----------------
plot_by_sex <- function(input, output, session) {
  word_plot <- eventReactive(input$refresh_metadata_plot, {
    if (input$radio_button == 0) {
      pa <- plotte_word_sex(
        word = input$word_ts,
        dfm_input = dfm_data(),
        intervall = input$intervall,
        group_by_sex = FALSE
      )
      return(pa)
    }
    else if (input$radio_button == 1) {
      pa <- plotte_word_sex(
        word = input$word_ts,
        dfm_input = dfm_data(),
        intervall = input$intervall,
        group_by_sex = TRUE
      )
      return(pa)
    }
  })
  output$bar_chart_word <- renderPlotly({
    word_plot()
  })
}
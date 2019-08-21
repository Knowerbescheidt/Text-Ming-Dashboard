getwd()
source(paste0(getwd(),"/Funktionen/target_collocation.R"),
       local = TRUE)

target_collUI <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(
      ns("window_count"),
      label = "Window Count",
      min = 5,
      max = 20,
      step = 1,
      value = 10,
      width = '400px'
    ),
    sliderInput(
      ns("min_n_target"),
      label = "Minimum Number of Window Occurences",
      min = 5,
      max = 100,
      step = 5,
      value = 10,
      width = '400px'
    ),
    numericInput(
      ns("return_count"),
      label = "Number of returned words",
      value = 50,
      min = 20,
      max = 100,
      step = 1,
      width = '100px'
      ),
    textInput(
      ns("words"),
      placeholder = "lower cases",
      label = "Word for Collocations",
      value = "Example",
      width = 600
    ),
    )
  }


target_coll<- function(input, output, session) {
  
  
}














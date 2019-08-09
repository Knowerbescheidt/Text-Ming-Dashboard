require(shiny)

analyse_tmUI <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(
      ns("numb_of_docs"),
      label = "Number of documents",
      min = 10,
      max = 200,
      step = 10,
      value = 50,
      width = '400px'
      ),
    sliderInput(
      ns("min_term_freq"),
      label = "Minimum Term Frequency",
      min = 0.5,
      max = 1,
      step = 0.1,
      value = 0.8,
      width = '400px'
    ),
    sliderInput(
      ns("max_doc_freq"),
      label = "Maximum Document Frequency",
      min = 0.01,
      max = 0.5,
      step = 0.1,
      value = 0.2,
      width = '400px'
    ),
    numericInput(
      ns("topic_number"),
      label = "Number of Topics",
      value = 2,
      min = 2,
      max = 10,
      step = 1,
      width = '100px'
      
    ),
    numericInput(
      ns("return_words"),
      label = "Number of returned Words",
      value = 10,
      min = 3,
      max = 30,
      step = 1,
      width = '200px'
    )
  )
  
}






analyse_tm <- function(input, output, session) {
  
}

<<<<<<< HEAD
source(paste0("C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/tm.R"),
=======
require(shiny)

source(paste0(getwd(), "/Funktionen/tm.R"),
>>>>>>> 391e41b8a6e5680b95c6612b710ec351f28ba43f
       local = TRUE)

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
      ns("min_termfreq"),
      label = "Minimum Term Frequency",
      min = 0.5,
      max = 1,
      step = 0.05,
      value = 0.8,
      width = '400px'
    ),
    sliderInput(
      ns("max_docfreq"),
      label = "Maximum Document Frequency",
      min = 0,
      max = 0.5,
      step = 0.05,
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
    ),
    actionButton(ns("start"), label = "Apply"),
    DT::dataTableOutput(ns("datatable_r"))
    #DT::dataTableOutput(ns("datatable_test"))
    
  )
  
}


analyse_tm <- function(input, output, session) {
  datatable_r <- eventReactive(input$start, {
      a <- tm_func(
        dfm_object = dfm_data(),
        numb_of_docs = input$numb_of_docs,
        min_termfreq = input$min_termfreq,
        max_docfreq = input$max_docfreq,
        topic_number = input$topic_number,
        return_words = input$return_words
      )
      return(a)
    
  })

output$datatable_r <- DT::renderDataTable({datatable_r()})
  #Test---------
#   datatable_test1 <- eventReactive(input$start, {
#     a <- data.frame(
#       "A" = c(1, 2, 3, 4),
#       "B" = c(1, 1, 2, 3),
#       "C" = c(1, 12, 412, 4)
#     )
#   return(a)
#     })
# output$datatable_test <- DT::renderDataTable({datatable_test1()})
# 
# observeEvent(input$start, {
#   print("JA")
# })
  }

#Test-------
# 
# df <-
#   data.frame("Gewicht"=c(65,75),"Groesse"=c(168,175),"Geschlecht"=c("m","w"))
# head(df)
# str(df)

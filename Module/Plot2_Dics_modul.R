require(shiny)
require(shinyalert)

source(
  paste0(
    "C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/",
    "Plot2_Dictionaries.R"
  ),
  local = TRUE
)


plot_2DicUI <- function(id, dictionary_id) {
  ns <- NS(id)
  tagList(
    selectInput(
      ns("dictio1"),
      label = "Dictionary 1",
      choices = c("Press Update")
    ),
    selectInput(
      ns("dictio2"),
      label = "Dictionary 2",
      choices = c("Press Update")
    ),
    selectInput(
      ns("intervall_dictionaries"),
      label = "Intervall",
      choices = list(month = "month", year = "year")
    ),
    actionButton(ns("refresh2"), label = "Update Plot"),
    actionButton(ns("refresh_2dictionaries"), label = "Update Dictionaries"),
    plotlyOutput(ns("bar_chart_dicts"))
    
    
    
  )
  
  
}


plot_2Dic <- function(input, output, session) {
  vec_name_obj <- eventReactive(input$refresh_2dictionaries, {
    liste <-
      import_excels(list.files(
        "C:/Users/Jani/Documents/R Hausaufgabe/Daten/Dictionaries/"
      ))
    vec_name <- c()
    i <- 1
    for (i in 1:length(liste)) {
      vec_name[i] <- names(liste[[i]])
      i <- i + 1
    }
    return(vec_name)
  })
  
  observeEvent(input$refresh_2dictionaries,
               {
                 updateSelectInput(
                   session = session,
                   inputId = "dictio1",
                   choices = vec_name_obj()
                 )
               })
  observeEvent(input$refresh_2dictionaries,
               {
                 updateSelectInput(
                   session = session,
                   inputId = "dictio2",
                   choices = vec_name_obj()
                 )
               })
  

  plot_data <- eventReactive(input$refresh2, {
    plot_dictionaries(
      dfm = dfm_data(),
      dictio_1 = import_excel(
          as.character(input$dictio1)
        ),
      dictio_2 = import_excel(
        paste0(
          as.character(input$dictio2)
        )
      ),intervall = input$intervall_dictionaries
    )
  })
  
  output$bar_chart_dicts <- renderPlotly({plot_data()})
  
  
  
  
  
  
  
}


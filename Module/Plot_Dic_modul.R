source(
  paste0(getwd(),
    "/Funktionen/",
    "plotte_Dic.R"
  ),
  local = TRUE
)
source(
  paste0(getwd(),
    "/Funktionen/",
    "excel_Input.R"
  ),
  local = TRUE
)


plot_DicUI <- function(id, dictionary_id) {
  ns <- NS(id)
  tagList(
    selectInput(
      ns("dictio"),
      label = "Dictionary",
      choices = c("Press Update")
    ),
    
    selectInput(
      ns("intervall_dictionaries"),
      label = "Intervall",
      choices = list(month = "month", year = "year")
    ),
    actionButton(ns("refresh"), label = "Update Plot"),
    actionButton(ns("refresh_dictionaries"), label = "Update Dictionaries"),
    plotlyOutput(ns("bar_chart_dict")),
    useShinyalert()
  )
}

plot_Dic <- function(input, output, session) {
  #Refresh list of dictionaries and names---------------------------
  vec_name_obj <- eventReactive(input$refresh_dictionaries, {
    liste <-
      import_excels(list.files(paste0(
        getwd(), "/Daten/Dictionaries/"
      )))
    vec_name <- c()
    i <- 1
    for (i in 1:length(liste)) {
      vec_name[i] <- names(liste[[i]])
      i <- i + 1
    }
    return(vec_name)
  })
  
  observeEvent(input$refresh_dictionaries,
               {
                 updateSelectInput(
                   session = session,
                   inputId = "dictio",
                   label = "Dictionaries",
                   choices = vec_name_obj()
                 )
               })
  
  #refresh dictionaries Error---------------
  observeEvent(input$refresh, {
    if (file.exists(
      paste0(getwd(),
        "/Daten/Dictionaries/",
        as.character(input$dictio)
      )
    ) == FALSE) {
      shinyalert(title = "Error 404",
                 text = "Updaten Sie die Dictionaries!",
                 timer = 2000)
    }
  })
  
  #Data f?r barchart------------------------
  dictionary_runtime <-
    eventReactive(input$refresh, {
      plotte_dictio(
        import_excel(input$dictio),
        dfm_data(),
        as.character(input$intervall_dictionaries)
      )
    })
  
  #barchart output------------------
  output$bar_chart_dict <- renderPlotly({
    if (file.exists(
      paste0(getwd(),
        "/Daten/Dictionaries/",
        as.character(input$dictio)
      )
    ) == TRUE) {
      dictionary_runtime()
    }
  })
}

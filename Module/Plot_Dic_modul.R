require(shiny)
require(shinyalert)

source(
  paste0(
    "C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/",
    "PlotteDictio",
    ".R"
  ),
  local = TRUE
)
source(
  paste0(
    "C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/",
    "Excel_Input.R"
  ),
  local = TRUE
)


plot_DicUI <- function(id, dictionary_id) {
  ns <- NS(id)
  tagList(
    selectInput(
      ns("dictio"),
      label = "Dictionary",
      choices = c("Dr?cken sie Update")
    ),
    
    selectInput(
      ns("intervall_dictionaries"),
      label = "Intervall",
      choices = list(month = "month", year = "year")
    ),
    actionButton(ns("refresh"), label = "Update Plot"),
    actionButton(ns("refresh_dictionaries"), label = "Update Dictionaries"),
    # actionButton(ns("delete_dictionary"), label = "Delete Dictionaries"),
    # actionButton(ns("show_dic"), label = "View Dictionary"),
    # actionButton(ns("save_dic"), label = "Save Changes"),
    # rHandsontableOutput(ns("display_dic"), width = 700),
    
    plotlyOutput(ns("bar_chart_dict")),
    useShinyalert()
  )
}

plot_Dic <- function(input, output, session) {
  # observeEvent(input$save_dic, {
  #   write.xlsx2(
  #     hot_to_r(input$display_dic),
  #     file = paste0(
  #       "C:/Users/Jani/Documents/R Hausaufgabe/Daten/Dictionaries/",
  #       input$dictio
  #     ),
  #     row.names = FALSE,
  #     col.names = FALSE
  #   )
  # })
  # if the selected changes then the data needs to be updated using event Reactive
  # display the Dictionary--------------------------
  
  #   dic_view <-
  #     eventReactive(input$show_dic, {
  #       rhandsontable(read.xlsx(
  #         paste0(
  #           "C:/Users/Jani/Documents/R Hausaufgabe/Daten/Dictionaries/",
  #           as.character(input$dictio)
  #         ),
  #         sheetIndex = 1,
  #         header = FALSE
  #       ),
  #       colHeaders = c("Words"))
  #     })
  #
  # output$display_dic <- renderRHandsontable(dic_view())
  
  
  #Refresh list of dictionaries and names---------------------------
  vec_name_obj <- eventReactive(input$refresh_dictionaries, {
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
      paste0(
        "C:/Users/Jani/Documents/R Hausaufgabe/Daten/Dictionaries/",
        as.character(input$dictio)
      )
    ) == FALSE) {
      shinyalert(title = "Error 404",
                 text = "Updaten Sie die Dictionaries!",
                 timer = 2000)
    }
  })
  
  # #delete Dictionaries-----------------------
  # observeEvent(input$delete_dictionary, {
  #   if (file.exists(
  #     paste0(
  #       "C:/Users/Jani/Documents/R Hausaufgabe/Daten/Dictionaries/",
  #       as.character(input$dictio)
  #     )
  #   ) == TRUE) {
  #     file.remove(
  #       paste0(
  #         "C:/Users/Jani/Documents/R Hausaufgabe/Daten/Dictionaries/",
  #         as.character(input$dictio)
  #       )
  #     )
  #   }
  #   if (file.exists(paste0("/Daten/Dictionaries/", as.character(input$dictio))) == FALSE) {
  #     print("Wurde gel?scht")
  #   }
  # })
  
  #Data f?r barchart------------------------
  dictionary_runtime <-
    eventReactive(input$refresh, {
      plotte_dictio(
        import_excel(input$dictio),
        dfm_data,
        as.character(input$intervall_dictionaries)
      )
    })
  
  #barchart output------------------
  output$bar_chart_dict <- renderPlotly({
    if (file.exists(
      paste0(
        "C:/Users/Jani/Documents/R Hausaufgabe/Daten/Dictionaries/",
        as.character(input$dictio)
      )
    ) == TRUE) {
      dictionary_runtime()
    }
  })
}

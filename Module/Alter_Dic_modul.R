
#UI---------------------------------
alter_dictioUI <- function(id, dictionary_id) {
  ns <- NS(id)
  tagList(
    selectInput(
      ns("dictio"),
      label = "Dictionary",
      choices = c("Press Update")
    ),
    actionButton(ns("refresh_dictionaries"), label = "Update Dictionaries"),
    actionButton(ns("delete_dictionary"), label = "Delete Dictionaries"),
    actionButton(ns("show_dic"), label = "View Dictionary"),
    actionButton(ns("save_dic"), label = "Save Changes"),
    box(rHandsontableOutput(ns("display_dic"), width = 700), collapsible = TRUE)
    
  )
}

#Server-------------------------------
alter_dictio <- function(input, output, session) {
  #Saving Dictionary----------
  observeEvent(input$save_dic, {
    write.xlsx(
      hot_to_r(input$display_dic),
      file = paste0(getwd(),
                    "/Daten/Dictionaries/",
                    input$dictio)
    )
  })
  
  #Viewing a dictionary---------------
  dic_view <-
    eventReactive(input$show_dic, {
      rhandsontable(read.xlsx(
        paste0(
          getwd(),
          "/Daten/Dictionaries/",
          as.character(input$dictio)
        ),
        sheet = 1,
        colNames = FALSE
      ),
      colHeaders = c("Words"))
    })
  
  output$display_dic <- renderRHandsontable(dic_view())
  
  vec_name_obj2 <- eventReactive(input$refresh_dictionaries, {
    liste <-
      import_excels(list.files(paste0(getwd(),
                                      "/Daten/Dictionaries/")))
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
                   choices = vec_name_obj2()
                 )
               })
  
  #delete Dictionaries-----------------------
  observeEvent(input$delete_dictionary, {
    if (file.exists(paste0(
      getwd(),
      "/Daten/Dictionaries/",
      as.character(input$dictio)
    )) == TRUE) {
      file.remove(paste0(
        getwd(),
        "/Daten/Dictionaries/",
        as.character(input$dictio)
      ))
    }
    if (file.exists(paste0("/Daten/Dictionaries/", as.character(input$dictio))) == FALSE) {
      print("Wurde gelöscht")
    }
  })
  
}
source(
  paste0(getwd(),
    "/Funktionen/",
    "data_prep_dfm.R"
  ),
  local = TRUE
)
source(
  paste0(getwd(),
         "/Funktionen/",
         "data_prep_token.R"
  ),
  local = TRUE
)


select_datasetUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      ns("Data_set"),
      label = "Data set",
      choices = c("Press Update Datasets")
    ),
    actionButton(ns("refresh_data"), label = "Update Datasets"),
    actionButton(ns("select_data"), label = "Select Dataset")
  )
}

select_dataset <-  function(input, output, session) {
  dfm_data <- eventReactive(input$select_data, {
    data_prep_dfm(
      paste0(getwd(),
        "/Daten/Amazon_data/",
        input$Data_set
      )
    )
  })
  observeEvent(input$select_data, {
    #assign dfm_data zu dfm_data
    assign(x = "dfm_data",
           value = dfm_data,
           envir = globalenv())
  })
  Token_data <- eventReactive(input$select_data, {
    data_prep_token(
      paste0(getwd(),
             "/Daten/Amazon_data/",
             input$Data_set
      )
    )
  })
  observeEvent(input$select_data, {
    #assign Token_data zu Token_data
    assign(x = "Token_data",
           value = Token_data,
           envir = globalenv())
  })
    #refresh names-----------
  
  names_vec <- eventReactive(input$refresh_data, {
    liste <-
      list.files(paste0(getwd(), "/Daten/Amazon_data/"))
    return(liste)
  })
  observeEvent(input$refresh_data,
               {
                 updateSelectInput(
                   session = session,
                   inputId = "Data_set",
                   label = "Dataset",
                   choices = names_vec()
                 )
               })
  
}





#Alter Code------------------
#
#
# select_datasetUI <- function(id) {
#   ns <- NS(id)
#   tagList(
#     selectInput(
#       ns("Data_set"),
#       label = "Data set",
#       choices = c("Press sie Update Data")
#     ),
#     actionButton(ns("refresh_data"), label = "Update Data"),
#     actionButton(ns("select_data"), label = "Select Data")
#
#   )
# }
#
# select_dataset <-  function(input, output, session) {
#   dfm_data <- eventReactive(input$select_data, {
#     data_prep_dfm(
#       paste0(
#         "C:/Users/Jani/Documents/R Hausaufgabe/Daten/Amazon_data/",
#         input$Data_set
#       )
#     )
#   })
#
#
#   names_vec <- eventReactive(input$refresh_data, {
#     liste <-
#       list.files("C:/Users/Jani/Documents/R Hausaufgabe/Daten/Amazon_data/")
#     return(liste)
#   })
#
#   observeEvent(input$refresh_data,
#                {
#                  updateSelectInput(
#                    session = session,
#                    inputId = "Data_set",
#                    label = "Data set",
#                    choices = names_vec()
#                  )
#                })
# }
#UI----------------------------
save_DicUI <- function(id, dictionary_id) {
  ns <- NS(id)
  tagList(
    rHandsontableOutput(ns("table")),
    textInput(
      ns("dictio_name"),
      placeholder = "Name",
      label = "Choose a name for your Dictionary",
      value = "Example",
      width = 500
    ),
    actionButton(ns("save_button"), "Save")
  )
}

#Server-----------------
save_Dic <-  function(input, output, session) {
  output$table <- renderRHandsontable({
    rhandsontable(data_frame_bsp)
  })
  x <- c("Word", NA, NA, NA)
  data_frame_bsp <-
    data.frame(Words = x, stringsAsFactors =  FALSE)
  observeEvent(
    input$save_button,
    write.xlsx(
      hot_to_r(input$table),
      file = paste0(
        getwd(),
        "Daten/Dictionaries/Dictionary ",
        input$dictio_name  ,
        ".xlsx"
      ),
      row.names = FALSE,
      col.names = FALSE
    )
  )
}
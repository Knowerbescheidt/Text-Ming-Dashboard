#UI-------------------
view_dataUI <- function(id) {
  ns <- NS(id)
  tagList(actionButton(ns("update_table"), label = "Update Table"),
          DTOutput(ns("text_data")))
}

#Server--------
view_data <- function(input, output, session) {
  table_text <- eventReactive(input$update_table, {
    table_data <- datatable(corpus_data()$documents[, c(1, 3, 4, 5, 6, 8, 9)])
    return(table_data)
  })
  
  output$text_data <-
    DT::renderDataTable(table_text(),
                        options = list(autoWidth = TRUE,
                                       columnDefs = list(
                                         list(width = "600px", targets = table_text()$texts)
                                       )))
}

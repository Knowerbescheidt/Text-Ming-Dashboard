require(DT)
# pick the corpus object to make a better Interface
# data_to_view <- corpus_data[[,c(1,3,4,5,8,9,10)]]
# data_to_view$timestamp <- anytime(data_to_view[,7])
# class(date(data_to_view$timestamp[1:5]))
# class(data_to_view$timestamp[1:5])
# head(data_to_view[,], 25)
#renderDataTable works a lot easier than renderTable

view_dataUI <- function(id) {
  ns <- NS(id)
  tagList(DTOutput(ns("text_data"),width = 600))
}

#Server--------
view_data <- function(input, output, session) {
  data_to_view <- corpus_data[[, c(1, 3, 4)]] #gut wären auch 5,8,9,10
  #data_to_view$timestamp <- anytime(data_to_view[, 7])
  
  output$text_data <-
    renderDT(datatable({data_to_view},rownames = FALSE), options = list(autoWidth = TRUE,
                                                 columnDefs = list(list(
                                                   width = 500, targets = data_to_view$texts
                                                 ))))
}

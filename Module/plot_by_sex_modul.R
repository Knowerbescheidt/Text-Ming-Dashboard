require(shiny)
require(shinyalert)

source(
  paste0(
    "C:/Users/Jani/Documents/R Hausaufgabe/Funktionen/",
    "plot_word_sex.R"
  ),
  local = TRUE
)

plot_by_sexUI <- function(id, dictionary_id) {
  ns <- NS(id)
  tagList(
    checkboxGroupInput(ns(Group),label = "Group by metadata",choices = c("Gender")),
  
  actionButton(ns("refresh_Plot"), label = "Update Plot")
)
  }

plot_by_sex <- function(input, output, session) {
  
}
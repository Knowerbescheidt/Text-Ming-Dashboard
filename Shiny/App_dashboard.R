require(shiny)
require(shinydashboard)
require(plotly)
require(DT)
require(rhandsontable)
options(stringsAsFactors = FALSE)
pfad <- "C:/Users/Jani/Documents/R Hausaufgabe/"
source(paste0(pfad, "/Daten/", "Data.R"), local = TRUE)
source(paste0(pfad, "/Module/", "Plot_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "/Module/", "Plot_Word_modul.R"), local = TRUE)
source(paste0(pfad, "/Module/", "save_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "/Module/", "view_data_modul.R"), local = TRUE)
source(paste0(pfad, "/Module/", "select_dataset_modul.R"), local = TRUE)


ui <- dashboardPage(
  dashboardHeader(title = "Mining Your Comments"),
  dashboardSidebar(sidebarMenu(
    menuItem(
      "Plot Single Word",
      tabName = "plot_words",
      icon = icon("plot_words")
    ),
    menuItem(
      "Plot Dictionaries",
      tabName = "plot_dics",
      icon = icon("plot_dics")
    ),
    menuItem(
      "Data",
      tabName = "data",
      icon = icon("data")
    ),
    menuItem(
      "Dataset",
      tabName = "dataset",
      icon = icon("dataset")
    )
  )),
  dashboardBody(tabItems(
    tabItem(tabName = "plot_words",
            fluidRow(box(
              title = "Plot Word",
              plot_wordUI("two")
            ),box(title = "Select your data",
              select_datasetUI("two")
            ))
            ),
    tabItem(tabName = "data",
            fluidRow(box(
              title = "Data table",
              view_dataUI("one")
            ))),
    # tabItem(tabName = "dataset",
    #         fluidRow(box(
    #           title = "Select data set",
    #           select_datasetUI("two")
    #         ))),
    tabItem(
      tabName = "plot_dics",
      box(title =  "Change and Plot Dictionary",
          plot_DicUI("one")),
      box(title = "Create Dictionary",
          save_DicUI("one"))
    )
  ))
)


server <- function(input, output) {

  callModule(plot_Dic, "one")
  callModule(plot_word, "two")
  callModule(save_Dic, "one")
  callModule(view_data, "one")
 # da diese FUnktion auch in anderem Modul genutzt wird muss es eine eigene id bekommen
 # callModule(select_dataset, "two")
  callModule(select_dataset, "two")
}

shinyApp(ui = ui, server = server)

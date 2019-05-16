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
source(paste0(pfad, "/Module/", "Alter_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "/Module/", "Plot2_Dics_modul.R"), local = TRUE)
source(paste0(pfad, "/Module/", "plot_by_sex_modul.R"), local = TRUE)


ui <- dashboardPage(
  dashboardHeader(title = "Mining Your Comments"),
  dashboardSidebar(sidebarMenu(
    menuItem(
      "Timeseries Words",
      tabName = "plot_words",
      icon = icon("plot_words")
    ),
    menuItem(
      "Timeseries Dictionaries",
      tabName = "plot_dics",
      icon = icon("plot_dics")
    ),
    menuItem(
      "Compare Dictionaries",
      tabName = "plot_2dics",
      icon = icon("plot_2dics")
    ),
    menuItem(
      "Plot by Metadata",
      tabName = "Metadata",
      icon = icon("plot_sex")
    ),
    menuItem("Data",
             tabName = "data",
             icon = icon("data"))
  )),
  dashboardBody(tabItems(
    tabItem(tabName = "plot_words",
            fluidRow(
              box(title = "Plot Word",
                  plot_wordUI("one")),
              box(title = "Select your data",
                  select_datasetUI("one"))
            )),
    tabItem(tabName = "Metadata",
            fluidRow(
              box(title = "Plot by metadata",
                  plot_by_sexUI("four"))
             )),
    tabItem(tabName = "data",
            fluidRow(box(
              title = "Data table",
              view_dataUI("one")
            ))),
    tabItem(tabName = "plot_2dics",
            fluidRow(box(
              title = "Plot 2 Dictionaries",
              plot_2DicUI("three")
            ))),
    tabItem(
      tabName = "plot_dics",
      box(title =  "Change and Plot Dictionary",
          plot_DicUI("one")),
      box(
        title = "Create Dictionary",
        save_DicUI("one"),
        collapsible = TRUE,
        collapsed = TRUE
      ),
      box(
        title = "Alter a dictionary",
        alter_dictioUI("two"),
        collapsible = TRUE
      )
    )
  ))
)
#KOmmentar

server <- function(input, output) {
  callModule(plot_Dic, "one")
  callModule(plot_word, "one")
  callModule(save_Dic, "one")
  callModule(view_data, "one")
  callModule(select_dataset, "one")
  callModule(alter_dictio, "two")
  callModule(plot_2Dic, "three")
  callModule(plot_by_sex, "four")
}

shinyApp(ui = ui, server = server)

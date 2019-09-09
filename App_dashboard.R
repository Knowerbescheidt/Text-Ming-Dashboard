require(shiny)
require(shinydashboard)
require(plotly)
require(DT)
require(rhandsontable)
require(readtext)
require(quanteda)

library(anytime)
require(ggplot2)
require(jsonlite)
require(ndjson)
require(shinyalert)
require(topicmodels)
require(lubridate) #wird in tm Funktion gebraucht
require(readtext)
require(openxlsx)


options(stringsAsFactors = FALSE)
pfad <- paste0(getwd(), "/Module/")
source(paste0(pfad, "plot_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "save_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "view_data_modul.R"), local = TRUE)
source(paste0(pfad, "select_dataset_modul.R"), local = TRUE)
source(paste0(pfad, "alter_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "plot2_Dics_modul.R"), local = TRUE)
source(paste0(pfad, "plot_by_sex_modul.R"), local = TRUE)
source(paste0(pfad, "collocations_modul.R"), local = TRUE)
source(paste0(pfad, "sentiment_modul.R"), local = TRUE)
source(paste0(pfad, "tm_modul.R"), local = TRUE)
source(paste0(pfad, "target_collocations_modul.R"), local = TRUE)

ui <- dashboardPage(
  dashboardHeader(title = "Text Mining Tool"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Data",
               tabName = "data",
               icon = icon("data")),
      menuItem(
        "Timeseries Words",
        tabName = "Metadata",
        icon = icon("plot_sex")
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
        "Collocations",
        tabName = "collocations",
        icon = icon("collocations")
      ),
      menuItem(
        "Target Collocation",
        tabName = "target_collocations",
        icon = icon("Target Coll")
      ),
      menuItem(
        "Sentiment Analysis",
        tabName = "Sentiment",
        icon = icon("sentiment")
      ),
      menuItem(
        "Topic Model",
        tabName = "TM",
        icon = icon("topic_model")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "Metadata",
              fluidRow(
                box(title = "Plot by metadata",
                    plot_by_sexUI("four"), width = 12)
              )),
      tabItem(tabName = "TM",
              fluidRow(
                box(title = "Analyse topic Models",
                    analyse_tmUI("one"), width = 12)
              )),
      tabItem(tabName = "Sentiment",
              fluidRow(
                box(
                  title = "Sentiment Analysis",
                  analyse_sentimentUI("one"),
                  width = 12
                )
              )),
      tabItem(tabName = "collocations",
              fluidRow(
                box(title = "Search for Collocations",
                    find_collocationUI("one"), width = 12)
              )),
      tabItem(tabName = "data",
              fluidRow(
                box(title = "Select your data",
                    select_datasetUI("one")),
                box(title = "Data table",
                    view_dataUI("one"), width = 12)
              )),
      tabItem(tabName = "plot_2dics",
              fluidRow(
                box(title = "Plot 2 Dictionaries",
                    plot_2DicUI("three"))
              )),
      tabItem(tabName = "target_collocations",
              fluidRow(
                box(title = "Target Collocations",
                    target_collUI("two"))
              )),
      tabItem(
        tabName = "plot_dics",
        box(title =  "Plot Dictionary",
            plot_DicUI("one")),
        box(
          title = "Create Dictionary",
          save_DicUI("one"),
          collapsible = TRUE,
          collapsed = TRUE
        ),
        box(
          title = "Alter Dictionary",
          alter_dictioUI("two"),
          collapsible = TRUE
        )
      )
    )
  )

)

server <- function(input, output) {
  callModule(plot_Dic, "one")
  callModule(save_Dic, "one")
  callModule(view_data, "one")
  callModule(select_dataset, "one")
  callModule(alter_dictio, "two")
  callModule(plot_2Dic, "three")
  callModule(plot_by_sex, "four")
  callModule(find_collocation, "one")
  callModule(analyse_sentiment, "one")
  callModule(analyse_tm, "one")
  callModule(target_coll, "two")
  #session$onSessionEnded(stopApp)

}

shinyApp(ui = ui, server = server)

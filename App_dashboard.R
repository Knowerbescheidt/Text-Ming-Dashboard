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


options(stringsAsFactors = FALSE)
pfad <- paste0(getwd(), "/Module/")
source(paste0(pfad, "plot_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "plot_Word_modul.R"), local = TRUE)
source(paste0(pfad, "save_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "view_data_modul.R"), local = TRUE)
source(paste0(pfad, "select_dataset_modul.R"), local = TRUE)
source(paste0(pfad, "alter_Dic_modul.R"), local = TRUE)
source(paste0(pfad, "plot2_Dics_modul.R"), local = TRUE)
source(paste0(pfad, "plot_by_sex_modul.R"), local = TRUE)
source(paste0(pfad, "collocations_modul.R"), local = TRUE)
source(paste0(pfad, "sentiment_modul.R"), local = TRUE)
source(paste0(pfad, "tm_modul.R"), local = TRUE)

ui <- dashboardPage(
  dashboardHeader(title = "Text Mining Tool"),
  dashboardSidebar(sidebarMenu(
    menuItem(
      "Timeseries Words",
      tabName = "plot_words",
      icon = icon("chart_bar")
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
      "Plot by Metadata",
      tabName = "Metadata",
      icon = icon("plot_sex")
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
                  plot_by_sexUI("four"),width = 12)
             )),
   
     tabItem(tabName = "TM",
            fluidRow(
              box(title = "Analysetopic Models",
                  analyse_tmUI("one"),width = 12)
            )),
    
    
    tabItem(tabName = "Sentiment",
            fluidRow(
              box(title = "Sentiment Analysis",
                  analyse_sentimentUI("one"),width = 12)
            )),
    tabItem(tabName = "collocations",
            fluidRow(
              box(title = "Search for Collocations",
                  find_collocationUI("one"),width = 12)
            )),
    tabItem(tabName = "data",
            fluidRow(box(
              title = "Data table",
              view_dataUI("one"),width = 12
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

server <- function(input, output) {
  callModule(plot_Dic, "one")
  callModule(plot_word, "one")
  callModule(save_Dic, "one")
  callModule(view_data, "one")
  callModule(select_dataset, "one")
  callModule(alter_dictio, "two")
  callModule(plot_2Dic, "three")
  callModule(plot_by_sex, "four")
  callModule(find_collocation, "one")
  callModule(analyse_sentiment, "one")
  callModule(analyse_tm, "one")
  
}

shinyApp(ui = ui, server = server)

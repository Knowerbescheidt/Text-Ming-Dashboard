options(stringsAsFactors = F)

require(readtext)
require(quanteda)
library(jsonlite)
require(ndjson)
require(lubridate)
library(anytime)
require(ggplot2)
require(plotly)

data_prep_dfm <- function(pathway) {
  
data_amazon <- stream_in(pathway)

#Umwandlung der Zeit in Jahr und dann dem Data Frame hinzugefÃ¼gt-------------------
data_year <- year(anytime(data_amazon$unixReviewTime))
data_month <- month(anytime(data_amazon$unixReviewTime))
data_amazon$year <- data_year
data_amazon$month <- data_month
data_amazon$doc_id <- c(1:nrow(data_amazon))

#Aufbereitung-----------------------------------
corpus_data <-
  corpus(data_amazon, docid_field = "doc_id", text_field = "reviewText")
Token_data <-
  tokens(
    corpus_data,
    what = 'word',
    remove_numbers = TRUE,
    remove_symbols = TRUE,
    remove_punct = TRUE,
    include_docvars = TRUE
  )
Token_data <- tokens_remove(Token_data, pattern = stopwords("en"))

#DFM Objekt-----------------------------------

dfm_data <- dfm(Token_data)
return(dfm_data)
}
data_prep_dfm("C:/Users/Jani/Documents/R Hausaufgabe/Daten/Musical_Instruments_5.json")
dfm_test <- data_prep_dfm("C:/Users/Jani/Documents/R Hausaufgabe/Daten/Patio_Lawn_and_Garden_5.json")

options(stringsAsFactors = F)

require(readtext)
require(quanteda)
library(jsonlite)
require(ndjson)
require(lubridate)
library(anytime)
require(ggplot2)
require(plotly)

plotte_dictio <-
  function(dictionary_input , dfm_input , intervall = "year") {
    #Missing values are replaced by a "-"--------
    missing_values <- dictionary_input[[1]]==""
    dictionary_input[[1]][missing_values] <- "-"
    #year----
    if ("year" == intervall) {
      dfm_runtime <- dfm_group(dfm_input, groups = "year")
      char_title <- "Word frequency by year"
      data_runtime <-
        convert(dfm_lookup(dfm_runtime, dictionary = dictionary_input), to = "data.frame")
      return(
        plot_ly(
          data_runtime,
          y = data_runtime[, 2],
          x = data_runtime[, 1],
          type = "bar",
          name = char_title
        )
      )
    }
    #month----------
    if ("month" == intervall) {
      dfm_runtime <- dfm_group(dfm_input, groups = "month")
      char_title <- "Word frequency by month"
      data_runtime <-
        convert(dfm_lookup(dfm_runtime, dictionary = dictionary_input), to = "data.frame")
      return(
        plot_ly(
          data_runtime,
          y = data_runtime[, 2],
          x = as.integer(data_runtime[, 1]),
          type = "bar",
          name = char_title
        )
      )      
    }
  }

# Test-----------------------
# #
# dictio_arbeit <- import_excel("Dictionary Schoko2.xlsx")
# dfm_arbeit <- dfm_data
# plotte_dictio(dictio_arbeit, dfm_input =  dfm_arbeit, intervall = "year")
# length(dictio_arbeit[[1]])
# 
# 
# 
# vec <- dictio_arbeit[[1]]=="" 
# dictio_arbeit[[1]][vec]
# dictio_arbeit[[1]][vec] <- "-"
# 
# dictio_arbeit[[1]][3]
# names(dictio_arbeit[[1]])
# #wichtig fehlende Werte werden nicht als NA abgelegt
# is.dictionary(dictio_arbeit)

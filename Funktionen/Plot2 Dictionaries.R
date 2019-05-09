require(quanteda)

plot_dictionaries <- function(dfm, dictio_1, dictio_2, intervall) {
  dfm_runtime <- dfm_group(dfm, groups = "year")
  x1 <-
    rowSums(dfm_lookup(dfm_runtime, dictionary = dictio_1))
  x2 <-
    rowSums(dfm_lookup(dfm_runtime, dictionary = dictio_2))
  data <-
    data.frame(
      dic1_counts = x1 ,
      dic2_counts = x2 ,
      year = docvars(dfm_runtime)
    )
  #return(data)
  return(
    plot_ly(data, x = data$year, y = data$dic1_counts, type = 'bar', name = 'Dictionary 1') %>%
      add_trace(y = data$dic2_counts, name = 'Dictionary 2') %>%
      layout(yaxis = list(title = 'Count'), barmode = 'stack')
  )
}

#Test-----------
dictio_test1 <-
  dictionary(list(
    Musik = c("Guitar", "Bass"),
    Garden = c("garden", "flower")
  ))
dictio_test2 <- dictionary(list(Wichig = c("important", "matter")))
dfm_test <- dfm(Token_data)
plot_dictionaries(dfm_test, dictio_test1, dictio_test2)
dfm_lookup(dfm_test, dictio_test1)


? data.frame
data_runtime <-
  convert(dfm_lookup(dfm_runtime, dictionary = dictionary_input), to = "data.frame")

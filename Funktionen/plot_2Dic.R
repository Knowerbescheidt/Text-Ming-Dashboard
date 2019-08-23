
plot_dictionaries <-
  function(dfm, dictio_1, dictio_2, intervall) {
    missing_values1 <- dictio_1[[1]] == ""
    dictio_1[[1]][missing_values1] <- "-"
    missing_values2 <- dictio_2[[1]] == ""
    dictio_2[[1]][missing_values2] <- "-"
    if (intervall == "year") {
      dfm_runtime <- dfm_group(dfm, groups = "year")
      data <-
        data.frame(
          dic1_counts = rowSums(dfm_lookup(dfm_runtime, dictionary = dictio_1)) ,
          dic2_counts = rowSums(dfm_lookup(dfm_runtime, dictionary = dictio_2)) ,
          year = docvars(dfm_runtime)
        )
      return(
        plot_ly(
          data,
          x = data$year,
          y = data$dic1_counts,
          type = 'bar',
          name = 'Dictionary 1'
        ) %>%
          add_trace(y = data$dic2_counts, name = 'Dictionary 2') %>%
          layout(yaxis = list(title = 'Count'), barmode = 'stack')
      )
    }
    if (intervall == "month") {
      dfm_runtime <- dfm_group(dfm, groups = "month")
      data <-
        data.frame(
          dic1_counts = rowSums(dfm_lookup(dfm_runtime, dictionary = dictio_1)) ,
          dic2_counts = rowSums(dfm_lookup(dfm_runtime, dictionary = dictio_2)) ,
          month = docvars(dfm_runtime)
        )
      return(
        plot_ly(
          data,
          x = data$month,
          y = data$dic1_counts,
          type = 'bar',
          name = 'Dictionary 1'
        ) %>%
          add_trace(y = data$dic2_counts, name = 'Dictionary 2') %>%
          layout(yaxis = list(title = 'Count'), barmode = 'stack')
      )
    }
  }

# #Test-----------
# dictio_test1 <- import_excel("Dictionary Imp - Kopie.xlsx")
# dictio_test2 <- import_excel("Dictionary Imp.xlsx")
# dfm_test <- dfm(Token_data)
# plot_dictionaries(dfm_test, dictio_test1, dictio_test2, intervall = "month")
# dfm_lookup(dfm_test, dictio_test1)

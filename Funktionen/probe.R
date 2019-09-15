plotte_word_sex <-
  function(word_input,
           dfm_input,
           intervall = "year",
           group_by_sex) {
    word_input <- tolower(word_input)
    a <- word_input %in% featnames(dfm_input)
    if (a == TRUE) {
    df_runtime <-
      convert(dfm_input, to = "data.frame", docvars = docvars(dfm_input))
    df_runtime$variable_year <- docvars(dfm_input, field = "year")
    df_runtime$variable_month <- docvars(dfm_input, field = "month")
    df_runtime$variable_sex <- docvars(dfm_input, field = "sex")
      if ("year" == intervall) {
        if (group_by_sex == TRUE) {
          aggregated_data <-
            aggregate(
              x = df_runtime[, word_input],
              by = list(
                year = df_runtime$variable_year,
                sex = df_runtime$variable_sex
              ),
              FUN = sum,
              drop = FALSE
            )
          
          p <-
            plot_ly(
              data = aggregated_data,
              y = aggregated_data$x[aggregated_data$sex == 1],
              x = aggregated_data$year[aggregated_data$sex == 1],
              type = "bar",
              name = "Male"
            ) %>%
            add_trace(y = aggregated_data$x[aggregated_data$sex == 0], name = "Female") %>%
            layout(yaxis = list(title = 'Count'), barmode = 'group')
          return(p)
          
        }
      
        if (group_by_sex == FALSE)
        {
          aggregated_data <-
            aggregate(
              x = df_runtime[, word_input],
              by = list(year = df_runtime$variable_year),
              FUN = sum,
              drop = FALSE
            )
          
          p <-
            plot_ly(
              data = aggregated_data,
              y = aggregated_data$x,
              x = aggregated_data$year,
              type = "bar",
              name = "Male"
            )
          return(p)
        }
      }
      if ("month" == intervall) {
        if (group_by_sex == TRUE) {
          aggregated_data <-
            aggregate(
              x = df_runtime[, word_input],
              by = list(
                month = df_runtime$variable_month,
                sex = df_runtime$variable_sex
              ),
              FUN = sum,
              drop = FALSE
            )
          
          p <-
            plot_ly(
              data = aggregated_data,
              y = aggregated_data$x[aggregated_data$sex == 1],
              x = aggregated_data$month[aggregated_data$sex == 1],
              type = "bar",
              name = "Male"
            ) %>%
            add_trace(y = aggregated_data$x[aggregated_data$sex == 0], name = "Female") %>%
            layout(yaxis = list(title = 'Count'), barmode = 'group')
          return(p)
          
        }
        if (group_by_sex == FALSE)
        {
          aggregated_data <-
          aggregate(
            x = df_runtime[, word_input],
            by = list(month = df_runtime$variable_month),
            FUN = sum,
            drop = FALSE
          )
        
        p <-
          plot_ly(
            data = aggregated_data,
            y = aggregated_data$x,
            x = aggregated_data$month,
            type = "bar",
            name = "All"
          )
        return(p)
          
        }
      }
    }
    else if (a == FALSE) {
      df_runtime <-
        data.frame(word_count = as.vector(rep(0, nrow(dfm_input))),
                   Zeit = docvars(dfm_input, intervall))
      return(
        plot_ly(
          df_runtime,
          y = df_runtime[, 1],
          x = df_runtime[, 2],
          type = "bar",
          name = "No Occurences of this Word"
        )
      )
    }
  }

# dfm_test <- dfm_arbeit
# #erste Option umschreiben zu Dataframe------------------
# df_test <-
#   convert(dfm_test, to = "data.frame", docvars = docvars(dfm_test))
# df_test$variable_year <- docvars(dfm_test, field = "year")
# df_test$variable_month <- docvars(dfm_test, field = "month")
# df_test$variable_sex <- docvars(dfm_test, field = "sex")
# 
# #zweite Option nutzen des dfm Objekt und die finalen Abfragen dann als Dataframe fomulieren
# data_test <-
#   aggregate(
#     x = df_test$word,
#     by = list(year = df_test$variable_year, sex = df_test$variable_sex),
#     FUN = sum,
#     drop = FALSE
#   )
# sex <- "sex"
# data_test[, sex]
# 
# data_test$x[data_test$sex == 0]
# #bei kleinen Dtaen gibt es das Problem dass die Jahreszahlen nicht gleich sind-----------------
# p <-
#   plot_ly(
#     data = data_test,
#     y = data_test$x[data_test$sex == 1],
#     x = data_test$year[data_test$sex == 1],
#     type = "bar",
#     name = "Male"
#   ) %>%
#   add_trace(y = data_test$x[data_test$sex == 0], name = "Female") %>% layout(yaxis = list(title = 'Count'), barmode = 'group')
# p
#test-------------------------------
# plotte_word_sex("word",
#                 dfm_arbeit,
#                 intervall = "month",
#                 group_by_sex = TRUE)

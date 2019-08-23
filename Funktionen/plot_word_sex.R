


plotte_word_sex <-
  function(word, dfm_input, intervall = "year", group_by_sex) {
    word <- tolower(word)
    if ("year" == intervall) {
      a <- word %in% featnames(dfm_input)
      if (a == TRUE) {
        df_runtime <-
          as.data.frame(matrix(ncol = 4, nrow = nrow(dfm_input)))
        df_runtime$count <- as.vector(dfm_input[, word])
        df_runtime$year <- as.vector(docvars(dfm_input, 'year'))
        df_runtime$month <- as.vector(docvars(dfm_input, 'month'))
        df_runtime$sex <- as.vector(docvars(dfm_input, 'sex'))
        if (group_by_sex == TRUE) {
          p <- plot_ly(
            data = df_runtime ,
            y = sum(df_runtime$count[df_runtime$sex == 1]),
            x = df_runtime$year,
            type = "bar",
            name = "Male"
          ) %>%
            add_trace(y = sum(df_runtime$count[df_runtime$sex == 0]), name = "Female") %>%
            layout(yaxis = list(title = 'Count'), barmode = 'group')
          return(p)
          
        }
        if (group_by_sex == FALSE)
        {
          p <- plot_ly(
            data = df_runtime ,
            y = sum(df_runtime$count),
            x = df_runtime$year,
            type = "bar",
            name = "Counts"
          )
          return(p)
        }
      }
      else if (a == FALSE) {
        df_runtime <-
          data.frame(word_count = as.vector(rep(0, nrow(dfm_input))),
                     Zeit = docvars(dfm_input, 'year'))
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
    if ("month" == intervall) {
      a <- word %in% featnames(dfm_input)
      if (a == TRUE) {
        df_runtime <-
          as.data.frame(matrix(ncol = 4, nrow = nrow(dfm_input)))
        df_runtime$count <- as.vector(dfm_input[, word])
        df_runtime$year <- as.vector(docvars(dfm_input, 'year'))
        df_runtime$month <- as.vector(docvars(dfm_input, 'month'))
        df_runtime$sex <- as.vector(docvars(dfm_input, 'sex'))
        if (group_by_sex == TRUE) {
          p <- plot_ly(
            data = df_runtime ,
            y = sum(df_runtime$count[df_runtime$sex == 1]),
            x = df_runtime$month,
            type = "bar",
            name = "Male"
          ) %>%
            add_trace(y = sum(df_runtime$count[df_runtime$sex == 0]), name = "Female") %>%
            layout(yaxis = list(title = 'Count'), barmode = 'group')
          return(p)
          
        }
        if (group_by_sex == FALSE)
        {
          p <- plot_ly(
            data = df_runtime ,
            y = sum(df_runtime$count),
            x = df_runtime$month,
            type = "bar",
            name = "Counts"
          )
          return(p)
        }
      }
      else if (a == FALSE) {
        df_runtime <-
          data.frame(word_count = as.vector(rep(0, nrow(dfm_input))),
                     Zeit = docvars(dfm_input, 'month'))
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
    
  }

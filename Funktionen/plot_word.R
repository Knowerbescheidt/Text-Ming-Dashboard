#Plot Funktion---------------------------------------
plot_word_func <- function(word, dfm_input, intervall = "year") {
  #month--------
  word <- tolower(word)
  if ("month" == intervall) {
    dfm_runtime <- dfm_group(dfm_input, groups = "month")
    a <- word %in% featnames(dfm_runtime)
    char_title <- "Word frequency by month"
    if (a == TRUE) {
      data_runtime <-
        data.frame(word_count = as.vector(dfm_runtime[, word]),
                   Zeit = docvars(dfm_runtime, 'month'))
      return(
        plot_ly(
          data_runtime ,
          y = data_runtime[, 1],
          x = data_runtime[, 2],
          type = "bar",
          name = char_title
        )
      )
    }
    if (a == FALSE) {
      data_runtime <-
        data.frame(word_count = as.vector(rep(0, nrow(dfm_runtime))),
                   Zeit = docvars(dfm_runtime, 'month'))
      return(
        plot_ly(
          data_runtime,
          y = data_runtime[, 1],
          x = data_runtime[, 2],
          type = "bar",
          name = char_title
        )
      )
    }
  }
  #year----------
  if ("year" == intervall) {
    char_title <- "Word frequency by years"
    dfm_runtime <- dfm_group(dfm_input, groups = "year")
    a <- word %in% featnames(dfm_runtime)
    if (a == TRUE) {
      data_runtime <-
        data.frame(word_count = as.vector(dfm_runtime[, word]),
                   Zeit = docvars(dfm_runtime, 'year'))
      return(
        plot_ly(
          data_runtime ,
          y = data_runtime[, 1],
          x = data_runtime[, 2],
          type = "bar",
          name = char_title
        )
      )
      
    }
    if (a == FALSE) {
      data_runtime <-
        data.frame(word_count = as.vector(rep(0, nrow(dfm_runtime))),
                   Zeit = docvars(dfm_runtime, 'year'))
      return(
        plot_ly(
          data_runtime,
          y = data_runtime[, 1],
          x = data_runtime[, 2],
          type = "bar",
          name = char_title
        )
      )
    }
    
  }
}

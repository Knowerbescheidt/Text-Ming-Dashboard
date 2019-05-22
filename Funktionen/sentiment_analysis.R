lengths(data_dictionary_LSD2015)
Token_data_new <-
  tokens_lookup(Token_data, dictionary = data_dictionary_LSD2015[1:4])
head(Token_data_new, 10)
head(Token_data, 2)
data_dictionary_LSD2015[1]


Token_Test <- Token_data[1:30]
Token_Test

data_good_bad <-
  tokens_lookup(Token_Test, data_dictionary_LSD2015[1:2])
data_good_bad
dfm_sent <- dfm(data_good_bad)
head(dfm_sent, 20)
docvars(dfm_sent)

sentiment_analysis <-
  function(Token_object,
           dictionary = data_dictionary_LSD2015,
           intervall = "year") {
    #month--------
    if ("year" == intervall) {
      Token_sent <-
        tokens_lookup(Token_object, dictionary = dictionary)
      dfm_sent <- dfm(Token_sent)
      
      dfm_runtime <- dfm_group(dfm_sent, groups = "year")
      data_runtime <-
        data.frame(
          sentiment_count_pos = as.vector(dfm_runtime[, "positive"]),
          sentiment_count_neg = as.vector(dfm_runtime[, "negative"]),
          Zeit = docvars(dfm_runtime, 'year')
        )
      return(
        p <- plot_ly(
          data_runtime ,
          y = data_runtime[, 1],
          x = data_runtime[, 3],
          type = "bar",
          name = "Positive"
        )%>%
          add_trace(y = data_runtime[, 2], name = "Negative") %>%
          layout(yaxis = list(title = 'Count'), barmode = 'group')
        
      )
    }
    else
      data_runtime <-
        data.frame(word_count = as.vector(rep(0, nrow(dfm_runtime))),
                   Zeit = docvars(dfm_runtime, 'month'))
      return(
        plot_ly(
          data_runtime,
          y = data_runtime[, 1],
          x = data_runtime[, 2],
          type = "bar",
          name = "char_title"
        )
      )
    
  }
sentiment_analysis(Token_object = Token_data)

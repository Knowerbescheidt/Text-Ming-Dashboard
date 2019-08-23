
data_prep_token <-
  function(pathway = paste0(getwd(), "/Daten/Amazon_data/Musical_Instruments_5.json")) {
    data_amazon <- stream_in(pathway)
    
    #Umwandlung der Zeit in Jahr und dann dem Data Frame hinzugefuegt-------------------
    data_amazon$year <- year(anytime(data_amazon$unixReviewTime))
    data_amazon$month <- month(anytime(data_amazon$unixReviewTime))
    data_amazon$doc_id <- c(1:nrow(data_amazon))
    
    #Aufbereitung-----------------------------------
    corpus_data <-
      corpus(data_amazon, docid_field = "doc_id", text_field = "reviewText")
    Token_data_runtime <-
      tokens(
        corpus_data,
        what = 'word',
        remove_numbers = TRUE,
        remove_symbols = TRUE,
        remove_punct = TRUE,
        include_docvars = TRUE
      )
    Token_data_runtime <-
      tokens_remove(Token_data_runtime, pattern = stopwords("en"))
    return(Token_data_runtime)
    
  }

#Test---------
# Token_test <- data_prep_token()
# head(Token_test)

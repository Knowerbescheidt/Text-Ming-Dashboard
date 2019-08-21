options(stringsAsFactors = F)
data_prep_dfm <-
  function(pathway = paste0(getwd(), "/Daten/Amazon_data/Musical_Instruments_5.json")) {
    data_amazon <- stream_in(pathway)
    
    #Umwandlung der Zeit in Jahr und dann dem Data Frame hinzugefuegt-------------------
    data_amazon$year <- year(anytime(data_amazon$unixReviewTime))
    data_amazon$month <- month(anytime(data_amazon$unixReviewTime))
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
    Token_data <-
      tokens_remove(Token_data, pattern = stopwords("en"))
    
    #DFM Objekt-----------------------------------
    
    dfm_data <- dfm(Token_data)
    docvars(dfm_data, field = "sex") <-
      rep_len(c(1, 0, 0, 1, 0, 1, 1, 1), length.out = length(Token_data))
    return(dfm_data)
  }


# #erste Initialisierung für corpus_data-----------------------
# data_amazon <- stream_in(paste0(getwd(), "/Daten/Amazon_data/Musical_Instruments_5.json"))
#
# #Umwandlung der Zeit in Jahr und dann dem Data Frame hinzugefuegt
# data_amazon$year <- year(anytime(data_amazon$unixReviewTime))
# data_amazon$month <- month(anytime(data_amazon$unixReviewTime))
# data_amazon$doc_id <- c(1:nrow(data_amazon))
#
# #Aufbereitung
# corpus_data <-
#   corpus(data_amazon, docid_field = "doc_id", text_field = "reviewText")

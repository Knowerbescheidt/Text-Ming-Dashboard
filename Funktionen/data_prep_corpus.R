data_prep_corpus <-
  function(pathway = "Daten/Amazon_data/Musical_Instruments_5.json") {
    data_amazon <- stream_in(pathway)
    
    #Umwandlung der Zeit in Jahr und dann dem Data Frame hinzugefuegt-------------
    data_amazon$year <- year(anytime(data_amazon$unixReviewTime))
    data_amazon$month <- month(anytime(data_amazon$unixReviewTime))
    data_amazon$doc_id <- c(1:nrow(data_amazon))
    
    #Aufbereitung-----------------------------------
    corpus_data <-
      corpus(data_amazon, docid_field = "doc_id", text_field = "reviewText")
    return(corpus_data)
  }

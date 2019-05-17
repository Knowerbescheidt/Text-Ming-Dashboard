require(quanteda)

find_coll <- function(Token_object, size, min_count) {
  if(min_count >= 5){
  coll_runtime <- tokens_select(Token_data, pattern = '^[a-z]', 
                        valuetype = 'regex', 
                        case_insensitive = FALSE, 
                        padding = TRUE)
  coll_stat <- textstat_collocations(coll_runtime,min_count = min_count, size = size)
 coll_stat<- coll_stat[order(coll_stat$count,decreasing = TRUE),]
return(coll_stat)}
 else print("your min_count Argument is to low")
  }

#Test hier--------------
find_coll(Token_data,size = 3,min_count = 5)



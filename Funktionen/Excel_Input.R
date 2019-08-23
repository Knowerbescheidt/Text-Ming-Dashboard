

#Import Excel Funktion-------------
import_excel <- function(filename) {
  data_excel <-
    read.xlsx(
      paste0(getwd(),
             "/Daten/Dictionaries/",
             filename),
      sheet = 1,
      cols = 1
    )
  print(typeof(data_excel))
  print(data_excel)
  # name_excel <- as.character(data_excel[1, 1])
  dictio_master <- dictionary(list(words = data_excel[, 1]))
  return(dictio_master)
}

#Import Excels Funktion---------------
import_excels <- function(liste) {
  i <- 1
  dictio_master <- list()
  while (i <= length(liste)) {
    name <- liste[i]
    data_excel <-
      read.xlsx(
        paste0(getwd(),
               "/Daten/Dictionaries/",
               file = name),
        sheet = 1,
        cols = 1
      )
    list_excel <- list(data_excel[, 1])
    names(list_excel) <- name
    dictio_master[[i]] <- dictionary(list_excel)
    names(dictio_master[[i]]) <- name
    i <- i + 1
  }
  return(dictio_master)
}

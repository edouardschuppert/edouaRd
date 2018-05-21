#' povertext
#'
#' Deplete the text value
#'
#' @param val Your data frame
#' @return Return a text, without any accent or links
#' @export

povertext <- function(val){

  val <- stringr::str_to_lower(val)
  val <- stringr::str_remove_all(val, "http(?:s)?://[^[:space:]]*") # Links are deleted
  val <- stringr::str_replace_all(val, "(?:(?:(?:é|ê)|è)|ë)", "e")
  val <- stringr::str_replace_all(val, "(?:(?:à|â)|ä)", "a")
  val <- stringr::str_replace_all(val, "(?:(?:û|ù)|ü)","u")
  val <- stringr::str_replace_all(val, "(?:î|ï)", "i")
  val <- stringr::str_replace_all(val, "(?:ö|ô)", "o")

}

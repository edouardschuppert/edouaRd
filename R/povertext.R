#' povertext
#'
#' Deplete the text value
#' @importFrom stringr str_to_lower
#' @importFrom stringr str_replace_all
#' @param val Your data frame
#' @return Return a text, without any accent or links
#' @export

povertext <- function(val) {

  val <- str_to_lower(val)

  val <- str_remove_all(val, "http(?:s)?://[^[:space:]]*") # Links are deleted

  val <- str_replace_all(val, "\u00E0", "a")
  val <- str_replace_all(val, "\u00E1", "a")
  val <- str_replace_all(val, "\u00E2", "a")
  val <- str_replace_all(val, "\u00E3", "a")
  val <- str_replace_all(val, "\u00E4", "a")
  val <- str_replace_all(val, "\u00E5", "a")

  val <- str_replace_all(val, "\u00E9", "e")
  val <- str_replace_all(val, "\u00E8", "e")
  val <- str_replace_all(val, "\u00EA", "e")
  val <- str_replace_all(val, "\u00EB", "e")

  val <- str_replace_all(val, "\u00EC", "i")
  val <- str_replace_all(val, "\u00ED", "i")
  val <- str_replace_all(val, "\u00EE", "i")
  val <- str_replace_all(val, "\u00EF", "i")

  val <- str_replace_all(val, "\u00F2", "o")
  val <- str_replace_all(val, "\u00F3", "o")
  val <- str_replace_all(val, "\u00F4", "o")
  val <- str_replace_all(val, "\u00F5", "o")
  val <- str_replace_all(val, "\u00F6", "o")

  val <- str_replace_all(val, "\u00F9", "u")
  val <- str_replace_all(val, "\u00FA", "u")
  val <- str_replace_all(val, "\u00FB", "u")
  val <- str_replace_all(val, "\u00FC", "u")

  val <- str_replace_all(val, "\u00FF", "y")
  val <- str_replace_all(val, "\u00FD", "y")

  val <- str_replace_all(val, "\u00E7", "c")
  val <- str_replace_all(val, "\u00E6", "ae")
  val <- str_replace_all(val, "\u00F1", "n")

  val

}

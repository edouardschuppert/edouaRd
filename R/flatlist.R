#' flatlist
#'
#' @param df Your data frame
#' @return allows you to manage the columns of an array in list format, transforming them into character columns.
#' @export

flatlist <- function(df) {

  i <- as.numeric(length(df))

  while (i != 0) {

    x <- df %>%
      dplyr::select(i)

    stock <- names(x)

    names(x) <- "temp_name"

    if (class(x$temp_name) == "list") {

      x <- x %>%
        dplyr::mutate(temp_name = as.character(temp_name))

    }

    names(x) <- stock

    if (exists("newtab") == TRUE) {

      newtab <- cbind(x, newtab)

    }

    if (exists("newtab") == FALSE) {

      newtab <- x

    }

    rm(x, stock)

    i <- i - 1
  }

  newtab

}

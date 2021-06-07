#' flatlist
#'
#' @param df Your data frame
#' @importFrom dplyr select
#' @importFrom dplyr mutate
#' @return allows you to manage the columns of an array in list format, transforming them into character columns.
#' @export

flatlist <- function(df) {

  i <- as.numeric(length(df))

  while (i != 0) {

    x <- df %>% select(i)

    stock <- names(x)

    names(x) <- "temp_name"

    classe <- as.character(class(x$temp_name))

    if (any(classe == "list")) x <- x %>% mutate(temp_name = as.character(.data$temp_name))

    names(x) <- stock

    if (exists("newtab") == TRUE) newtab <- cbind(x, newtab)
    if (exists("newtab") == FALSE) newtab <- x

    i <- i - 1
  }

  newtab

}

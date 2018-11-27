#' replaceByZero
#'
#' @param df Your data frame
#' @return Return a dataframe with no NA cells
#' @export

replaceByZero <- function(df) {

  df[is.na(df) == TRUE] <- 0

  df

}

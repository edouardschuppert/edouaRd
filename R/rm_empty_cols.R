#' rm_empty_cols
#'
#' @param df Your data frame
#' @return Delete columns containing only NAs.
#' @export

rm_empty_cols <- function(df) {

  df[,!apply(df, 2, function(x) all(gsub(" ", "", x)=="", na.rm=TRUE))]

}

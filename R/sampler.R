#' sampler
#'
#' @param df Your data frame
#' @param nb Number of observations for the sample
#' @return Return a sample of a dataframe
#' @export

sampler <- function(df, nb = nrow(df)) {

  df[sample(1:as.numeric(nrow(df)), nb),]

}

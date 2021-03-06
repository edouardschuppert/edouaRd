#' choose_period
#'
#' Time Filter function
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param startday The first day of the period you want to select
#' @param endday The last day of the period you want to select
#' @param starttime The start time of the period you want to select. Default set to 00:00:00
#' @param endtime The end time of the period you want to select. Default set to 23:59:59
#' @param sort Gives the possibility to arrange the table, in ascending order
#' @return Return the observations between the two specified dates
#' @export

choose_period <- function(df, colonne, startday, endday, starttime = "00:00:00", endtime = "23:59:59", sort = FALSE) {

  # Convert the range you want to timestamp format
  starttimestamp <- as.integer(lubridate::as_datetime(paste(startday, starttime)))
  endtimestamp <- as.integer(lubridate::as_datetime(paste(endday, endtime)))

  colonne <- rlang::enquo(colonne)

  # Sort the range
  df <- df %>%
    dplyr::filter(!!colonne >= starttimestamp &
           !!colonne <= endtimestamp)

  # Arrange the range
  if (sort == TRUE) {

  df <- df %>%
    dplyr::arrange(!!colonne)

  }

  df

}

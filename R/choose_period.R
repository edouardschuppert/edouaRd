#' choose_period
#'
#' Time Filter function
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param startday The first day of the period you want to select
#' @param endday The last day of the period you want to select
#' @param starttime The start time of the period you want to select. Default set to 00:00:00
#' @param andtime The end time of the period you want to select. Default set to 23:59:59
#' @return Return the observations between the two specified dates
#' @export

choose_period <- function(df, colonne, startday, endday, starttime = "00:00:00", endtime = "23:59:59"){

  starttimestamp <- as.integer(lubridate::as_datetime(paste(startday, starttime)))
  endtimestamp <- as.integer(lubridate::as_datetime(paste(endday, endtime)))

  colonne <- rlang::enquo(colonne)

  df %>%
    dplyr::filter(!!colonne > starttimestamp &
           !!colonne < endtimestamp)

}

# Ajouter choose_periode pour l'importation (selection SQL)

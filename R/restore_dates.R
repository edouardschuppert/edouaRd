#' restore_dates
#'
#' @param column Your column
#' @return Returns a column of datetimes compatible with R
#' @export

restore_dates <- function(column) {

  column <- dplyr::as_data_frame(as.character(column)) %>%
    dplyr::mutate(temp = value,
                  Day = stringr::str_extract(temp, "^[[:digit:]]+"),
                  Month = stringr::str_extract(temp, "/[[:digit:]]+/"),
                  Month = stringr::str_remove_all(Month, "/"),
                  Year = stringr::str_extract(temp, "/[[:digit:]]+[[:space:]]"),
                  Year = stringr::str_remove_all(Year, "(?:/|[[:space:]]+)"),
                  Hour = stringr::str_extract(temp, "[[:space:]][[:digit:]]+:"),
                  Hour = stringr::str_remove_all(Hour, "(?::|[[:space:]]+)"),
                  Minutes = stringr::str_extract(temp, ":[[:digit:]]+:"),
                  Minutes = stringr::str_remove_all(Minutes, ":"),
                  Seconds = stringr::str_extract(temp, "[[:digit:]]+$"))

  column = lubridate::as_datetime(paste0(column$Year, "-", column$Month, "-", column$Day, " ", column$Hour, ":", column$Minutes, ":", column$Seconds))

  column

}

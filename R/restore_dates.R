#' restore_dates
#'
#' @param column Your column
#' @return Returns a column of datetimes compatible with R
#' @export

restore_dates <- function(column) {

  column <- dplyr::as_data_frame(as.character(column)) %>%
    dplyr::mutate(temp = .data$value,
                  Day = stringr::str_extract(.data$temp, "^[[:digit:]]+"),
                  Month = stringr::str_extract(.data$temp, "/[[:digit:]]+/"),
                  Month = stringr::str_remove_all(.data$Month, "/"),
                  Year = stringr::str_extract(.data$temp, "/[[:digit:]]+[[:space:]]"),
                  Year = stringr::str_remove_all(.data$Year, "(?:/|[[:space:]]+)"),
                  Hour = stringr::str_extract(.data$temp, "[[:space:]][[:digit:]]+:"),
                  Hour = stringr::str_remove_all(.data$Hour, "(?::|[[:space:]]+)"),
                  Minutes = stringr::str_extract(.data$temp, ":[[:digit:]]+:"),
                  Minutes = stringr::str_remove_all(.data$Minutes, ":"),
                  Seconds = stringr::str_extract(.data$temp, "[[:digit:]]+$"))

  column = lubridate::as_datetime(paste0(column$Year, "-", column$Month, "-", column$Day, " ", column$Hour, ":", column$Minutes, ":", column$Seconds))

  column

}

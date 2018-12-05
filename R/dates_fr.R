#' datetimes_fr
#'
#' @param datum Your datetime. DEFAULT set to Sys.time()
#' @return Turn your datetime into a french format
#' @export

datetimes_fr <- function(datum = Sys.time()) {

  # Separation of original elements and formatting
  datum <- dplyr::as_data_frame(lubridate::as_datetime(datum)) %>%
    dplyr::rename(datum = .data$value) %>%
    dplyr::mutate(datum = as.character(datum)) %>%
    dplyr::mutate(secondes = as.character(lubridate::second(datum)),
                  secondes = dplyr::recode(.data$secondes,
                                   "0" = "00",
                                   "1" = "01",
                                   "2" = "02",
                                   "3" = "03",
                                   "4" = "04",
                                   "5" = "05",
                                   "6" = "06",
                                   "7" = "07",
                                   "8" = "08",
                                   "9" = "09")) %>%
    dplyr::mutate(jours = as.character(lubridate::day(datum)),
                  jours = dplyr::recode(.data$jours,
                                   "0" = "00",
                                   "1" = "01",
                                   "2" = "02",
                                   "3" = "03",
                                   "4" = "04",
                                   "5" = "05",
                                   "6" = "06",
                                   "7" = "07",
                                   "8" = "08",
                                   "9" = "09")) %>%
    dplyr::mutate(mois = as.character(lubridate::month(datum)),
                  mois = dplyr::recode(.data$mois,
                                   "0" = "00",
                                   "1" = "01",
                                   "2" = "02",
                                   "3" = "03",
                                   "4" = "04",
                                   "5" = "05",
                                   "6" = "06",
                                   "7" = "07",
                                   "8" = "08",
                                   "9" = "09")) %>%
    dplyr::mutate(minutes = as.character(lubridate::minute(datum)),
                  minutes = dplyr::recode(.data$minutes,
                                   "0" = "00",
                                   "1" = "01",
                                   "2" = "02",
                                   "3" = "03",
                                   "4" = "04",
                                   "5" = "05",
                                   "6" = "06",
                                   "7" = "07",
                                   "8" = "08",
                                   "9" = "09")) %>%
    dplyr::mutate(heures = as.character(lubridate::hour(datum)),
                  heures = dplyr::recode(.data$heures,
                                   "0" = "00",
                                   "1" = "01",
                                   "2" = "02",
                                   "3" = "03",
                                   "4" = "04",
                                   "5" = "05",
                                   "6" = "06",
                                   "7" = "07",
                                   "8" = "08",
                                   "9" = "09"))

  # Reassembly
  datum <- as.character(paste0(datum$jours, "/", datum$mois, "/", lubridate::year(datum$datum), " ", datum$heures, ":", datum$minutes, ":", datum$secondes))

  datum

}

#' dates_fr
#'
#' @param datum Your date. DEFAULT set to Sys.time()
#' @return Turn your date into a french format
#' @export

dates_fr <- function(datum = Sys.time()) {

  datum <- lubridate::as_date(datum)

  # Separation of original elements and formatting
  datum <- dplyr::as_data_frame(lubridate::as_datetime(datum)) %>%
    dplyr::rename(datum = .data$value) %>%
    dplyr::mutate(datum = as.character(datum)) %>%
    dplyr::mutate(jours = as.character(lubridate::day(datum)),
                  jours = dplyr::recode(.data$jours,
                                        "0" = "00",
                                        "1" = "01",
                                        "2" = "02",
                                        "3" = "03",
                                        "4" = "04",
                                        "5" = "05",
                                        "6" = "06",
                                        "7" = "07",
                                        "8" = "08",
                                        "9" = "09")) %>%
    dplyr::mutate(mois = as.character(lubridate::month(datum)),
                  mois = dplyr::recode(.data$mois,
                                       "0" = "00",
                                       "1" = "01",
                                       "2" = "02",
                                       "3" = "03",
                                       "4" = "04",
                                       "5" = "05",
                                       "6" = "06",
                                       "7" = "07",
                                       "8" = "08",
                                       "9" = "09"))

  # Reassembly
  datum <- as.character(paste0(datum$jours, "/", datum$mois, "/", lubridate::year(datum$datum)))

  datum

}

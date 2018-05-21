#' datetimes_fr
#'
#' @param datum Your date. DEFAULT set to Sys.time()
#' @return Turn your date into a french format
#' @export

datetimes_fr <- function(datum = Sys.time()) {

  datum <- dplyr::as_data_frame(lubridate::as_datetime(datum)) %>%
    dplyr::rename(datum = value) %>%
    dplyr::mutate(datum = as.character(datum)) %>%
    dplyr::mutate(secondes = as.character(lubridate::second(datum)),
                  secondes = dplyr::recode(secondes,
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
                  jours = dplyr::recode(jours,
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
                  mois = dplyr::recode(mois,
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
                  minutes = dplyr::recode(minutes,
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
                  heures = dplyr::recode(heures,
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

  datum <- as.character(paste0(datum$jours, "/", datum$mois, "/", lubridate::year(datum$datum), " ", datum$heures, ":", datum$minutes, ":", datum$secondes))

  datum

}

# dates_fr <- function(date) {
#
#   date <- as_date(date)
#
#   jour <- day(date)
#   if (jour == 1) jour = "01"
#   if (jour == 2) jour = "02"
#   if (jour == 3) jour = "03"
#   if (jour == 4) jour = "04"
#   if (jour == 5) jour = "05"
#   if (jour == 6) jour = "06"
#   if (jour == 7) jour = "07"
#   if (jour == 8) jour = "08"
#   if (jour == 9) jour = "09"
#
#   mois <- month(date)
#   if (mois == 1) mois = "01"
#   if (mois == 2) mois = "02"
#   if (mois == 3) mois = "03"
#   if (mois == 4) mois = "04"
#   if (mois == 5) mois = "05"
#   if (mois == 6) mois = "06"
#   if (mois == 7) mois = "07"
#   if (mois == 8) mois = "08"
#   if (mois == 9) mois = "09"
#
#   date <- paste0(jour, "/", mois, "/", year(date))
#
#   date
# }

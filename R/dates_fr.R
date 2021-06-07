#' datetimes_fr
#'
#' @param datum Your datetime. DEFAULT set to Sys.time()
#' @import dplyr
#' @import lubridate
#' @importFrom tibble tibble
#' @return Turn your datetime into a french format
#' @export

datetimes_fr <- function(datum = Sys.time()) {

  # Separation of original elements and formatting
  datum <- tibble(value = as_datetime(datum)) %>%
    rename(datum = .data$value) %>%
    mutate(datum = as.character(datum)) %>%
    mutate(secondes = as.character(second(datum)),
           secondes = recode(.data$secondes,
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
    mutate(jours = as.character(day(datum)),
           jours = recode(.data$jours,
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
    mutate(mois = as.character(month(datum)),
           mois = recode(.data$mois,
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
    mutate(minutes = as.character(minute(datum)),
           minutes = recode(.data$minutes,
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
    mutate(heures = as.character(hour(datum)),
           heures = recode(.data$heures,
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
  datum <- as.character(paste0(datum$jours, "/", datum$mois, "/", year(datum$datum), " ", datum$heures, ":", datum$minutes, ":", datum$secondes))

  datum

}

#' dates_fr
#'
#' @param datum Your date. DEFAULT set to Sys.time()
#' @return Turn your date into a french format
#' @export

dates_fr <- function(datum = Sys.time()) {

  datum <- as_date(datum)

  # Separation of original elements and formatting
  datum <- tibble(value = as_datetime(datum)) %>%
    rename(datum = .data$value) %>%
    mutate(datum = as.character(datum)) %>%
    mutate(jours = as.character(day(datum)),
           jours = recode(.data$jours,
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
    mutate(mois = as.character(month(datum)),
           mois = recode(.data$mois,
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
  datum <- as.character(paste0(datum$jours, "/", datum$mois, "/", year(datum$datum)))

  datum

}

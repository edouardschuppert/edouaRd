#' distribution_time
#'
#' Check the temporal distribution of a table.
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param granularity Change the granularity of the work, possible: "year", "month", "day", "hour", "minute","second". Default set to "day"
#' @param draw Ability to return a ggplot2 schema to view the distribution. Default set to FALSE
#' @return Returns a distribution table
#' @export

distribution_time <- function(df, colonne, granularity = "day", draw = FALSE) {

  colonne <- rlang::enquo(colonne)

  # Per second
  if (granularity == "second") {

    df <- df %>%
      dplyr::mutate(Seconde = lubridate::second(!!colonne)) %>%
      dplyr::mutate(Minute = lubridate::minute(!!colonne)) %>%
      dplyr::mutate(Heure = lubridate::hour(!!colonne)) %>%
      dplyr::mutate(Jour = lubridate::day(!!colonne)) %>%
      dplyr::mutate(Mois = lubridate::month(!!colonne)) %>%
      dplyr::mutate(Annee = lubridate::year(!!colonne)) %>%
      dplyr::group_by(Annee, Mois, Jour, Heure, Minute, Seconde) %>%
      dplyr::summarise(n = dplyr::n()) %>%
      dplyr::mutate(Date = lubridate::ymd_hms(paste(Annee, "-", Mois, "-", Jour, " ", Heure, ":", Minute, ":", Seconde)))

    df <- dplyr::data_frame(created_at = df$Date, n = df$n)

    if (draw == TRUE) {

      df <- df %>%
        ggplot2::ggplot(ggplot2::aes(created_at, n)) +
        ggplot2::geom_line()

    }



  }

  # Per minute
  if (granularity == "minute") {

    df <- df %>%
      dplyr::mutate(Minute = lubridate::minute(!!colonne)) %>%
      dplyr::mutate(Heure = lubridate::hour(!!colonne)) %>%
      dplyr::mutate(Jour = lubridate::day(!!colonne)) %>%
      dplyr::mutate(Mois = lubridate::month(!!colonne)) %>%
      dplyr::mutate(Annee = lubridate::year(!!colonne)) %>%
      dplyr::group_by(Annee, Mois, Jour, Heure, Minute) %>%
      dplyr::summarise(n = dplyr::n()) %>%
      dplyr::mutate(Date = lubridate::ymd_hms(paste(Annee, "-", Mois, "-", Jour, " ", Heure, ":", Minute, ":00")))

    df <- dplyr::data_frame(created_at = df$Date, n = df$n)

    if (draw == TRUE) {

      df <- df %>%
        ggplot2::ggplot(ggplot2::aes(created_at, n)) +
        ggplot2::geom_line()

    }



  }

  # Per hour
  if (granularity == "hour") {

    df <- df %>%
      dplyr::mutate(Heure = lubridate::hour(!!colonne)) %>%
      dplyr::mutate(Jour = lubridate::day(!!colonne)) %>%
      dplyr::mutate(Mois = lubridate::month(!!colonne)) %>%
      dplyr::mutate(Annee = lubridate::year(!!colonne)) %>%
      dplyr::group_by(Annee, Mois, Jour, Heure) %>%
      dplyr::summarise(n = dplyr::n()) %>%
      dplyr::mutate(Date = lubridate::ymd_hms(paste(Annee, "-", Mois, "-", Jour, " ", Heure, ":00:00")))

    df <- dplyr::data_frame(created_at = df$Date, n = df$n)

    if (draw == TRUE) {

      df <- df %>%
        ggplot2::ggplot(ggplot2::aes(created_at, n)) +
        ggplot2::geom_line()

    }



  }

  # Per day
  if (granularity == "day") {

    df <- df %>%
    dplyr::mutate(Jour = lubridate::day(!!colonne)) %>%
    dplyr::mutate(Mois = lubridate::month(!!colonne)) %>%
    dplyr::mutate(Annee = lubridate::year(!!colonne)) %>%
    dplyr::group_by(Annee, Mois, Jour) %>%
    dplyr::summarise(n = dplyr::n()) %>%
    dplyr::mutate(Date = lubridate::ymd(paste(Annee, "-", Mois, "-", Jour)))

    df <- dplyr::data_frame(created_at = df$Date, n = df$n)

    if (draw == TRUE) {

      df <- df %>%
        ggplot2::ggplot(ggplot2::aes(created_at, n)) +
        ggplot2::geom_line()

    }



  }

  # Per month
  if (granularity == "month") {

    df <- df %>%
      dplyr::mutate(Mois = lubridate::month(!!colonne)) %>%
      dplyr::mutate(Annee = lubridate::year(!!colonne)) %>%
      dplyr::group_by(Annee, Mois) %>%
      dplyr::summarise(n = dplyr::n()) %>%
      dplyr::mutate(Date = lubridate::ymd(paste(Annee, "-", Mois, "-01")))

    if (draw == TRUE) {

      df <- dplyr::data_frame(created_at = df$Date, n = df$n)

      df <- df %>%
        ggplot2::ggplot(ggplot2::aes(created_at, n)) +
        ggplot2::geom_line()

    }

    if (draw == FALSE) {

    df <- dplyr::data_frame(created_at = df$Date, n = df$n) %>%
      dplyr::mutate(created_at = stringr::str_remove(created_at, rex::rex("-01", end)))

    }



  }

  # Per year
  if (granularity == "year") {

    df <- df %>%
      dplyr::mutate(Annee = lubridate::year(!!colonne)) %>%
      dplyr::group_by(Annee) %>%
      dplyr::summarise(n = dplyr::n()) %>%
      dplyr::mutate(Date = lubridate::ymd(paste(Annee, "-01-01")))

    if (draw == TRUE) {

      df <- dplyr::data_frame(created_at = df$Date, n = df$n)

      df <- df %>%
        ggplot2::ggplot(ggplot2::aes(created_at, n)) +
        ggplot2::geom_line()

    }

    if (draw == FALSE) {

      df <- dplyr::data_frame(created_at = df$Date, n = df$n) %>%
        dplyr::mutate(created_at = stringr::str_remove(created_at, rex::rex("-01-01", end)))

    }



  }

  df


}

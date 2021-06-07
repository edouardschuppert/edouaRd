#' distribution_time
#'
#' Check the temporal distribution of a table.
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param granularity Change the granularity of the work, possible: "year", "month", "day", "hour", "minute","second". Default set to "day"
#' @param draw Ability to return a ggplot2 schema to view the distribution. Default set to FALSE
#' @importFrom rlang enquo
#' @importFrom dplyr mutate
#' @importFrom dplyr group_by
#' @importFrom dplyr summarise
#' @importFrom tibble tibble
#' @importFrom dplyr n
#' @import lubridate
#' @import ggplot2
#' @importFrom stringr str_remove
#' @return Returns a distribution table
#' @export

distribution_time <- function(df, colonne, granularity = "day", draw = FALSE) {

  colonne <- enquo(colonne)

  # Per second
  if (granularity == "second") {

    df <- df %>%
      mutate(Seconde = second(!!colonne)) %>%
      mutate(Minute = minute(!!colonne)) %>%
      mutate(Heure = hour(!!colonne)) %>%
      mutate(Jour = day(!!colonne)) %>%
      mutate(Mois = month(!!colonne)) %>%
      mutate(Annee = year(!!colonne)) %>%
      group_by(.data$Annee, .data$Mois, .data$Jour, .data$Heure, .data$Minute, .data$Seconde) %>%
      summarise(n = n()) %>%
      mutate(Date = ymd_hms(paste(.data$Annee, "-", .data$Mois, "-", .data$Jour, " ", .data$Heure, ":", .data$Minute, ":", .data$Seconde)))

    df <- tibble(created_at = df$Date, n = df$n)

    if (draw == TRUE) {

      df <- df %>%
        ggplot(aes(.data$created_at, n)) +
        geom_line()

    }



  }

  # Per minute
  if (granularity == "minute") {

    df <- df %>%
      mutate(Minute = minute(!!colonne)) %>%
      mutate(Heure = hour(!!colonne)) %>%
      mutate(Jour = day(!!colonne)) %>%
      mutate(Mois = month(!!colonne)) %>%
      mutate(Annee = year(!!colonne)) %>%
      group_by(.data$Annee, .data$Mois, .data$Jour, .data$Heure, .data$Minute) %>%
      summarise(n = n()) %>%
      mutate(Date = ymd_hms(paste(.data$Annee, "-", .data$Mois, "-", .data$Jour, " ", .data$Heure, ":", .data$Minute, ":00")))

    df <- tibble(created_at = df$Date, n = df$n)

    if (draw == TRUE) {

      df <- df %>%
        ggplot(aes(.data$created_at, n)) +
        geom_line()

    }



  }

  # Per hour
  if (granularity == "hour") {

    df <- df %>%
      mutate(Heure = hour(!!colonne)) %>%
      mutate(Jour = day(!!colonne)) %>%
      mutate(Mois = month(!!colonne)) %>%
      mutate(Annee = year(!!colonne)) %>%
      group_by(.data$Annee, .data$Mois, .data$Jour, .data$Heure) %>%
      summarise(n = n()) %>%
      mutate(Date = ymd_hms(paste(.data$Annee, "-", .data$Mois, "-", .data$Jour, " ", .data$Heure, ":00:00")))

    df <- tibble(created_at = df$Date, n = df$n)

    if (draw == TRUE) {

      df <- df %>%
        ggplot(aes(.data$created_at, n)) +
        geom_line()

    }



  }

  # Per day
  if (granularity == "day") {

    df <- df %>%
      mutate(Jour = day(!!colonne)) %>%
      mutate(Mois = month(!!colonne)) %>%
      mutate(Annee = year(!!colonne)) %>%
      group_by(.data$Annee, .data$Mois, .data$Jour) %>%
      summarise(n = n()) %>%
      mutate(Date = ymd(paste(.data$Annee, "-", .data$Mois, "-", .data$Jour)))

    df <- tibble(created_at = df$Date, n = df$n)

    if (draw == TRUE) {

      df <- df %>%
        ggplot(aes(.data$created_at, n)) +
        geom_line()

    }



  }

  # Per month
  if (granularity == "month") {

    df <- df %>%
      mutate(Mois = month(!!colonne)) %>%
      mutate(Annee = year(!!colonne)) %>%
      group_by(.data$Annee, .data$Mois) %>%
      summarise(n = n()) %>%
      mutate(Date = ymd(paste(.data$Annee, "-", .data$Mois, "-01")))

    if (draw == TRUE) {

      df <- tibble(created_at = df$Date, n = df$n)

      df <- df %>%
        ggplot(aes(.data$created_at, n)) +
        geom_line()

    }

    if (draw == FALSE) {

      df <- tibble(created_at = df$Date, n = df$n) %>%
        mutate(created_at = str_remove(.data$created_at, "-01$"))

    }



  }

  # Per year
  if (granularity == "year") {

    df <- df %>%
      mutate(Annee = year(!!colonne)) %>%
      group_by(.data$Annee) %>%
      summarise(n = n()) %>%
      mutate(Date = ymd(paste(.data$Annee, "-01-01")))

    if (draw == TRUE) {

      df <- tibble(created_at = df$Date, n = df$n)

      df <- df %>%
        ggplot(aes(.data$created_at, n)) +
        geom_line()

    }

    if (draw == FALSE) {

      df <- tibble(created_at = df$Date, n = df$n) %>%
        mutate(created_at = str_remove(.data$created_at, "-01-01$"))

    }



  }

  df


}

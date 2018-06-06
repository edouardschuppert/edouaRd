#' distribution_time
#'
#' Check the temporal distribution of a table.
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param draw Ability to return a ggplot2 schema to view the distribution. Default set to FALSE
#' @return Returns a distribution table
#' @export

distribution_time <- function(df, colonne, draw = FALSE){

  colonne <- rlang::enquo(colonne)

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

  df

}

# Ajouter possibilité de plot
# Ajouter choix de la granularité

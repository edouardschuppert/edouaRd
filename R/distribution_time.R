#' distribution_time
#'
#' Check the time distribution of a data frame
#'
#' @param df Your data frame
#' @param colonne Your column
#' @return Return a data frame with the distribution
#' @export

distribution_time <- function(df, colonne){

  colonne <- rlang::enquo(colonne)

  df <- df %>%
    dplyr::mutate(Jour = lubridate::day(!!colonne)) %>%
    dplyr::mutate(Mois = lubridate::month(!!colonne)) %>%
    dplyr::mutate(Annee = lubridate::year(!!colonne)) %>%
    dplyr::group_by(Annee, Mois, Jour) %>%
    dplyr::summarise(n = dplyr::n()) %>%
    dplyr::mutate(Date = lubridate::ymd(paste(Annee, "-", Mois, "-", Jour)))

  df <- dplyr::data_frame(created_at = df$Date, n = df$n)

  df

}

# Ajouter possibilité de plot
# Ajouter choix de la granularité

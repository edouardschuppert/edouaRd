#' wordfrenquency
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param slice Allows you to keep only a small number of observations, starting from the first. Default set to NA
#' @return Return the word frequency of the column you chose
#' @export

wordfrequency <- function(df, colonne, slice = NA) {

  colonne <- rlang::enquo(colonne)

  # Loading wordfrequency dictionary
  wf_dictionary <- edouaRd::wf_dictionary

  # Processing
  df <- df %>%
    dplyr::select(!!colonne) %>%
    dplyr::mutate(colonne = povertext(!!colonne)) %>%
    tidytext::unnest_tokens(.data$words, colonne) %>%
    dplyr::select(- !!colonne) %>%
    dplyr::filter(is.na(.data$words) == FALSE) %>%
    dplyr::anti_join(wf_dictionary, by = "words") %>%
    dplyr::count(.data$words) %>%
    dplyr::arrange(desc(n))

  # Keep only the desired length
  if (is.na(slice) == FALSE) {

    df <- df %>%
      dplyr::slice(1:slice)

  }

  df

}

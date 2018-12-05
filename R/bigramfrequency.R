#' bigramfrequency
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param slice Allows you to keep only a small number of observations, starting from the first. Default set to NA
#' @return Return the bigram frequency of the column you chose
#' @export

bigramfrequency <- function(df, colonne, slice = NA) {

  colonne <- rlang::enquo(colonne)

  # Loading wordfrequency dictionary
  wf_dictionary <- edouaRd::wf_dictionary

  # Processing
  df <- df %>%
    dplyr::select(!!colonne) %>%
    dplyr::mutate(colonne = povertext(!!colonne)) %>%
    tidytext::unnest_tokens(.data$bigram, colonne, token = "ngrams", n = 2, to_lower = TRUE) %>%
    dplyr::select(- !!colonne) %>%
    tidyr::separate(.data$bigram, c("bigram1", "bigram2"), sep = " ") %>%
    dplyr::anti_join(wf_dictionary, by = c("bigram1" = "words")) %>%
    dplyr::anti_join(wf_dictionary, by = c("bigram2" = "words")) %>%
    tidyr::unite(.data$bigram, .data$bigram1, .data$bigram2, sep = " ") %>%
    dplyr::count(.data$bigram) %>%
    dplyr::arrange(desc(n))

  # Keep only the desired length
  if (is.na(slice) == FALSE) {

    df <- df %>%
      dplyr::slice(1:slice)

  }

  df

}

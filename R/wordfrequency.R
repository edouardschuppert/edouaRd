#' wordfrenquency
#'
#' @param df Your data frame
#' @param colonne Your column
#' @return Return the word frequency of the column you chose
#' @export

wordfrequency <- function(df, colonne) {

  colonne <- rlang::enquo(colonne)

  wf_dictionary <- edouaRd::wf_dictionary

  wf <- df %>%
    dplyr::select(!!colonne) %>%
    dplyr::mutate(colonne = povertext(!!colonne)) %>%
    tidytext::unnest_tokens(words, colonne) %>%
    dplyr::select(- !!colonne) %>%
    dplyr::filter(is.na(words) == FALSE) %>%
    dplyr::anti_join(wf_dictionary, by = "words") %>%
    dplyr::count(words) %>%
    dplyr::arrange(desc(n))

}

# Ajouter slice dans la fonction

#' hashtagfrequency
#'
#' @param df Your data frame
#' @param colonne Your column
#' @return Return the hashtag frequency of the column you chose
#' @export

hashtagfrequency <- function(df, colonne) {

  colonne <- rlang::enquo(colonne)

  df %>%
    dplyr::select(!!colonne) %>%
    dplyr::mutate(colonne = povertext(!!colonne)) %>%
    dplyr::mutate(hash = as.character(stringr::str_extract_all(colonne, "(?:(?:^|[[:space:]]+)|(?:[[:punct:]])?)#(?:[^[:blank:]]*|[^[:space:]]*)(?:(?:(?:[[:punct:]])?|[[:space:]])|$)"))) %>%
    dplyr::mutate(hash = stringr::str_remove_all(hash, "\"")) %>%
    dplyr::mutate(hash = stringr::str_remove_all(hash, rex::rex("c(" %or% ")" %or% "[[:punct:]]" %or% ","))) %>%
    tidytext::unnest_tokens(words, hash) %>%
    dplyr::filter(is.na(words) == FALSE) %>%
    dplyr::mutate(words = stringr::str_remove_all(words, "[[:space:]]+")) %>%
    dplyr::count(words) %>%
    dplyr::arrange(desc(n)) %>%
    dplyr::mutate(hashtags = paste0("#", words)) %>%
    dplyr::select(hashtags, n)

}

# Ajouter slice dans la fonction

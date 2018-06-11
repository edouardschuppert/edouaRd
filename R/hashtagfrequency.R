#' hashtagfrequency
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param slice Allows you to keep only a small number of observations, starting from the first. Default set to NA
#' @return Return the hashtag frequency of the column you chose
#' @export

hashtagfrequency <- function(df, colonne, slice = NA) {

  colonne <- rlang::enquo(colonne)

  # Processing
  df <- df %>%
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
    dplyr::select(hashtags, n) %>%
    dplyr::filter(stringr::str_detect(hashtags, paste(c("^#character$", "^#0$"), collapse = "|")) == FALSE)

  # Keep only the desired length
  if (is.na(slice) == FALSE) {

    df <- df %>%
      dplyr::slice(1:slice)

  }

  df

}

# Récupérer bon hashtags avec la casse par système de tableau comparatif
# Ejecter hashtags déchets

# temp <- edouaRd::rstats %>%
#   hashtagfrequency(text)

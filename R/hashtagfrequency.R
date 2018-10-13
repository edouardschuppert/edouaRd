#' hashtagfrequency
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param slice Allows you to keep only a small number of observations, starting from the first. Default set to NA
#' @param original Returns the original case of hashtags. Caution : can be very slow. Default set to FALSE
#' @return Return the hashtag frequency of the column you chose
#' @export

hashtagfrequency <- function(df, colonne, slice = NA, original = FALSE) {

  colonne <- rlang::enquo(colonne)

  # Processing
  df_new <- df %>%
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

  df_new <- df_new %>%
    dplyr::filter(hashtags != "#n" &
                    hashtags != "#0" &
                    hashtags != "#u" &
                    hashtags != "#character")

  # Keep only the desired length
  if (is.na(slice) == FALSE) {

    df_new <- df_new %>%
      dplyr::slice(1:slice)

  }

  # Search the original hashtag case
  if (original == TRUE) {

    i <- as.numeric(nrow(df_new))
    while (i != 0) {

      temp_request <- df_new$hashtags[i]

      request <- df %>%
        dplyr::filter(stringr::str_detect(povertext(!!colonne), temp_request)) %>%
        dplyr::mutate(text = !!colonne,
                      text =  stringr::str_replace_all(text, "(?:(?:(?:é|ê)|è)|ë)", "e"),
                      text = stringr::str_replace_all(text, "(?:(?:à|â)|ä)", "a"),
                      text = stringr::str_replace_all(text, "(?:(?:û|ù)|ü)","u"),
                      text = stringr::str_replace_all(text, "(?:î|ï)", "i"),
                      text = stringr::str_replace_all(text, "(?:ö|ô)", "o")) %>%
        dplyr::mutate(xx = stringr::str_extract(text, stringr::regex(temp_request, ignore_case = TRUE))) %>%
        dplyr::count(xx, sort = TRUE)

      df_new$hashtags[i] <- request$xx[1]

      rm(temp_request, request)

      i <- i - 1
    }


  }

  df_new

}

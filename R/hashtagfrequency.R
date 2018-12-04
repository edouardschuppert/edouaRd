#' hashtagfrequency
#'
#' @import dplyr
#' @import stringr
#' @importFrom tidytext unnest_tokens
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
    select(!!colonne) %>%
    mutate(colonne = povertext(!!colonne)) %>%
    mutate(hash = as.character(str_extract_all(colonne, "(?:(?:^|[[:space:]]+)|(?:[[:punct:]])?)#(?:[^[:blank:]]*|[^[:space:]]*)(?:(?:(?:[[:punct:]])?|[[:space:]])|$)"))) %>%
    mutate(hash = str_remove_all(hash, "\"")) %>%
    mutate(hash = str_remove_all(hash, rex::rex("c(" %or% ")" %or% "[[:punct:]]" %or% ","))) %>%
    unnest_tokens(words, hash) %>%
    filter(is.na(words) == FALSE) %>%
    mutate(words = str_remove_all(words, "[[:space:]]+")) %>%
    count(words) %>%
    arrange(desc(n)) %>%
    mutate(hashtags = paste0("#", words)) %>%
    select(hashtags, n)

  df_new <- df_new %>%
    filter(hashtags != "#n" &
                    hashtags != "#0" &
                    hashtags != "#u" &
                    hashtags != "#character")

  # Keep only the desired length
  if (is.na(slice) == FALSE) {

    df_new <- df_new %>%
      slice(1:slice)

  }

  # Search the original hashtag case
  if (original == TRUE) {

    i <- as.numeric(nrow(df_new))
    while (i != 0) {

      temp_request <- df_new$hashtags[i]

      request <- df %>%
        filter(str_detect(povertext(!!colonne), temp_request)) %>%
        mutate(text = !!colonne,
               text = str_replace_all(val, "\u00E0", "a"),
               text = str_replace_all(val, "\u00E1", "a"),
               text = str_replace_all(val, "\u00E2", "a"),
               text = str_replace_all(val, "\u00E3", "a"),
               text = str_replace_all(val, "\u00E4", "a"),
               text = str_replace_all(val, "\u00E5", "a"),
               text = str_replace_all(val, "\u00E9", "e"),
               text = str_replace_all(val, "\u00E8", "e"),
               text = str_replace_all(val, "\u00EA", "e"),
               text = str_replace_all(val, "\u00EB", "e"),
               text = str_replace_all(val, "\u00EC", "i"),
               text = str_replace_all(val, "\u00ED", "i"),
               text = str_replace_all(val, "\u00EE", "i"),
               text = str_replace_all(val, "\u00EF", "i"),
               text = str_replace_all(val, "\u00F2", "o"),
               text = str_replace_all(val, "\u00F3", "o"),
               text = str_replace_all(val, "\u00F4", "o"),
               text = str_replace_all(val, "\u00F5", "o"),
               text = str_replace_all(val, "\u00F6", "o"),
               text = str_replace_all(val, "\u00F9", "u"),
               text = str_replace_all(val, "\u00FA", "u"),
               text = str_replace_all(val, "\u00FB", "u"),
               text = str_replace_all(val, "\u00FC", "u"),
               text = str_replace_all(val, "\u00FF", "y"),
               text = str_replace_all(val, "\u00FD", "y"),
               text = str_replace_all(val, "\u00E7", "c"),
               text = str_replace_all(val, "\u00E6", "ae"),
               text = str_replace_all(val, "\u00F1", "n")) %>%
        mutate(xx = str_extract(text, regex(temp_request, ignore_case = TRUE))) %>%
        count(xx, sort = TRUE)

      df_new$hashtags[i] <- request$xx[1]

      rm(temp_request, request)

      i <- i - 1
    }


  }

  df_new

}

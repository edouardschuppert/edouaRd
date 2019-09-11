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
    mutate(hash = str_remove_all(.data$hash, "\"")) %>%
    mutate(hash = str_remove_all(.data$hash, rex::rex("c(" %or% ")" %or% "[[:punct:]]" %or% ","))) %>%
    unnest_tokens(.data$words, .data$hash) %>%
    filter(is.na(.data$words) == FALSE) %>%
    mutate(words = str_remove_all(.data$words, "[[:space:]]+")) %>%
    count(.data$words) %>%
    arrange(desc(n)) %>%
    mutate(hashtags = paste0("#", .data$words)) %>%
    select(.data$hashtags, n)

  df_new <- df_new %>%
    filter(.data$hashtags != "#n" &
             .data$hashtags != "#0" &
             .data$hashtags != "#u" &
             .data$hashtags != "#character")

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
               text = str_replace_all(text, "\u00E0", "a"),
               text = str_replace_all(text, "\u00E1", "a"),
               text = str_replace_all(text, "\u00E2", "a"),
               text = str_replace_all(text, "\u00E3", "a"),
               text = str_replace_all(text, "\u00E4", "a"),
               text = str_replace_all(text, "\u00E5", "a"),
               text = str_replace_all(text, "\u00E9", "e"),
               text = str_replace_all(text, "\u00E8", "e"),
               text = str_replace_all(text, "\u00EA", "e"),
               text = str_replace_all(text, "\u00EB", "e"),
               text = str_replace_all(text, "\u00EC", "i"),
               text = str_replace_all(text, "\u00ED", "i"),
               text = str_replace_all(text, "\u00EE", "i"),
               text = str_replace_all(text, "\u00EF", "i"),
               text = str_replace_all(text, "\u00F2", "o"),
               text = str_replace_all(text, "\u00F3", "o"),
               text = str_replace_all(text, "\u00F4", "o"),
               text = str_replace_all(text, "\u00F5", "o"),
               text = str_replace_all(text, "\u00F6", "o"),
               text = str_replace_all(text, "\u00F9", "u"),
               text = str_replace_all(text, "\u00FA", "u"),
               text = str_replace_all(text, "\u00FB", "u"),
               text = str_replace_all(text, "\u00FC", "u"),
               text = str_replace_all(text, "\u00FF", "y"),
               text = str_replace_all(text, "\u00FD", "y"),
               text = str_replace_all(text, "\u00E7", "c"),
               text = str_replace_all(text, "\u00E6", "ae"),
               text = str_replace_all(text, "\u00F1", "n")) %>%
        mutate(xx = str_extract(.data$text, regex(temp_request, ignore_case = TRUE))) %>%
        count(.data$xx, sort = TRUE)

      df_new$hashtags[i] <- request$xx[1]

      rm(temp_request, request)

      i <- i - 1
    }


  }

  df_new

}

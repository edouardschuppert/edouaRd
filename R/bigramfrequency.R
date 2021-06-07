#' bigramfrequency
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param slice Allows you to keep only a small number of observations, starting from the first. Default set to NA
#' @importFrom rlang enquo
#' @importFrom dplyr select
#' @importFrom dplyr mutate
#' @importFrom dplyr anti_join
#' @importFrom dplyr count
#' @importFrom dplyr arrange
#' @importFrom tidyr separate
#' @importFrom tidyr unite
#' @importFrom tidytext unnest_tokens
#' @return Return the bigram frequency of the column you chose
#' @export

bigramfrequency <- function(df, colonne, slice = NA) {

  colonne <- enquo(colonne)

  # Loading wordfrequency dictionary
  wf_dictionary <- edouaRd::wf_dictionary

  # Processing
  df <- df %>%
    select(!!colonne) %>%
    mutate(colonne = povertext(!!colonne)) %>%
    unnest_tokens(.data$bigram, colonne, token = "ngrams", n = 2, to_lower = TRUE) %>%
    select(- !!colonne) %>%
    separate(.data$bigram, c("bigram1", "bigram2"), sep = " ") %>%
    anti_join(wf_dictionary, by = c("bigram1" = "words")) %>%
    anti_join(wf_dictionary, by = c("bigram2" = "words")) %>%
    unite(bigram, .data$bigram1, .data$bigram2, sep = " ") %>%
    count(.data$bigram) %>%
    arrange(desc(n))

  # Keep only the desired length
  if (is.na(slice) == FALSE) {

    df <- df %>%
      slice(1:slice)

  }

  df

}

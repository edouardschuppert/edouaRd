#' wordfrenquency
#'
#' @param df Your data frame
#' @param colonne Your column
#' @param slice Allows you to keep only a small number of observations, starting from the first. Default set to NA
#' @importFrom rlang enquo
#' @importFrom dplyr select
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr anti_join
#' @importFrom dplyr count
#' @importFrom dplyr arrange
#' @importFrom dplyr slice
#' @importFrom tidytext unnest_tokens
#' @return Return the word frequency of the column you chose
#' @export

wordfrequency <- function(df, colonne, slice = NA) {

  colonne <- enquo(colonne)

  # Loading wordfrequency dictionary
  wf_dictionary <- edouaRd::wf_dictionary

  # Processing
  df <- df %>%
    select(!!colonne) %>%
    mutate(colonne = povertext(!!colonne)) %>%
    unnest_tokens(.data$words, colonne) %>%
    select(- !!colonne) %>%
    filter(is.na(.data$words) == FALSE) %>%
    anti_join(wf_dictionary, by = "words") %>%
    count(.data$words) %>%
    arrange(desc(n))

  # Keep only the desired length
  if (is.na(slice) == FALSE) {

    df <- df %>%
      slice(1:slice)

  }

  df

}

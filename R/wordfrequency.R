#' wordfrequency
#'
#' @param df Your data frame
#' @param colonne The column you want to make a word frequency on
#' @return Return a text, without any accent or links
#' @export

wordfrequency <- function(df, colonne){

  wf_dictionary <- readr::read_csv2("wf_dictionnaire.csv", col_types = readr::cols(
    words = readr::col_character(),
    lang = readr::col_character()
  ))

  # colonne <- rlang::enquo(colonne)

  wf <- df %>%
    dplyr::select(colonne) %>%
    dplyr::mutate(colonne = povertext(colonne)) %>%
    tidytext::unnest_tokens(words, colonne) %>%
    dplyr::filter(is.na(words) == FALSE) %>%
    dplyr::anti_join(wf_dictionary, by = "words") %>%
    plyr::count(words) %>%
    dplyr::arrange(desc(n))

}

datas <- readr::read_csv("~/Downloads/tcat_CORPORATE_KEOLIS_ET_COMEX-20180501-20180525---------fullExport--09bd3dde68.csv") %>%
  dplyr::mutate(colonne = text) %>%
  wordfrequency()

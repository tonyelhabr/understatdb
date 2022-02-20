
#' @importFrom rvest html_elements html_text
#' @importFrom purrr keep
#' @importFrom stringr str_extract
#' @importFrom stringi stri_unescape_unicode
#' @importFrom jsonlite fromJSON
#' @source <https://gist.github.com/Torvaney/42cd82addb3ba2c4f33ec3247e66889c>
extract_json <- function(html, varname) {
  html %>%
    rvest::html_elements('script') %>%
    rvest::html_text(trim = TRUE) %>%
    purrr::keep(stringr::str_detect, varname) %>%
    stringr::str_extract("(?<=JSON.parse\\(').*(?='\\))") %>%
    stringi::stri_unescape_unicode() %>%
    jsonlite::fromJSON()
}

#' @importFrom tibble tibble as_tibble
#' @importFrom stringr str_c
#' @importFrom rlang :=
unnest_df <- function(df, name) {
  if (!is.data.frame(df)) {
    return(tibble::tibble(!!name := df))
  }
  tbl <- tibble::as_tibble(df)
  colnames(tbl) <- stringr::str_c(name, '_', colnames(tbl))
  tbl
}

#' @importFrom rvest read_html
#' @importFrom purrr imap_dfc
#' @importFrom dplyr rename
#' @importFrom readr type_convert
#' @importFrom rlang .data
fetch_matches <- function(league = 'EPL', season = 2021) {
  sprintf('https://understat.com/league/%s/%s', league, season) %>%
    rvest::read_html() %>%
    extract_json('datesData') %>%
    purrr::imap_dfc(unnest_df) %>%
    dplyr::rename(match_id = .data$id) %>%
    readr::type_convert()
}

#' Get understat matches
#'
#' @param league league
#' @param season season
#' @importFrom purrr map2_dfr
#' @export
get_matches <- function(league, season) {
  purrr::map2_dfr(
    league,
    season,
    fetch_matches
  )
}

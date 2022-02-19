#' Query a database
#'
#' Given a DB connection and an SQL statement, return a tibble with the result of the query.
#'
#' @param conn active DB connection
#' @param statement sql
#' @importFrom DBI dbGetQuery
#' @importFrom tibble tibble
#' @return tibble
#' @export
query_understat_db <- function(conn, statement) {
  tibble::tibble(DBI::dbGetQuery(conn = conn, statement = statement))
}

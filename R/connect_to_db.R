#' Connect to a Postgres Redshift database
#'
#' @family dbconnect
#' @param url a specific URL
#' @importFrom DBI dbConnect
#' @importFrom RPostgres Postgres
#' @importFrom httr parse_url
#' @return connection
#' @export
connect_to_postgres_db <- function(url) {
  db_params <- httr::parse_url(url)

  db_drv <- RPostgres::Redshift()
  db_user <- db_params$username
  db_password <- db_params$password
  db_host <- db_params$hostname
  db_port <- db_params$port
  db_name <- db_params$path

  conn <-
    DBI::dbConnect(
      db_drv,
      dbname = db_name,
      host = db_host,
      port = db_port,
      user = db_user,
      password = db_password
    )
}

#' Connect to the soccer database
#'
#' @family dbconnect
#' @return connection
#' @export
connect_to_understat_db <- function() {
  connect_to_postgres_db(
    url = UNDERSTAT_URL
  )
}

#' Connect to a Postgres Redshift database
#'
#' @family db
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

  DBI::dbConnect(
    db_drv,
    dbname = db_name,
    host = db_host,
    port = db_port,
    user = db_user,
    password = db_password
  )
}

.get_understat_url <- function() {
  url <- tryCatch(
    error = function(cnd) NULL,
    secret::get_secret('x')
  )
  if(!is.null(url)) {
    return(url)
  }
  Sys.getenv('UNDERSTAT_URL')
}

#' Connect to the understat database
#'
#' @importFrom secret get_secret
#' @family db
#' @return connection
#' @export
connect_to_understat_db <- function() {
  connect_to_postgres_db(.get_understat_url())
}

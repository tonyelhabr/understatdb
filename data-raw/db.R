url <- 'postgres://elhabr:123Password@redshift-cluster-1.cvpu8xd9730b.us-east-2.redshift.amazonaws.com:5439/dev'
#A httr::parse_url(url)
conn <- connect_to_db(
  url = url
)
conn <- DBI::dbConnect(
  RPostgres::Redshift(),
  dbname = 'dev',
  host = 'redshift-cluster-1.cvpu8xd9730b.us-east-2.redshift.amazonaws.com',
  port = 5439,
  user = 'elhabr',
  password = '123Password'
)

conn <- DBI::dbConnect(
  RPostgres::Redshift(),
  dbname = 'dev',
  host = 'test-cluster.cvpu8xd9730b.us-east-2.redshift.amazonaws.com',
  port = 5439,
  user = 'elhabr',
  password = 'Ppv9789e!'
)

# conn
# httr::parse_url(
#   'postgres://tony:Ppv9789e!@redshift-cluster-1.cvpu8xd9730b.us-east-2.redshift.amazonaws.com:5439/dev'
# )


library(DBI)
library(dplyr)
library(dbplyr)
library(odbc)
conn <- DBI::dbConnect(odbc::odbc(), "snowflake_test", uid = 'tonyelhabr', pwd = 'Ppv9789e!')
conn
tibble::tibble(DBI::dbGetQuery(conn = conn, statement = 'select * from snowflake_sample_data.tpch_sf10.customer limit 10'))

library(RPostgreSQL)

con <- dbConnect(
  dbDriver('PostgreSQL'),
  dbname = 'dev',
  host = 'redshift-cluster-1.cvpu8xd9730b.us-east-2.redshift.amazonaws.com',
  port = 5432,
  user = 'elhabr',
  password = 'Ppv9789e!'
)
dbDisconnect(con)

#' Creates the product and customer tables
#' @param con Database connection
#' @param product_data Data for the products table
#' @param customer_data Data for the customer table
#' @export
bdc_db_lookups <- function(con,
                           product_data = bdc_data_products(),
                           customer_data = bigdataclass::customers) {
  UseMethod("bdc_db_lookups")
}

#' @export
bdc_db_lookups.connConnection <- function(con,
                                          product_data = bdc_data_products(),
                                          customer_data = bigdataclass::customers) {
  bdc_db_lookups(
    con@con,
    product_data = bdc_data_products(),
    customer_data = bigdataclass::customers
  )
}

#' @export
bdc_db_lookups.default <- function(con,
                                   product_data = bdc_data_products(),
                                   customer_data = bigdataclass::customers) {
  dbWriteTable(con, "product", product_data, overwrite = TRUE)
  dbWriteTable(con, "customer", customer_data, overwrite = TRUE)
}

#' Creates a table with multiple date values
#' @param con Database connection
#' @param start_date Start date
#' @export
bdc_db_create_dates <- function(con, start_date = "2016-01-01") {
  step_max <- tbl(con, "orders") %>%
    summarise(max(step_id, na.rm = TRUE)) %>%
    pull()
  step_id <- seq_len(step_max)
  step_date <- as.Date(start_date) + (step_id - 1)
  tb <- tibble(
    step_id,
    date = as.character(step_date),
    date_year = as.integer(format(step_date, "%Y")),
    date_month = as.integer(format(step_date, "%m")),
    date_month_name = month.abb[as.integer(format(step_date, "%m"))],
    date_day = format(step_date, "%A")
  )
  dbWriteTable(con, "date", tb, overwrite = TRUE)
}

#' Returns a tibble with a product ID and a randomly assigned price
#' @param no_products Number of products to produce
#' @param seed Seed number to use for random data
#' @param price_low Lowest price to assign
#' @param price_high Highest price to assign
#' @export
bdc_data_products <- function(no_products = 30, seed = 7878,
                              price_low = 4, price_high = 10) {
  set.seed(seed)
  ts <- tibble(
    price = round(runif(no_products, price_low, price_high), 2)
  )
  rowid_to_column(ts, "product_id")
}

# Usage: usethis::use_data(create_customers())
create_customers <- function(no_customers = 90,
                             lon_1 = -122.485262, 
                             lon_2 = -122.398601,
                             lat_1 = 37.727631, 
                             lat_2 = 37.788432
                             ) {
  tb <- tibble(
    customer_name = ch_name(no_customers),
    customer_phone = ch_phone_number(no_customers),
    customer_cc = ch_credit_card_number(no_customers),
    customer_lon = random_range(lon_1, lon_2, no_customers),
    customer_lat = random_range(lat_1, lat_2, no_customers)
  )
  rowid_to_column(tb, "customer_id")
}

random_range <- function(from, to, size) {
  fctr <- 1000000
  from <- from * fctr
  to <- to * fctr
  sample(from:to, size) / fctr
}
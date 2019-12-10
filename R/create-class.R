#' Creates a new RStudio project with the exercises and needed data sets
#' @param folder Path to folder where to build the project
#' @param avg_daily_orders Number of average daily orders
#' @param avg_no_items Average number of sales in an order
#' @param days_in_segment Days in a segment
#' @param no_of_segments Number of segments
#' @param seed Seed to randomize to
#' @param product_data Product data frame source
#' @param customer_data Customer data frame source
#' @param start_date The start date for the orders
#' @param no_transactions Number of transactions to save to file
#' @param batch_size File batch size
#' @param no_files Number of files
#' @param overwrite Overwrite class folder if it exists
#' @param include_books Download and save the book data
#' @param src Path to the source folder of the exercises
#' @export
bdc_create_class <- function(folder = "big-data-class",
                                 avg_daily_orders = 100,
                                 avg_no_items = 3,
                                 days_in_segment = 10,
                                 no_of_segments = 100,
                                 seed = 7878,
                                 product_data = bdc_data_products(),
                                 customer_data = bigdataclass::customers,
                                 start_date = "2016-01-01",
                                 no_transactions = 50000,
                                 batch_size = 5000,
                                 no_files = 5,
                                 src = system.file("exercises", package = "bigdataclass"),
                                 overwrite = FALSE,
                                 include_books = FALSE) {
  bdc_build_project(
    folder = folder,
    src = src,
    overwrite = overwrite
  )
  con <- bdc_db_sqlite(file.path(folder, "database"))
  bdc_db_tables(
    con = con,
    avg_daily_orders = avg_daily_orders,
    avg_no_items = avg_no_items,
    days_in_segment = days_in_segment,
    no_of_segments = no_of_segments,
    start_date = start_date,
    seed = seed
  )
  bdc_data_files(
    con = con,
    no_transactions = no_transactions,
    batch_size = batch_size,
    no_files = no_files,
    folder = file.path(folder, "files")
  )
  if(include_books) bdc_data_books(file.path(folder, "books"))
  proj_activate(folder)
}

context("customer-data")

test_that("Customers returns a tibble", {
  expect_is(create_customers(), "tbl_df")  
})

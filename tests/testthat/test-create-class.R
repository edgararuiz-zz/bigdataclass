context("Create class")

test_that("Local class created",{
  tmp_folder <- tempdir()
  expect_output(
    bdc_create_class(
      tmp_folder, 
      no_files = 2, 
      avg_daily_orders = 100,
      overwrite = TRUE
      ), 
    "ℹ Creating product and customer tables"
    )
})

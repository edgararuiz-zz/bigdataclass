context("workbook")

test_that("Internal functions work", {
  expect_silent(workbook_reset(""))
  expect_silent(workbook_clean(""))  
}) 

# test_that("Local workbook created",{
#   tmp_folder <- tempdir()
#   expect_silent(bdc_build_workbook(tmp_folder))
# })

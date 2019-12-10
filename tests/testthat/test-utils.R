context("utils")

test_that("Utils output are as expected", {
  expect_is(bdc_utils_libraries(), "character")
  expect_output(bdc_utils_outline(), "- Introduction ")
})

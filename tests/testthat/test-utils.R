context("utils")

test_that("Utils output are as expected", {
  expect_is(bdc_utils_libraries(pkg_workbook_files()), "character")
  expect_output(bdc_utils_outline(pkg_workbook_files()), "- Introduction ")
})

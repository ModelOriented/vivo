context("Check plot() function")

source("objects_for_tests.R")

test_that("plotMeasure", {
  expect_is(plot(measure), "gg")
})

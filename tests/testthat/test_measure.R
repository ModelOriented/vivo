context("Check LocalVariableImportance() function")

source("objects_for_tests.R")

test_that("data.frame", {
  expect_error(LocalVariableImportance(cp, as.matrix(apartments[, 2:5])))
})

test_that("ceteris_paribus_explainer", {
  expect_error(LocalVariableImportance(explainer_rf, apartments[, 2:5]))
})


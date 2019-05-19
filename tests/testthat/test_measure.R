context("Check LocalVariableImportance() function")

source("objects_for_tests.R")

test_that("local_variable_importance_data.frame", {
  expect_error(LocalVariableImportance(cp, as.matrix(apartments[, 2:5])))
})

test_that("ceteris_paribus_explainer", {
  expect_error(LocalVariableImportance(explainer_rf, apartments[, 2:5]))
})

test_that("calculate_weight_cp", {
  expect_error(CalculateWeight(explainer_rf, apartments[, 2:5], split))
})

test_that("calculate_weight_list", {
  expect_error(CalculateWeight(explainer_rf, apartments[, 2:5], unlist(split)))
})

test_that("calculate_weight_data.frame", {
  expect_error(CalculateWeight(cp, as.matrix(apartments[, 2:5]), split))
})

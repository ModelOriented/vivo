context("Check plot() function")

source("objects_for_tests.R")

test_that("plotMeasure", {
  expect_is(plot(measure), "gg")
})

test_that("plotMeasure2", {
  expect_is(plot(measure, color = NULL), "gg")
})

test_that("plotMeasure3", {
  expect_is(plot(measure, measure_lm2, color = "_label_model_"), 'gg')
})

test_that("plotMeasure4", {
  expect_is(plot(measure, variables = c("floor", "surface")), "gg")
})

test_that("plotMessage5", {
  expect_is(plot(measure, variables = c("floor", "surface"), type = "lines"), "gg")
})

test_that("plotMessage5", {
  expect_is(plot(measure_lm2, measure, color = "_label_model_", type = "bars"), "gg")
})

test_that("plotMessage6", {
  expect_error(plot(measure_lm2, measure, color = "_label_model_", type = "line"))
})

test_that("plotMeasure7", {
  expect_error(plot(measure, variables = c("district", "m2.price")))
})

test_that("plotLabel", {
  expect_error(plot(measure, measure_lm, color = "_label_model_"))
})

test_that("plotLabel2", {
  expect_error(plot(measure, color = "_label_model_"))
})

test_that("plotMessage", {
  expect_message(plot(measure, measure_lm), "Measure will be plotted only for the first observation.")
})

test_that("plotMessage2", {
  expect_message(plot(measure, measure_lm), "Measure will be plotted only for the first observation.")
})

measure_lm3 <- measure_lm2
measure_lm3$`_label_model_` <- " "
measure_2 <- measure
measure_2$`_label_model_` <- " "

test_that("plotMessage3", {
  expect_message(plot(measure_2, measure_lm3, color = "_label_method_"), "Measure will be plotted only for the first observation. Add different labels for each method.")
})

test_that("plotMessage4", {
  expect_message(plot(measure_2, measure_lm3, color = "_label_model_"), "Measure will be plotted only for the first observation. Add different labels for each model.")
})

test_that("plotMessage5", {
  expect_is(plot(measure_2, color = "_label_method_"), 'gg')
})

p_cp <- plot(measure)
test_that("titlePlot", {
  expect_equal(p_cp$labels$title, "Local variable importance")
})

p_cp1 <- plot(measure_lm2, measure, color = "_label_model_", type = "lines")
test_that("titlePlot2", {
  expect_equal(p_cp1$labels$title, "Local variable importance")
})

test_that("subtitlePlot", {
  expect_equal(p_cp$labels$subtitle, "absolute_deviation = TRUE, point = TRUE, density = TRUE")
})

test_that("subtitlePlot2", {
  expect_equal(as.character(p_cp1$labels$subtitle), "absolute_deviation = TRUE, point = TRUE, density = TRUE")
})

test_that("plotGlobalMeasure", {
  expect_is(plot(measure_pdp), 'gg')
})

test_that("plotGlobalMeasure2", {
  expect_is(plot(measure_pdp, type = "lines"), 'gg')
})

test_that("plotGlobalMeasure3", {
  expect_is(plot(measure_pdp, type = "bars"), 'gg')
})

test_that("plotGlobalMeasure4", {
  expect_is(plot(measure_pdp, variables = c("surface", "floor")), 'gg')
})

test_that("plotGlobalMeasure5", {
  expect_is(plot(measure_pdp, measure_pdp_lm, variables = c("surface", "floor")), 'gg')
})

test_that("plotGlobalMeasure6", {
  expect_error(plot(measure_pdp, type = "scatter"))
})

measure_pdp2 <- measure_pdp
measure_pdp2$`_label_model_` <- ""
measure_pdp_lm2 <- measure_pdp_lm
measure_pdp_lm2$`_label_model_` <- ""

test_that("plotGlobalMeasure7", {
  expect_message(plot(measure_pdp2, measure_pdp_lm2), "Measure will be plotted only for the first observation. Add different labels for each model.")
})

test_that("plotGlobalMeasure8", {
  expect_error(plot(measure_pdp, variables = c("district", "m2.price")))
})

test_that("plotGlobalMeasure9", {
  expect_is(plot(measure_pdp, measure_pdp_lm, variables = c("surface", "floor"), type = "lines"), 'gg')
})

p_pdp <- plot(measure_pdp)

test_that("titlePlotGlobal", {
  expect_equal(p_pdp$labels$title, "Variable importance")
})

test_that("labsPlotGlobal", {
  expect_equal(p_pdp$labels$y, "Measure")
})

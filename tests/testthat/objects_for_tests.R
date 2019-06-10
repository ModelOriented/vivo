library("vivo")
library("DALEX")
library("randomForest")
library("ingredients")
library("dplyr")
library("ggplot2")

data(apartments)

apartments_rf_model <- randomForest::randomForest(m2.price ~ construction.year + surface + floor +
                                      no.rooms, data = apartments)

explainer_rf <- explain(apartments_rf_model,
                        data = apartmentsTest[,2:5], y = apartmentsTest$m2.price)

new_apartment <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3)

cp <- ingredients::ceteris_paribus(explainer_rf, new_apartment)

split <- ingredients::calculate_variable_split(apartments[, 2:5], variables = colnames(apartments[, 2:5]))

measure <- local_variable_importance(cp, apartments[,2:5], absolute_deviation = TRUE, point = TRUE, density = TRUE)

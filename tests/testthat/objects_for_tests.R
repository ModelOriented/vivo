library("vivo")
library("DALEX")
library("randomForest")
library("ingredients")
library("ggplot2")

data(apartments)

## rf model

apartments_rf_model <- randomForest::randomForest(m2.price ~ construction.year + surface + floor +
                                      no.rooms, data = apartments)

explainer_rf <- DALEX::explain(apartments_rf_model,
                        data = apartmentsTest[,2:5], y = apartmentsTest$m2.price)

new_apartment <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3)

cp <- ingredients::ceteris_paribus(explainer_rf, new_apartment)

pdp <- ingredients::partial_dependence(explainer_rf)

split <- vivo::calculate_variable_split(apartments[, 2:5], variables = colnames(apartments[, 2:5]))

measure <- local_variable_importance(cp, apartments[,2:5], absolute_deviation = TRUE, point = TRUE, density = TRUE)

measure_pdp <- global_variable_importance(pdp)

## rf model 2

apartments_rf_model_2 <- randomForest::randomForest(m2.price ~ construction.year + surface + floor +
                                                    no.rooms + district, data = apartments)

explainer_rf_2 <- DALEX::explain(apartments_rf_model_2,
                               data = apartmentsTest, y = apartmentsTest$m2.price)

new_apartment_2 <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3, district = factor("Wola", levels = levels(apartments$district)))

cp_2 <- ingredients::ceteris_paribus(explainer_rf_2, new_apartment_2)

pdp <- ingredients::partial_dependence(explainer_rf)

split <- vivo::calculate_variable_split(apartments[, 2:5], variables = colnames(apartments[, 2:5]))

measure_2 <- local_variable_importance(cp_2, apartments[,2:5], absolute_deviation = TRUE, point = TRUE, density = TRUE)


## lm model

apartments_lm_model <- lm(m2.price ~ construction.year + surface + floor +
                                                    no.rooms, data = apartments)

explainer_lm <- DALEX::explain(apartments_lm_model,
                               data = apartmentsTest[,2:5], y = apartmentsTest$m2.price)

new_apartment <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3)

cp_lm <- ingredients::ceteris_paribus(explainer_lm, new_apartment)

pdp_lm <- ingredients::partial_dependence(explainer_lm)

measure_lm <- local_variable_importance(cp_lm, apartments[,2:5], absolute_deviation = FALSE, point = TRUE, density = TRUE)

measure_lm2 <- local_variable_importance(cp_lm, apartments[,2:5], absolute_deviation = TRUE, point = TRUE, density = TRUE)

measure_pdp_lm <- global_variable_importance(pdp_lm)

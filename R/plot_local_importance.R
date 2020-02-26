#' Plot Local Variable Importance measure
#'
#' Function plot.local_importance plots local importance measure based on Ceteris Paribus profiles.
#'
#' @param x object returned from \code{local_variable_importance()} function
#' @param ... other parameters
#' @param title the plot's title, by default \code{'Local variable importance'}
#' @return a ggplot2 object
#'
#' @examples
#'
#' library("DALEX")
#' data(apartments)
#'
#' library("randomForest")
#' apartments_rf_model <- randomForest(m2.price ~ construction.year + surface +
#'                                     floor + no.rooms, data = apartments)
#'
#' explainer_rf <- explain(apartments_rf_model, data = apartmentsTest[,2:5],
#'                         y = apartmentsTest$m2.price)
#'
#' new_apartment <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3)
#'
#' library("ingredients")
#' profiles <- ceteris_paribus(explainer_rf, new_apartment)
#'
#' library("vivo")
#' measure <- local_variable_importance(profiles, apartments[,2:5],
#'                           absolute_deviation = TRUE, point = TRUE, density = FALSE)
#'
#' plot(measure)
#'
#'
#' @import ggplot2
#' @import DALEX
#' @export
#'

plot.local_importance <- function(x, ..., title = "Local variable importance"){
  df <- as.data.frame(x)
  obs <- attr(x, "observation")
  df$variable_measure <- paste0(df$variable_name, " = ", obs[1:nrow(df)])
  ggplot(df, aes(x = factor(df$variable_measure , levels = df$variable_measure[order(df$measure)]), y = df$measure)) +
    geom_bar(stat = "identity", width = 0.5, fill = colors_discrete_drwhy(1)) +
    coord_flip() +
    labs(x = "", y = "Measure", title = title, subtitle = paste0("For ", obs$`_label_`, ", ID: ", obs$`_ids_`)) +
    theme_drwhy_vertical() +
    theme(legend.position = "none")
}

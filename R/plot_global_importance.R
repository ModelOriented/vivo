#' Plot Global Variable Importance measure
#'
#' Function plot.global_importance plots global importance measure based on Partial Dependence profiles.
#'
#' @param x object returned from \code{global_variable_importance()} function
#' @param ... other parameters
#' @param title the plot's title, by default \code{'Variable importance'}
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
#' library("ingredients")
#' profiles <- partial_dependence(explainer_rf, new_apartment)
#'
#' library("vivo")
#' measure <- global_variable_importance(profiles)
#'
#' plot(measure)
#'
#'
#' @import ggplot2
#' @import DALEX
#' @export
#'



plot.global_importance <- function(x, ..., title = "Variable importance"){
  df <- as.data.frame(x)
  df$variable_name <- factor(df$variable_name , levels = df$variable_name[order(df$measure)])
  ggplot(df, aes(x = variable_name, y = measure)) +
    geom_bar(stat = "identity", width = 0.5, fill = colors_discrete_drwhy(1)) +
    coord_flip() +
    labs(x = "", y = "Measure", title = title) +
    theme_drwhy_vertical() +
    theme(legend.position = "none")
}

#' Plot Global Variable Importance measure
#'
#' Function plot.global_importance plots global importance measure based on Partial Dependence profiles.
#'
#' @param x object returned from \code{global_variable_importance()} function
#' @param ... other object returned from \code{global_variable_importance()} function that shall be plotted together
#' @param variable if not \code{NULL} then only \code{variables} will be presented
#' @param type a character. How variables shall be plotted? Either "bars" (default) or "lines".
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
#' profiles <- model_profile(explainer_rf)
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



plot.global_importance <- function(x,
                                   ...,
                                   variables = NULL,
                                   type = NULL,
                                   title = "Variable importance"){

  dfl <- c(list(x), list(...))
  measure_df <- do.call(rbind, dfl)
  measure_df$variable_name <- factor(measure_df$variable_name, levels = measure_df$variable_name[order(measure_df$measure[1:(nrow(measure_df)/length(dfl))])])

  if(length(dfl) > 1 & (length(unique(measure_df$`_label_model_`)) != length(dfl))){
    message("Measure will be plotted only for the first observation. Add different labels for each model.")
    measure_df <- measure_df[1:nrow(dfl[[1]]),]
  }

  class(measure_df) <- "data.frame"

  variables_all <- unique(measure_df$variable_name)
  if (!is.null(variables)){
    variables_all <- intersect(variables_all, variables)
    if (length(variables_all) == 0) stop ("Invalid variables.")
    measure_df <- measure_df[measure_df$variable_name %in% variables_all, ]
  }

  if(is.null(type)){
    type_ind <- 1
  }else{
    if(type == "bars"){
      type_ind <- 1
    }
    else{
      type_ind <- 0
      if(type != "lines")
        stop('Unknown plot type, please use "bars" or "lines"')
    }
  }

  if(type_ind == 1){
    chart <-  ggplot(measure_df, aes(x = variable_name, y = measure, fill = `_label_model_`)) +
      geom_bar(stat = "identity", position = "dodge") +
      scale_fill_manual(values = colors_discrete_drwhy(length(unique(measure_df$`_label_model_`))), guide = guide_legend(reverse = TRUE)) +
      theme_drwhy() +
      coord_flip()
    if(length(unique(measure_df$`_label_model_`)) == 1){
      chart <- chart +
        labs(x = " ", y = "Measure", title = title) +
        theme(legend.position = "none")
    }else{
      chart <- chart +
        labs(x = " ", y = "Measure", fill = "model", title = title) +
        theme(legend.direction = 'vertical')
    }
  }else{
    chart <-  ggplot(measure_df, aes(x = variable_name, y = measure, color = `_label_model_`, group = `_label_model_`)) +
      geom_line(size = 1) +
      geom_point(size = 2) +
      scale_color_manual(values = colors_discrete_drwhy(length(unique(measure_df$`_label_model_`))), guide = guide_legend(reverse = TRUE)) +
      theme_drwhy() +
      coord_flip()
    if(length(unique(measure_df$`_label_model_`)) == 1){
      chart <- chart +
        labs(x = " ", y = "Measure", title = title) +
        theme(legend.position = "none")
    }else{
      chart <- chart +
        labs(x = " ", y = "Measure", color = "model", title = title) +
        theme(legend.direction = 'vertical')
    }
  }
  chart
}

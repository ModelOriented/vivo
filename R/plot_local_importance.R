#' Plot Local Variable Importance measure
#'
#' Function plot.local_importance plots local importance measure based on Ceteris Paribus profiles.
#'
#' @param x object returned from \code{local_variable_importance()} function
#' @param ... other object returned from \code{local_variable_importance()} function that shall be plotted together
#' @param color a character. How to aggregated measure? Either  "_label_method_" or "_label_model_".
#' @param variables if not \code{NULL} then only \code{variables} will be presented
#' @param type a character. How variables shall be plotted? Either "bars" (default) or "lines".
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
#' profiles <- predict_profile(explainer_rf, new_apartment)
#'
#' library("vivo")
#' measure1 <- local_variable_importance(profiles, apartments[,2:5],
#'                           absolute_deviation = TRUE, point = TRUE, density = FALSE)
#'
#' plot(measure1)
#'
#' measure2 <- local_variable_importance(profiles, apartments[,2:5],
#'                           absolute_deviation = TRUE, point = TRUE, density = TRUE)
#' plot(measure1, measure2, color = "_label_method_", type = "lines")
#'
#'
#' @import ggplot2
#' @import DALEX
#' @export
#'

plot.local_importance <- function(x,
                                  ...,
                                  variables = NULL,
                                  color = NULL,
                                  type = NULL,
                                  title = "Local variable importance"){

  variable_measure <- measure <- NULL

  obs <- attr(x, "observation")
  dfl <- c(list(x), list(...))
  measure_df <- do.call(rbind, dfl)
  measure_df$variable_measure <- measure_df$variable_measure <- paste0(measure_df$variable_name, " = ", obs[1:(nrow(measure_df)/length(dfl))])
  measure_df$variable_measure <- factor(measure_df$variable_measure, levels = measure_df$variable_measure[order(measure_df$measure[1:(nrow(measure_df)/length(dfl))])])

  # no color
  if(is.null(color)){
    # no color, only the one local measure
    if(length(dfl) == 1){}
    # no color, a few local measure, plot only the first
    if(length(dfl) > 1){
      message("Measure will be plotted only for the first observation.")
      measure_df <- measure_df[1:nrow(dfl[[1]]),]
    }
    }else{ # color
      # label model
      if(color == "_label_model_"){
        # one local measure
        if(length(dfl) == 1){
          color <- NULL
          measure_df <- measure_df[1:nrow(dfl[[1]]),]
        }
        # a few local measure and ones method
        if(length(dfl) > 1 & (length(unique(measure_df$`_label_method_`)) == 1)){

        }else{# a few local measure and a few method
          stop("Observations with different models and different methods.")
        }
        # a few local measure, but not different name model
        if(length(dfl) > 1 & (length(unique(measure_df$`_label_model_`)) != length(dfl))){
          message("Measure will be plotted only for the first observation. Add different labels for each model.")
          measure_df <- measure_df[1:nrow(dfl[[1]]),]
          color <- NULL
        }
      }else{ #label method
        # one local measure
        if(length(dfl) == 1){
          color <- NULL
          measure_df <- measure_df[1:nrow(dfl[[1]]),]
        }
        # a few local measure and a few models
        if(length(dfl) > 1 & (length(unique(measure_df$`_label_method_`)) == 1)){
          message("Measure will be plotted only for the first observation. Add different labels for each method.")
          measure_df <- measure_df[1:nrow(dfl[[1]]),]
          color <- NULL
        }
      }
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

  if (type_ind == 1){
  if (!is.null(color)){
      chart <- ggplot(data = measure_df, aes_string(x = "variable_measure", y = "measure", fill = paste0("`", color, "`"))) +
        geom_bar(stat = "identity", position = "dodge") +
        theme_drwhy() +
        coord_flip() +
        scale_fill_manual(values = colors_discrete_drwhy(length(unique(measure_df[, c(color)]))), guide = guide_legend(reverse = TRUE)) +
        labs(x = " ", fill = strsplit(color, "_")[[1]][[length(strsplit(color, "_")[[1]])]], title = title, subtitle = if(color != "_label_method_"){subtitle = unique(measure_df$`_label_method_`)}else{" "}) +
        theme(legend.direction = if(color == "_label_method_"){'vertical'}else{'horizontal'})
  }else{
    chart <-  ggplot(measure_df, aes(x = variable_measure, y = measure)) +
      geom_bar(stat = "identity", position = "dodge", fill = colors_discrete_drwhy(1)) +
      theme_drwhy() +
      coord_flip() +
      labs(x = "", y = "Measure", subtitle = as.character(unique(measure_df$`_label_method_`)), title = title) +
      theme(legend.position = "none")
   }
  }else{
    if (!is.null(color)){
      chart <- ggplot(data = measure_df, aes_string(x = "variable_measure", y = "measure", color = paste0("`", color, "`"), group = paste0("`", color, "`"))) +
        geom_line(size = 1) +
        geom_point(size = 2) +
        theme_drwhy() +
        coord_flip() +
        scale_color_manual(values = colors_discrete_drwhy(length(unique(measure_df[, c(color)]))), guide = guide_legend(reverse = TRUE)) +
        labs(x = " ", color = strsplit(color, "_")[[1]][[length(strsplit(color, "_")[[1]])]], title = title, subtitle = if(color != "_label_method_"){subtitle = unique(measure_df$`_label_method_`)}else{" "}) +
        theme(legend.direction = if(color == "_label_method_"){'vertical'}else{'horizontal'})
    }else{
      chart <-  ggplot(measure_df, aes(x = factor(variable_measure), y = measure, group=1)) +
        geom_line(size = 1, color = colors_discrete_drwhy(1)) +
        geom_point(size = 2, color = colors_discrete_drwhy(1)) +
        theme_drwhy() +
        coord_flip() +
        labs(x = "", y = "Measure", subtitle = as.character(unique(measure_df$`_label_method_`)), title = title) +
        theme(legend.position = "none")
    }
  }
  chart
}

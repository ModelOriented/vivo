#' Plot Local Variable Importance measure
#'
#' Function plot.local_importance plots local importance measure based on Ceteris Paribus profiles.
#'
#' @param x object returned from `LocalVariableImportance()` function
#' @param ... other parameters
#' @return a ggplot2 object
#'
#' @examples
#' \dontrun{
#' measure <- LocalVariableImportance(cp, df, absolute_deviation = TRUE, point = TRUE, density = FALSE)
#' plot(measure)
#' }
#'
#' @import ggplot2
#' @import ingredients
#' @export
#'

plot.local_importance <- function(x, ...){
  df <- as.data.frame(x)
  ggplot(df, aes(x = factor(df$variable_name , levels = df$variable_name[order(df$measure)]), y = df$measure)) +
    geom_bar(stat = "identity", width = 0.5, fill = theme_drwhy_colors(1)) +
    coord_flip() +
    xlab("") +
    ylab("measure") +
    ggtitle("") +
    theme_drwhy_vertical() +
    theme(legend.position = "none")
}

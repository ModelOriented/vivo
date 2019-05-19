#' Plot Local Variable Importance measure
#'
#' Function plot.local_importance plots local importance measure based on Ceteris Paribus profiles.
#'
#' @param measure object returned from LocalVariableImportance
#'
#' @return a ggplot2 object
#'
#' @examples
#' \dontrun{
#' measure <- LocalVariableImportance(cp, df, absolute_deviation = TRUE, point = TRUE, density = FALSE)
#' plot(measure)
#' }
#'
#' @import ggplot2
#' @export
#'

plot.local_importance <- function(measure){
  df <- as.data.frame(measure)
  ggplot(df, aes(x = factor(df$variable_name , levels = df$variable_name[order(df$measure)]), y = df$measure)) +
    geom_bar(stat = "identity", width = 0.5, fill = theme_drwhy_colors(1)) +
    coord_flip() +
    xlab("") +
    ylab("measure") +
    ggtitle("") +
    theme_drwhy_vertical() +
    theme(legend.position = "none")
}

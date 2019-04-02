#' Plot Local Variable Importance measure
#'
#' Function plot.local_importance plots local importance measure based on Ceteris Paribus profiles.
#'
#' @param measure object returned from LocalVariableImportanceViaOscillations
#'
#' @return a ggplot2 object
#' @export
#' @examples
#' \dontrun{
#' measure <- LocalVariableImportanceViaOscillations(cp, df, absolute_deviation = TRUE, point = TRUE, density = FALSE, kernel_density = "gaussian", bw_density = "nrd0")
#' plot(measure)
#' }
#'
#'
#'

plot.local_importance <- function(measure){
  df <- as.data.frame(measure)
  ggplot(df, aes(x = factor(df$variable_name , levels = df$variable_name[order(-df$measure)]), ymin = 0, ymax = df$measure)) +
    geom_errorbar() +
    xlab("_x_") +
    ylab("measure") +
    ggtitle("") +
    theme_mi2()
}

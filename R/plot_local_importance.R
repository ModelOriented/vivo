#' Plots Local Variable Importance measure
#'
#' Function plot.local_importance plots local importance measure based on Ceteris Paribus profiles.
#'
#' @param measure object returned from LocalVariableImportanceViaOscillations
#'
#' @examples
#' \dontrun{
#' measure <- LocalVariableImportanceViaOscillations(cp, df, absolute_deviation = TRUE, point = TRUE, density = FALSE, kernel_density = "gaussian", bw_density = "nrd0")
#' plot(measure)
#' }
#'
#' @export
#'

plot.local_importance <- function(measure){
  df <- as.data.frame(measure)
  ggplot2::ggplot(df, aes(x = factor(df$variable_name , levels = df$variable_name[order(-df$measure)]), y = df$measure)) + geom_bar(stat = "identity") +
    xlab("_x_") + ylab("measure") + ggtitle("")
}

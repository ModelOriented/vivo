#' Local Variable Importance measure based on Ceteris Paribus profiles.
#'
#' This function plot local importance measure in eight variants.
#'
#' @param cp data.frame generate by ceterisParibus::ceteris_paribus()
#' @param df data.frame with raw data to model
#'
#' @examples
#' \dontrun{
#' plot(cp, df)
#' }
#'
#' @export
#'

plot <- function(cp, df){
  lvivo <- list()
  p <- 1
  for(i in c(TRUE, FALSE)){
    for(j in c(TRUE, FALSE)){
      for(k in c(TRUE, FALSE)){
        lvivo[[p]] <- list(LocalVariableImportanceViaOscillations(cp, df, absolute_deviation = i, point = j, density = k))
        lvivo[[p]][[1]][length(lvivo[[p]][[1]])+1] <- paste0("abs_dev=", i, "point=", j, "density=", k)
        p <- p + 1
      }
    }
  }
  t <- data.frame(1,1,1)
  names(t) <- c("y", "x", "text")
  for(i in 1:length(lvivo)){
    for(j in 1:length(unique(cp$`_vname_`))){
      wiersz <- c(lvivo[[i]][[1]][j], as.character(unique(cp$`_vname_`)[j]), lvivo[[i]][[1]][length(lvivo[[1]][[1]])])
      t <- rbind(t, wiersz)
    }
  }
  t <- t[-1, ]
  t$y <- as.numeric(as.character(t$y))
  p1 <- ggplot(t[1:(4*length(unique(cp$`_vname_`))), ], aes(x = x, y = y)) + geom_bar(stat = "identity") + facet_wrap(~text)
  p2 <- ggplot(t[-c(1:(4*length(unique(cp$`_vname_`)))),], aes(x = x, y = y)) + geom_bar(stat = "identity") + facet_wrap(~text)
  grid.arrange(p1, p2)
}

#' Local Variable Importance measure based on Ceteris Paribus profiles.
#'
#' This function calculate local importance measure in eight variants.
#'
#' @param cp data.frame generate by ceterisParibus::ceteris_paribus()
#' @param df data.frame with raw data to model
#' @param absolute_deviation logical parameter, if `absolute_deviation = TRUE` then measue is calculated as absolute deviation, else is calculated as a root from average squares
#' @param point logical parameter, if `point = TRUE` then measure is calculated as a distance from f(x), else measure is calculated as a distance from average CP
#' @param density logical parameter, if `density = TRUE` then measure is weighted based on the density of variable, else is not weighted
#'
#' @examples
#' \dontrun{
#'
#' LocalVariableImportanceViaOscillations(cp, absolute_deviation = TRUE, point = TRUE, density = FALSE)
#'
#' LocalVariableImportanceViaOscillations(cp, absolute_deviation = TRUE, point = FALSE, density = FALSE)
#' }
#'
#' @export
#'


LocalVariableImportanceViaOscillations <- function(cp, df, absolute_deviation = TRUE, point = TRUE, density = FALSE){
  avg_yhat <- lapply(unique(cp$`_vname_`), function(x){
    mean(cp$`_yhat_`[cp$`_vname_` == x])
  })
  names(avg_yhat) <- unique(cp$`_vname_`)
  variableDensity <- apply(df[, unique(cp$`_vname_`)], 2, function(x){
    dx <- density(x)
  })
  weight <- lapply(unique(cp$`_vname_`), function(x) {approx(variableDensity[[as.character(x)]][["x"]],
                                                             variableDensity[[as.character(x)]][["y"]],
                                                             xout = cp[cp$`_vname_` == x, as.character(x)])})
  names(weight) <- unique(cp$`_vname_`)
  obs <- attr(cp, "observations")

  if(absolute_deviation == TRUE){
    if(point == TRUE){
      if(density == TRUE){
        ## a=T, p=T, d=T
        return(unlist(lapply(unique(cp$`_vname_`), function(m){
          sum(abs(weight[[m]][["y"]] * cp[cp$`_vname_` == m, "_yhat_"] - unlist(unname(obs["_yhat_"]))))
        })))
      }else{
        ## a=T, p=T, d=F
        return(unlist(lapply(unique(cp$`_vname_`), function(w){
          sum(abs((cp[cp$`_vname_` == w, "_yhat_"] - unlist(unname(obs["_yhat_"])))))
        })))
      }
    }else{
      if(density == TRUE){
        ## a=T, p=F, d=T
        return(unlist(lapply(unique(cp$`_vname_`), function(m){
          sum(abs(weight[[m]][["y"]] * cp[cp$`_vname_` == m, "_yhat_"] - avg_yhat[[m]]))
        })))
      }else{
        ## a=T, p=F, d=F
        return(unlist(lapply(unique(cp$`_vname_`), function(w){
          sum(abs((cp[cp$`_vname_` == w, "_yhat_"] - avg_yhat[[w]])))
        })))
      }
    }
  }else{
    if(point == TRUE){
      if(density == TRUE){
        ## a=F, p=T, d=T
        return(unlist(lapply(unique(cp$`_vname_`), function(m){
          sqrt(sum((weight[[m]][["y"]] * cp[cp$`_vname_` == m, "_yhat_"] - unlist(unname(obs["_yhat_"])))^2)/length(cp[cp$`_vname_` == m, "_yhat_"]))
        })))
      }else{
        ## a=F, p=T, d=F
        return( unlist(lapply(unique(cp$`_vname_`), function(w){
          sqrt(sum((cp[cp$`_vname_` == w, "_yhat_"] - unlist(unname(obs["_yhat_"])))^2)/length(cp[cp$`_vname_` == w, "_yhat_"]))
        })))
      }
    }else{
      if(density == TRUE){
        ## a=F, p=F, d=T
        return( unlist(lapply(unique(cp$`_vname_`), function(m){
          sqrt(sum((weight[[m]][["y"]] * cp[cp$`_vname_` == m, "_yhat_"] - avg_yhat[[m]])^2)/length(cp[cp$`_vname_` == m, "_yhat_"]))
        })))
      }else{
        ## a=F, p=F, d=F
        return( unlist(lapply(unique(cp$`_vname_`), function(w){
          sqrt(sum((cp[cp$`_vname_` == w, "_yhat_"] - avg_yhat[[w]])^2)/(length(cp[cp$`_vname_` == w, "_yhat_"])))
        })))
      }
    }
  }

}


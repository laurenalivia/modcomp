
#' function to extract relevant components from a linear model
#'
#' The output will be used downstream to supply model information in a display for comparison against other linear models
#' @title Extract Relevant lm Components
#' @param lm
#' @param alpha user-defined alpha; define the threshold for significance
#' @return list of relevant lm components
extract_lm<- function(lm, alpha) {

  #VERIFY input is not missing a linear model or alpha value, the linear model was fit using 'lm', alpha is numeric
  #and in format n.nn with customized Error msg via tryCatch
  tryCatch(
    expr = {
      stopifnot(!missing(lm), inherits(lm, "lm"), !missing(alpha), is.numeric(alpha), alpha <1, alpha>0)

      #Extract Model Summary
      lm_summary<- summary(lm)

      #Extract Model Values of Interest
      #Beta Coefs
      coefs_tbl<- lm_summary$coefficients
      coefs<- coefs_tbl[,'Estimate']

      #Standard Errors
      coef_stderr<- coefs_tbl[,'Std. Error']

      #t value
      coef_tval<- coefs_tbl[,'t value']

      #p value
      coef_pval<- coefs_tbl[, 'Pr(>|t|)']

      #

      #RETURN-- will want to change from a list later on, potentially?? just keeping it like this for now
      list(coefs= coefs, stderrs=coef_stderr, t_vals=coef_tval, p_vals=coef_pval)
    },

    #Error statement to be displayed if initial verification finds a snag in the input
    error= function(e) {
      print("Check that the input is a linear model, correctly specified, and built using the 'lm()' function")
    }
  )

}

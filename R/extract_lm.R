
## function to extract relevant info for comparison from linear models

extract_lm<- function(lm) {

  #VERIFY input is not missing and is a linear model fit using 'lm', with customized Error msg via tryCatch
  tryCatch(
    expr = {
      stopifnot(!missing(lm), inherits(lm, "lm"))

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

      #RETURN-- will want to change from a list to a vector? column Xx1?, just keeping it like this for now
      list(coefz= coefs, stder=coef_stderr, tv=coef_pval, pv=coef_pval)
    },

    #Error statement to be displayed if initial verification finds a snag in the input
    error= function(e) {
      print("Check that the input is a linear model, correctly specified, and built using the 'lm()' function")
    }
  )

}


#' extract relevant components from a linear model
#'
#' I want the user to be able to define the alpha value, so some resulting values in the general
#' summary(lm) would need to be made dependent on that change from 0.05).  The output will be used
#' downstream to supply model information in a display/table for comparison against other similar/nested models.
#'
#'
#' @title Extract Relevant lm Components
#' @param lm linear model
#' @param alpha user-defined alpha; define the threshold for significance
#' @param output controls whether the extracted components are published, default is that the output is not published, but can be set to 'TRUE' to publish results
#' @return list of relevant lm components, if output= TRUE is supplied by user, otherwise, output is not published
#' @examples
#' #fit linear model
#'  lmod<- lm(gamble ~ sex + status + income + verbal + sex:income, data = teengamb)
#'  extract_lm(lmod, output=TRUE)
#'
#' @export
extract_lm<- function(lm, alpha=0.05, output= FALSE) {

  #VERIFY input is not missing a linear model, the linear model was fit using 'lm', alpha is numeric
  #and is a value between 0 and 1, with customized Error msg via tryCatch
  tryCatch(
    expr = {
      stopifnot(!missing(lm), inherits(lm, "lm"), is.numeric(alpha), alpha <1, alpha>0)

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

      #stars for significance based on alpha (using the same % of alpha for threshold as is used with 0.05)
      stars<- ifelse(coef_pval <= .02*alpha, "***",
                     ifelse(coef_pval <= .2*alpha, "**",
                            ifelse(coef_pval <=alpha, "*",
                                   ifelse(coef_pval <= 2*alpha, ".", ""))))
      #confidence intervals, based on alpha value
      confints<- confint(lm, level= (1-alpha))
      lower_confints<- confints[,1]
      higher_confints<-confints[,2]

      #AIC
      aic_lm<- extractAIC(lm)

      #R-squared
      rsq<- lm_summary$r.squared

      #Adjusted R-squared
      adj.rsq<- lm_summary$adj.r.squared

      #Return List of components Conditionally
      display_output <-list(coefs= coefs, stderrs=coef_stderr, t_vals=coef_tval, p_vals=coef_pval, stars=stars,
                            lower_confints=lower_confints, higher_confints=higher_confints, rsq=rsq, adj.rsq=adj.rsq,
                            aic= aic_lm)

      #this code chunk below is what makes the ouptut publishing conditional
      if (output) {
        return(display_output)
      } else {
        invisible(NULL) #means no output published
      }
    },

    #Error statement to be displayed if initial verification finds a snag in the input
    error= function(e) {
      print("Check that the input is a linear model, correctly specified, and built using the 'lm()' function")
    }
  )

}


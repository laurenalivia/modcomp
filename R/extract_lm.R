
#' extract relevant summary components from a linear model
#'
#'
#' The user is able to extract model details while also allowing for a user-defined alpha value of significance. This offers a more flexible model summary output
#' than the summary() function, where the alpha value is strictly set to 0.05. The output can be used to generate a more flexible model summary dataframe if used directly,
#' or this function will also be called as an internal function to both 'tablestack' and 'tablecomp', as it allows for more flexibility with the alpha value.
#'
#'
#' @title Extract Relevant lm Components
#' @param lm linear model
#' @param alpha user-defined alpha; define the threshold for significance. Default is 0.05.
#' @param output controls whether the extracted components are published in the console, default is 'TRUE'.
#' @return dataframe of relevant lm components
#' @examples
#' #fit linear model
#'  data(faraway_teengamb)
#'  lmod<- lm(gamble ~ sex + status + income + verbal + sex:income, data = faraway_teengamb)
#' #extract components, supplying 'output=TRUE' to print output
#'  extract_lm(lmod)
#'
#' @export
extract_lm<- function(lm, alpha=0.05, output= TRUE) {

  #VERIFY input is not missing a linear model, the linear model was fit using 'lm', alpha is numeric
  #and is a value between 0 and 1, with customized Error msg via tryCatch
  tryCatch(
    expr = {
      stopifnot(!missing(lm), inherits(lm, what= "lm"), is.numeric(alpha), alpha <1, alpha>0)

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
      aic_lm<- aic_lm[2:2] #the extracted aic includes 2 values, #parameters and AIC value. This extracts JUST the AIC! Otherwise causes issues in the output with it sometimes displaying AIC, and others the #parameters in the df

      #R-squared
      rsq<- lm_summary$r.squared

      #Adjusted R-squared
      adj.rsq<- lm_summary$adj.r.squared

      #Return List of components Conditionally
      display_output <-list(coefs= coefs, stderrs=coef_stderr, t_vals=coef_tval, p_vals=coef_pval, stars=stars,
                            lower_confints=lower_confints, higher_confints=higher_confints, rsq=rsq, adj.rsq=adj.rsq,
                            aic= aic_lm, alpha=alpha)

       #Return dataframe of the components, List isn't working well is downstram 'comptable' function
      display_output<- as.data.frame(display_output)

      #this code chunk below is what makes the ouptut publishing conditional
      if (output) {
        return(display_output)
      } else {
        invisible(display_output) #means no output published
      }
    },

    #Error statement to be displayed if initial verification finds a snag in the input
    error= function(e) {
      print("Check that the input is a linear model, correctly specified, and built using the 'lm()' function")
    }
  )

}


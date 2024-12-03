#want to put the extracted model components in a table for side-by-side comparison with each model it's own column, predictors on the right, and something where you
  #user chooses the values placed in each cell, like: [coef estimate] concatenated with the pvalue and stars? With the option to instead have the output value be confintervals, etc?
  #return(extract)
#' function to generate a table for easy comparison against similar or nested models.
#'
#'
#' @title Generate Model Comparison Table
#' @param model_extract model(s) to display components for. can be just one, or as many as desired for side-by-side comparison of values
#' @param modeltype 'lm' for linear model, 'coxph' for cox proportional hazards model.
#' @param alpha_ user-defined alpha; define the threshold for significance. Default is 0.05.
#' @return table of relevant model components for a quick side-by-side comparison between models
#'
#'

tablecomp<- function (..., alpha_= 0.05, modeltype= c("lm", "coxph")) {

  #Validate that modeltype specified is either 'lm' or 'coxph' using 'match.arg()' function
  modeltype<- match.arg(modeltype)

  #group the multiple model inputs from '...' so they can be iterated over for functions later
  inputmods<- list(...)

  #figured out the 'if-stop' usage for a piece, rather than a tryCatch or stopifnot:
  #make sure they are all the same type, and that type matches what was specified for 'modeltype' in the input
  if(!all(sapply(inputmods, inherits, what= modeltype))) {
    stop("All models supplied must be of type specified:", modeltype)
  }
  #if they are all the same, this will be printed to the output, "\n" forces new line after this message for remaining output
  cat("All models are of type specified:", modeltype, "\n")

  #apply the extract_ function for each model in the grouped list, pass alpha_ from tablestack to alpha from extract_lm, this works finally!
  extracts<- lapply(inputmods, extract_lm, alpha= alpha_)

  #want to parse out the unique rownames among the model extracts, as these are the parameters we want to compare across models and will make up the right-most column of table output
  all_unique_predictors<- unique(unlist(lapply(extracts, rownames)))

  #start table build with rownames as the right-most column. data will be added model by model...thinking that will be the easiest way to generate it?
  outputtable<- data.frame(row.names = all_unique_predictors)
  return(outputtable) #returns 'data frame with 0 columns and 8 rows' in console, think it works to this point



}


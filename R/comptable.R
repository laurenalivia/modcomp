
#' function to generate a table for easy comparison against similar or nested models.
#'
#'
#' @title Generate Model Comparison Table
#' @param model_extract model(s) to display components for. can be just one, or as many as desired for side-by-side comparison of values
#' @param alpha user-defined alpha; define the threshold for significance (brought over from previous models? is ther)
#' @param modeltype 'lm' for linear model, 'coxph' for cox proportional hazards model.
#' @return table of relevant model components for a quick side-by-side comparison
#'
#'

comptable<- function (..., alpha= 0.05, modeltype= c("lm", "coxph")) {

  #Validate that modeltype specified is either 'lm' or 'coxph'
  modeltype<- match.arg(modeltype)

  #group the multiple model inputs from '...'
  inputmods<- list(...)

  #figured out the 'if-stop' usage for a piece, rather than a tryCatch or stopifnot, trying here:
  #make sure they are all the same type, and that type matches what was specified for 'modeltype'
  if(!all(sapply(inputmods, inherits, what= modeltype))) {
    stop("All models supplied must be of type specified:", modeltype)
  }
  #if they are all the same, this will be printed to the output, "\n" forces new line after this message for remaining ouput
  cat("All models are of type specified:", modeltype, "\n")

  #apply the extract_ function for each model in the grouped list
  extracts<- lapply(inputmods, extract_lm)

  #return results
  return(extracts)

}

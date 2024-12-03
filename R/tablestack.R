
#' function to generate a stack of model output tables for quick comparison.
#'
#'
#' @title stack model information tables for comparison
#' @param model_extract model(s) to display components for. can be just one, or as many as desired for a comparison of values
#' @param modeltype 'lm' for linear model, 'coxph' for cox proportional hazards model.
#' @param set_alpha user-defined alpha; define the threshold for significance
#' @return table(s) of relevant model components for a quick side-by-side comparison
#'
#'

tablestack<- function (..., alpha= 0.05, modeltype= c("lm", "coxph")) {

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

  #apply the extract_ function for each model in the grouped list, pass alpha from tablestack to alpha from extract_lm, somehow this works finally!
  extracts<- lapply(inputmods, extract_lm, alpha= alpha)

  #output is the model summaries stacked right on top of each other, so the user doesnt have to scroll as much, and has everything displayed at once
  return(kable(extracts))

}

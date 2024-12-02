
#' function to generate a table for easy comparison against similar or nested models.
#'
#'
#' @title Generate Model Comparison Table
#' @param model_extract model(s) to display components for. can be just one, or as many as desired for side-by-side comparison of values
#' @param alpha user-defined alpha; define the threshold for significance (brought over from previous models? is ther)
#' @return table of relevant model components for a quick side-by-side comparison
#'
#'

comptable<- function (..., alpha= 0.05 ) {

   #group inputs from '...'
  inputmods<- list(...)

  #apply the extract_ function for each model
  extracts<- lapply(inputmods, extract_lm)

  #return results
  return(extracts)

}

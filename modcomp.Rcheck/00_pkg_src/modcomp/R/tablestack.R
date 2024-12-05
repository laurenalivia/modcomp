
#' stack model information tables on top of each other to allow for a quick comparison between values.
#'
#'function to generate the output of multiple models (of the same class) stacked on top of each other to make comparison of values easier. Or, only one model can be specified and the output
#'will still list the details for the singular model in an efficient way. This makes one large improvement over 'summary(lm)', as the user can define an alpha value beyond just a set 0.05.
#'
#' @title Generate a stack of model output tables for quick comparison.
#' @param ... model(s) to display components for. can be just one, or as many as desired for a comparison of values
#' @param modeltype 'lm' for linear model, 'coxph' for cox proportional hazards model.
#' @param alpha_ user-defined alpha; define the threshold for significance. Default is 0.05.
#' @return table(s) of relevant model components for a quick comparison. They are displayed in the order they are entered as input, with the top being the first model specified, and so on.
#' @examples
#' #fit linear models
#' data(faraway_teengamb)
#' lmod1<- lm(gamble ~ sex + status + income + verbal + sex:status + sex:income + sex:verbal, data = faraway_teengamb)
#' lmod2<- lm(gamble ~ sex + status + income + verbal + sex:income, data = faraway_teengamb)
#' #use 'tablestack()' to compare outputs displayed; can choose a user-defined alpha
#' #if default 0.05 is not the desired level.
#'  tablestack(lmod1, lmod2, alpha_= 0.1)
#'
#' @export

tablestack <- function(..., alpha_ = 0.05, modeltype = c("lm", "coxph")) {

    # Validate that modeltype specified is either 'lm' or 'coxph' using 'match.arg()' function
    modeltype <- match.arg(modeltype)

    # group the multiple model inputs from '...' so they can be iterated over for functions later
    inputmods <- list(...)

    # figured out the 'if-stop' usage for a piece, rather than a tryCatch or stopifnot: make sure they are all the same type, and that type matches what was specified
    # for 'modeltype' in the input
    if (!all(sapply(inputmods, inherits, what = modeltype))) {
        stop("All models supplied must be of type specified:", modeltype)
    }
    # if they are all the same, this will be printed to the output, '\n' forces new line after this message for remaining output
    cat("All models are of type specified:", modeltype, "\n")

    # apply the extract_ function for each model in the grouped list, pass alpha_ from tablestack to alpha from extract_lm, this works finally!
    extracts <- lapply(inputmods, extract_lm, alpha = alpha_)

    # output is the model summaries stacked right on top of each other, so the user doesnt have to scroll as much, and has everything displayed at once
    return(kable(extracts))

}

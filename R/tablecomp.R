

#' Generate a single table for easy comparison between desired models, where each model occupies its own column/ set of columns.
#'
#'User can define which model components are of interest for a quick comparison, for example, model coefficient estimats ('coefs') and associated p values ('p_vals'). All components extracted
#'using 'extract_lm()' are available for comparison in this method. One quirk here is that models are displayed left to right in the order they are supplied in the funtion. A later version would fix the
#'lack of model labels, but for now this is the method to identify the models being compared--by order. It is also advised to supply the largest model first (especially if comparing nested models), as it will
#'ensure all predictor names will be displayed successfully. A later version would fix this quirk as well.
#'
#' @title Generate Model Comparison Table
#' @param model_extract model(s) to display components for. can be just one, or as many as desired for side-by-side comparison of values
#' @param modeltype 'lm' for linear model, 'coxph' for cox proportional hazards model.
#' @param alpha_ user-defined alpha; define the threshold for significance. Default is 0.05.
#' @param comparison_value model components to be compared in the output table. Can specify one, multiple, or all.
#' @return table of relevant model components for a quick side-by-side comparison between models
#' @examples
#' #supply linear model(s) for output comparison
#'  data(faraway_teengamb)
#'  lmod1<- lm(gamble ~ sex + status + income + verbal + sex:status + sex:income + sex:verbal, data = faraway_teengamb)
#'  lmod2<- lm(gamble ~ sex + status + income + verbal + sex:income, data = faraway_teengamb)
#'  lmod3<- lm(gamble ~ sex + status + income + verbal, data = faraway_teengamb)
#' #determine what comparison_value(s) are important for the table, or user can do one comparison value per table to make viewing
#' #even easier. Then create desired table(s) using 'comptable()'.
#' tablecomp(lmod1)
#' tablecomp(lmod1, lmod2, comparison_value= 'coefs')
#' tablecomp(lmod1, lmod2, lmod3, comparison_value= c('coefs', 'p_vals', 'stars'))
#'
#' @export

tablecomp <- function(..., alpha_ = 0.05, modeltype = c("lm", "coxph"), comparison_value = c("coefs", "stderrs", "t_vals", "p_vals", "stars", "lower_confints", "higher_confints",
    "rsq", "adj.rsq", "aic", "alpha")) {

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
    cat("Model Output Displays in the Order Specified in the Input of 'tablecomp(), when choosing to compare more than one model.", "\n")
    cat("Make sure the largest model is displayed first for nested model comparison, to ensure all predictor names are displayed", "\n", "\n")

    # apply the extract_ function for each model in the grouped list, pass alpha_ from tablestack to alpha from extract_lm, this works finally!
    extracts <- lapply(inputmods, extract_lm, alpha = alpha_)

    # want to parse out the unique rownames among the model extracts, as these are the parameters we want to compare across models and will make up the right-most
    # column of table output
    all_unique_predictors <- unique(unlist(lapply(extracts, rownames)))

    # start table/df build with rownames as the right-most column. data will be added model by model...thinking that will be the easiest way to generate it?
    outputtable <- data.frame(row.names = all_unique_predictors)  #returns 'data frame with 0 columns and 8 rows' in console, it works to this point

    # now want to pull information from each model, retrieved by a match between rowname of the model extract and rowname of table being built thinking I could make a
    # function that iterates over the extracts supplied, and adds a column for each

    # iterate over the supplied models, if multiple, and populate a column for each with default data being [coef (pval) (stars)] all concatenated so its one value

    outputtable_columns <- do.call(cbind, lapply(extracts, function(df) {
        df[all_unique_predictors, comparison_value, drop = FALSE]
    }))

    # colnames
    colnames(outputtable_columns) <- rep(comparison_value, length(extracts))

    # return table

    return(kable(outputtable_columns))


}


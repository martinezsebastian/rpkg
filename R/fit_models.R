#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param formula PARAM_DESCRIPTION
#' @param data PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[lme4]{glmer}}
#'  \code{\link[sjPlot]{tab_model}}
#' @rdname fit_models
#' @export 
fit_models <- function(formula, data) {
  # Comment
  tj <- NULL
  fit.glmm <- lme4::glmer(formula, 
                          data = data, 
                          family = "poisson", 
                          offset = log(tj))
  # Another comment
  sjPlot::tab_model(fit.glmm)
  
}

# example of how to use the function
# fit_models(formula = y ~ trt*post + (1|subject), data = df_epil)

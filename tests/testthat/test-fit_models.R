# This describes what the test is trying to do
context("run fit_model with packaged dataset df_epil")

# What is used by this test
data("df_epil")

# fit <- try(fit_models(formula = y ~ trt*post + (1|subject), data = df_epil),
#            silent = TRUE)
fit <- fit_models(formula = y ~ trt*post + (1|subject), data = df_epil)
# str(fit)
# Try!
test_that("no error in fitting fit_models for the epilepsy data", {
  # Testing is about expectations. In this case, I want to test that fit does not return an error
  # I do not expect any of the classes that 'fit' inherits are of the type "try-error"
  # expect_false(inherits(fit, "try-error"))
  expect_true(inherits(fit, what = "glmerMod"))
})
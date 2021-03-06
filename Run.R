# creates description and namespace files
usethis::use_description()
usethis::use_namespace()

# Create R directory
base::dir.create("R")

# creates Package-level documentation so you can run ?nameofpackage
usethis::use_package_doc()

# created README.Rmd for Github landing page
# an .Rbuildignore file gets created
usethis::use_readme_rmd()

# creates license file
usethis::use_mit_license("Sebastian Martinez")

# creates news file
usethis::use_news_md()

# setup continuous integration via travis-ci
usethis::use_travis()

# sets up testing infrastructure
usethis::use_testthat()


usethis::use_data_raw()



# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(magrittr, dplyr, usethis, data.table, here)

# clean data ----
epil <- read.csv(here::here("data-raw","epil.csv"))
DT <- epil %>% as.data.table
DT.base <- DT %>% distinct(subject, .keep_all = TRUE)
DT.base[,`:=`(period=0,y=base)]
DT.epil <- rbind(DT, DT.base)
setkey(DT.epil, subject, period)
DT.epil[,`:=`(post=as.numeric(period>0), tj=ifelse(period==0,8,2))]
df_epil <- as.data.frame(DT.epil) %>% dplyr::select(y, trt, post, subject, tj)

# write data in correct format to data folder ----
usethis::use_data(df_epil, overwrite = TRUE)

usethis::use_vignette(name = "Introduction_to_the_package")

fit.glmm <- lme4::glmer(y ~ trt*post + (1|subject), 
                        data = df_epil, 
                        family = "poisson", 
                        offset = log(tj))
class(fit.glmm)
a <- sjPlot::tab_model(fit.glmm)

b <- expect_true(inherits(a, what = "sjTable"))

lme4::glFormula(formula = y ~ (1 | subject), data = data, family = "poisson", offset = log(tj))
glFormula

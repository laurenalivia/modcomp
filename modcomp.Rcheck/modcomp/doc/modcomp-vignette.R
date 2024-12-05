## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# replace 'path_to_file' with path to the downloaded tar.gz file
  #install.packages(path_to_file, repos= NULL, type= "source")

## -----------------------------------------------------------------------------
# must have package "devtools" installed, and added to library
  #install.packages("devtools")
  #library(devtools)
  
# install 'modcomp' from github using the following code
  #install_github("laurenalivia/modcomp")
  

## -----------------------------------------------------------------------------
library(modcomp)

## -----------------------------------------------------------------------------
# view supporting documentation with information regarding what can be supplied as input:
?extract_lm

# fit linear model
 data(faraway_teengamb)
 lmod<-lm(gamble~sex+status+income+verbal+sex:income, data=faraway_teengamb)
 
# extract summary components (default alpha value is set to 0.05)
 extract_lm(lmod)
 
# example using a different alpha value, if that is desired
 extract_lm(lmod, alpha = 0.1)

## -----------------------------------------------------------------------------
# view supporting documentation with information regarding what can be supplied as input:
  ?tablestack

# fit linear models
  lmod1<-lm(gamble~sex+status+income+verbal+sex:status+sex:income+sex:verbal,data=faraway_teengamb)
  lmod2<-lm(gamble~sex+status+income+verbal+sex:income, data = faraway_teengamb)

# use 'tablestack()' to compare outputs displayed this more closely resembles what will output in your console:
  print(tablestack(lmod1, lmod2, alpha_= 0.1))
 
# or this is just using it straight, which works great but can be forced side-by-side upon knitting in rmarkdown. This can be fixed in a future version.
  tablestack(lmod1, lmod2, alpha_ = 0.1)

## -----------------------------------------------------------------------------
# view supporting documentation with information regarding what can be supplied as input:
  ?tablecomp

# supply linear model(s) for output comparison
  lmod1<-lm(gamble~sex+status+income+verbal+sex:status+sex:income+sex:verbal,data=faraway_teengamb)
  lmod2<-lm(gamble~sex+status+income+verbal+sex:income, data = faraway_teengamb)
  lmod3<-lm(gamble~sex+status+income+verbal, data = faraway_teengamb)
   
# determine what comparison_value(s) are important for the table, or user can do one comparison value
# per table to make viewing #even easier. Then create desired table(s) using 'comptable()'.
  
  tablecomp(lmod1) #all available components for display for one single model. 

## -----------------------------------------------------------------------------
tablecomp(lmod1, lmod2, comparison_value= 'coefs') # only one comparison value to compare lmod1 and lmod2 that vary on the inclusion of some interaction terms.

## -----------------------------------------------------------------------------
tablecomp(lmod1, lmod2, lmod3, comparison_value= c('coefs', 'p_vals', 'stars')) # comparing a few values between 3 models that vary on the inclusion of a few interaction terms.


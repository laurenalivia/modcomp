pkgname <- "modcomp"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('modcomp')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("extract_lm")
### * extract_lm

flush(stderr()); flush(stdout())

### Name: extract_lm
### Title: Extract Relevant lm Components
### Aliases: extract_lm

### ** Examples

#fit linear model
 data(faraway_teengamb)
 lmod<-lm(gamble~sex+status+income+verbal+sex:income, data=faraway_teengamb)
#extract components, supplying 'output=TRUE' to print output
 extract_lm(lmod)




cleanEx()
nameEx("faraway_teengamb")
### * faraway_teengamb

flush(stderr()); flush(stdout())

### Name: faraway_teengamb
### Title: faraway_teengamb
### Aliases: faraway_teengamb

### ** Examples

data(faraway_teengamb)
head(faraway_teengamb)
str(faraway_teengamb)



cleanEx()
nameEx("tablecomp")
### * tablecomp

flush(stderr()); flush(stdout())

### Name: tablecomp
### Title: Generate Model Comparison Table
### Aliases: tablecomp

### ** Examples

#supply linear model(s) for output comparison
 data(faraway_teengamb)
 lmod1<-lm(gamble~sex+status+income+verbal+sex:status+sex:income+sex:verbal,data=faraway_teengamb)
 lmod2<-lm(gamble~sex+status+income+verbal+sex:income, data = faraway_teengamb)
 lmod3<-lm(gamble~sex+status+income+verbal, data = faraway_teengamb)
#determine what comparison_value(s) are important for the table, or user can do one comparison value
#per table to make viewing #even easier. Then create desired table(s) using 'comptable()'.
tablecomp(lmod1)
tablecomp(lmod1, lmod2, comparison_value= 'coefs')
tablecomp(lmod1, lmod2, lmod3, comparison_value= c('coefs', 'p_vals', 'stars'))




cleanEx()
nameEx("tablestack")
### * tablestack

flush(stderr()); flush(stdout())

### Name: tablestack
### Title: Generate a stack of model output tables for quick comparison.
### Aliases: tablestack

### ** Examples

#fit linear models
data(faraway_teengamb)
lmod1<-lm(gamble~sex+status+income+verbal+sex:status+sex:income+sex:verbal,data=faraway_teengamb)
lmod2<-lm(gamble~sex+status+income+verbal+sex:income, data = faraway_teengamb)
#use 'tablestack()' to compare outputs displayed; can choose a user-defined alpha
#if default 0.05 is not the desired level.
 tablestack(lmod1, lmod2, alpha_= 0.1)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')

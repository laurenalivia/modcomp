
## file to test functions on example use cases


## load libraries
library("survival")
library("knitr")
library("faraway")

## practice dataset will be teengamb for SLR model comparisons (using from an example hw problem in biostat methods I)

lmod1<- lm(gamble ~ sex + status + income + verbal + sex:status + sex:income + sex:verbal, data = teengamb)
lmod2<- lm(gamble ~ sex + status + income + verbal + sex:income, data = teengamb)

extract_lm(lmod1, output=TRUE)
summary(lmod1)


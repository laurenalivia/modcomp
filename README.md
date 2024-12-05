## Linear Model Comparison at a Glance: A package to make regression model comparisons even easier!

NOTE: Most up-to-date version of package exists in the 'Development/Testing Branch'!!

The package ‘modcomp’ offers users a more flexible way to review linear
model summary information, providing an advantage over the ‘summary()’
function due to the ability for users to define their alpha value of
significance (the summary() function only offers output relative to a
set 0.05 level of significance, which isn’t always the desired level).
Even more central to this package, however, are the model comparison
functions. This package enables users to view desired model summary
components for multiple linear models (perhaps various nested models),
in either a stacked fashion via ‘tablestack()’ (model summary tables
output directly on top of each other), or in a side-by-side table via
‘tablecomp()’, with user-defined model components as the comparison
value(s). **This package would be of particular interest to users
actively working through a graduate program in biostatistics, as
directly comparing linear model characteristics (e.g, beta coefficient
estimates, significance of those estimates, AIC values) between an
initial model and subsequent nested/similar models after making changes,
is a *very* common task**, and scrolling between numerous summary
outputs crafted solely from the ‘summary()’ function is extremely
tedious and inefficient.

## Installing and Loading ‘modcomp’.

‘modcomp’ can be installed in one of two ways: downloading of the tar.gz
file (‘modcomp\_0.0.0.9000.tar.gz’) containing the package, or download
through github. Code to run is indented and suppressed with a comment
‘\#’.

### Option 1: install directly from the tar.gz file

    # replace 'path_to_file' with path to the downloaded tar.gz file
      #install.packages(path_to_file, repos= NULL, type= "source")

### Option 2: install via github

    # must have package "devtools" installed, and added to library
      #install.packages("devtools")
      #library(devtools)
      
    # install 'modcomp' from github using the following code
      #install_github("laurenalivia/modcomp")
      

## Add ‘modcomp’ to library.

    library(modcomp)
    #> Loading required package: knitr

## Example Usage 1.

### The ‘extract\_lm()’ function.

#### Extract relevant summary components from a linear model as a dataframe.

The extract\_lm() function allows users to extract relevant summary
components from a linear model, with an ability to adjust the alpha
value of significance. The output can be used to generate a more
flexible model summary dataframe if used directly, or this function will
also be called as an internal function to both ‘tablestack()’ and
‘tablecomp()’. The ‘stars’ associated with p value significance are as
follows:  
- p value is less than or equal to 2% of alpha: “\*\*\*”.  
- p value is less than or equal to 20% of alpha: “\*\*”.  
- p value is less than or equal to alpha: “\*".  
- p value is less than or equal to 2alpha:”.”.  
- else: ” ”

    # view supporting documentation with information regarding what can be supplied as input:
    ?extract_lm

    # fit linear model
     data(faraway_teengamb)
     lmod<-lm(gamble~sex+status+income+verbal+sex:income, data=faraway_teengamb)
     
    # extract summary components (default alpha value is set to 0.05)
     extract_lm(lmod)
    #>                   coefs    stderrs     t_vals       p_vals stars lower_confints
    #> (Intercept) 19.25942923 15.7963493  1.2192329 2.297239e-01          -12.6419453
    #> sex          4.06362471 11.5161176  0.3528641 7.259980e-01          -19.1936466
    #> status      -0.04876258  0.2597806 -0.1877068 8.520324e-01           -0.5734002
    #> income       6.19884604  1.0259128  6.0422739 3.767090e-07   ***      4.1269732
    #> verbal      -2.60864357  1.9938604 -1.3083381 1.980461e-01           -6.6353263
    #> sex:income  -6.43682906  2.1433737 -3.0031296 4.538483e-03    **    -10.7654601
    #>             higher_confints      rsq   adj.rsq     aic alpha
    #> (Intercept)      51.1608038 0.612059 0.5647491 290.831  0.05
    #> sex              27.3208960 0.612059 0.5647491 290.831  0.05
    #> status            0.4758751 0.612059 0.5647491 290.831  0.05
    #> income            8.2707189 0.612059 0.5647491 290.831  0.05
    #> verbal            1.4180392 0.612059 0.5647491 290.831  0.05
    #> sex:income       -2.1081980 0.612059 0.5647491 290.831  0.05
     
    # example using a different alpha value, if that is desired
     extract_lm(lmod, alpha = 0.1)
    #>                   coefs    stderrs     t_vals       p_vals stars lower_confints
    #> (Intercept) 19.25942923 15.7963493  1.2192329 2.297239e-01           -7.3238995
    #> sex          4.06362471 11.5161176  0.3528641 7.259980e-01          -15.3165962
    #> status      -0.04876258  0.2597806 -0.1877068 8.520324e-01           -0.4859417
    #> income       6.19884604  1.0259128  6.0422739 3.767090e-07   ***      4.4723600
    #> verbal      -2.60864357  1.9938604 -1.3083381 1.980461e-01     .     -5.9640674
    #> sex:income  -6.43682906  2.1433737 -3.0031296 4.538483e-03    **    -10.0438655
    #>             higher_confints      rsq   adj.rsq     aic alpha
    #> (Intercept)      45.8427580 0.612059 0.5647491 290.831   0.1
    #> sex              23.4438457 0.612059 0.5647491 290.831   0.1
    #> status            0.3884165 0.612059 0.5647491 290.831   0.1
    #> income            7.9253321 0.612059 0.5647491 290.831   0.1
    #> verbal            0.7467802 0.612059 0.5647491 290.831   0.1
    #> sex:income       -2.8297926 0.612059 0.5647491 290.831   0.1

## Example Usage 2.

### The ‘tablestack()’ function.

#### Generate a stack of model output tables for quick comparison.

The tablestack() function allows the user to stack model information
tables on top of each other to allow for a quick and comprehensive
comparison between multiple linear models. This is especially useful in
place of the producing multiple summaries via the ‘summary()’ function,
as that method produces too much white space to scroll through and
doesn’t allow for a direct alignment of the summary outputs to make
comparison efficient. That is where this function, tablestack() comes in
handy! Note: Model summaries are displayed in the order they are entered
as input, with the top being the first model specified, and so on.

    # view supporting documentation with information regarding what can be supplied as input:
      ?tablestack

    # fit linear models
      lmod1<-lm(gamble~sex+status+income+verbal+sex:status+sex:income+sex:verbal,data=faraway_teengamb)
      lmod2<-lm(gamble~sex+status+income+verbal+sex:income, data = faraway_teengamb)

    # use 'tablestack()' to compare outputs displayed this more closely resembles what will output in your console:
      print(tablestack(lmod1, lmod2, alpha_= 0.1))
    #> All models are of type specified: lm 
    #> 
    #> 
    #> <table class="kable_wrapper">
    #> <tbody>
    #>   <tr>
    #>    <td> 
    #> 
    #> |            |       coefs|    stderrs|     t_vals|    p_vals|stars | lower_confints| higher_confints|       rsq|   adj.rsq|      aic| alpha|
    #> |:-----------|-----------:|----------:|----------:|---------:|:-----|--------------:|---------------:|---------:|---------:|--------:|-----:|
    #> |(Intercept) |  27.6354030| 17.6217643|  1.5682540| 0.1249008|.     |     -2.0550693|      57.3258754| 0.6243438| 0.5569184| 293.3186|   0.1|
    #> |sex         | -33.0132447| 35.0529702| -0.9418102| 0.3520875|      |    -92.0731222|      26.0466328| 0.6243438| 0.5569184| 293.3186|   0.1|
    #> |status      |  -0.1455658|  0.3315805| -0.4390059| 0.6630799|      |     -0.7042375|       0.4131059| 0.6243438| 0.5569184| 293.3186|   0.1|
    #> |income      |   6.0290789|  1.0538467|  5.7210206| 0.0000013|***   |      4.2534788|       7.8046791| 0.6243438| 0.5569184| 293.3186|   0.1|
    #> |verbal      |  -2.9747594|  2.4265408| -1.2259260| 0.2275778|      |     -7.0631776|       1.1136589| 0.6243438| 0.5569184| 293.3186|   0.1|
    #> |sex:status  |   0.3528830|  0.5492327|  0.6425018| 0.5243068|      |     -0.5725056|       1.2782716| 0.6243438| 0.5569184| 293.3186|   0.1|
    #> |sex:income  |  -5.3477745|  2.4243570| -2.2058528| 0.0333540|*     |     -9.4325132|      -1.2630358| 0.6243438| 0.5569184| 293.3186|   0.1|
    #> |sex:verbal  |   2.8355168|  4.5973026|  0.6167784| 0.5409650|      |     -4.9103639|      10.5813976| 0.6243438| 0.5569184| 293.3186|   0.1|
    #> 
    #>  </td>
    #>    <td> 
    #> 
    #> |            |      coefs|    stderrs|     t_vals|    p_vals|stars | lower_confints| higher_confints|      rsq|   adj.rsq|     aic| alpha|
    #> |:-----------|----------:|----------:|----------:|---------:|:-----|--------------:|---------------:|--------:|---------:|-------:|-----:|
    #> |(Intercept) | 19.2594292| 15.7963493|  1.2192329| 0.2297239|      |     -7.3238995|      45.8427580| 0.612059| 0.5647491| 290.831|   0.1|
    #> |sex         |  4.0636247| 11.5161176|  0.3528641| 0.7259980|      |    -15.3165962|      23.4438457| 0.612059| 0.5647491| 290.831|   0.1|
    #> |status      | -0.0487626|  0.2597806| -0.1877068| 0.8520324|      |     -0.4859417|       0.3884165| 0.612059| 0.5647491| 290.831|   0.1|
    #> |income      |  6.1988460|  1.0259128|  6.0422739| 0.0000004|***   |      4.4723600|       7.9253321| 0.612059| 0.5647491| 290.831|   0.1|
    #> |verbal      | -2.6086436|  1.9938604| -1.3083381| 0.1980461|.     |     -5.9640674|       0.7467802| 0.612059| 0.5647491| 290.831|   0.1|
    #> |sex:income  | -6.4368291|  2.1433737| -3.0031296| 0.0045385|**    |    -10.0438655|      -2.8297926| 0.612059| 0.5647491| 290.831|   0.1|
    #> 
    #>  </td>
    #>   </tr>
    #> </tbody>
    #> </table>
     
    # or this is just using it straight, which works great but can be forced side-by-side upon knitting in rmarkdown. This can be fixed in a future version.
      tablestack(lmod1, lmod2, alpha_ = 0.1)
    #> All models are of type specified: lm

<table class="kable_wrapper">
<tbody>
<tr>
<td>

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 7%" />
<col style="width: 4%" />
<col style="width: 11%" />
<col style="width: 12%" />
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 4%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: right;">coefs</th>
<th style="text-align: right;">stderrs</th>
<th style="text-align: right;">t_vals</th>
<th style="text-align: right;">p_vals</th>
<th style="text-align: left;">stars</th>
<th style="text-align: right;">lower_confints</th>
<th style="text-align: right;">higher_confints</th>
<th style="text-align: right;">rsq</th>
<th style="text-align: right;">adj.rsq</th>
<th style="text-align: right;">aic</th>
<th style="text-align: right;">alpha</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">(Intercept)</td>
<td style="text-align: right;">27.6354030</td>
<td style="text-align: right;">17.6217643</td>
<td style="text-align: right;">1.5682540</td>
<td style="text-align: right;">0.1249008</td>
<td style="text-align: left;">.</td>
<td style="text-align: right;">-2.0550693</td>
<td style="text-align: right;">57.3258754</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex</td>
<td style="text-align: right;">-33.0132447</td>
<td style="text-align: right;">35.0529702</td>
<td style="text-align: right;">-0.9418102</td>
<td style="text-align: right;">0.3520875</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-92.0731222</td>
<td style="text-align: right;">26.0466328</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">status</td>
<td style="text-align: right;">-0.1455658</td>
<td style="text-align: right;">0.3315805</td>
<td style="text-align: right;">-0.4390059</td>
<td style="text-align: right;">0.6630799</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-0.7042375</td>
<td style="text-align: right;">0.4131059</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">income</td>
<td style="text-align: right;">6.0290789</td>
<td style="text-align: right;">1.0538467</td>
<td style="text-align: right;">5.7210206</td>
<td style="text-align: right;">0.0000013</td>
<td style="text-align: left;">***</td>
<td style="text-align: right;">4.2534788</td>
<td style="text-align: right;">7.8046791</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">verbal</td>
<td style="text-align: right;">-2.9747594</td>
<td style="text-align: right;">2.4265408</td>
<td style="text-align: right;">-1.2259260</td>
<td style="text-align: right;">0.2275778</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-7.0631776</td>
<td style="text-align: right;">1.1136589</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:status</td>
<td style="text-align: right;">0.3528830</td>
<td style="text-align: right;">0.5492327</td>
<td style="text-align: right;">0.6425018</td>
<td style="text-align: right;">0.5243068</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-0.5725056</td>
<td style="text-align: right;">1.2782716</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sex:income</td>
<td style="text-align: right;">-5.3477745</td>
<td style="text-align: right;">2.4243570</td>
<td style="text-align: right;">-2.2058528</td>
<td style="text-align: right;">0.0333540</td>
<td style="text-align: left;">*</td>
<td style="text-align: right;">-9.4325132</td>
<td style="text-align: right;">-1.2630358</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:verbal</td>
<td style="text-align: right;">2.8355168</td>
<td style="text-align: right;">4.5973026</td>
<td style="text-align: right;">0.6167784</td>
<td style="text-align: right;">0.5409650</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-4.9103639</td>
<td style="text-align: right;">10.5813976</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.1</td>
</tr>
</tbody>
</table>

</td>
<td>

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 4%" />
<col style="width: 12%" />
<col style="width: 12%" />
<col style="width: 7%" />
<col style="width: 8%" />
<col style="width: 6%" />
<col style="width: 4%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: right;">coefs</th>
<th style="text-align: right;">stderrs</th>
<th style="text-align: right;">t_vals</th>
<th style="text-align: right;">p_vals</th>
<th style="text-align: left;">stars</th>
<th style="text-align: right;">lower_confints</th>
<th style="text-align: right;">higher_confints</th>
<th style="text-align: right;">rsq</th>
<th style="text-align: right;">adj.rsq</th>
<th style="text-align: right;">aic</th>
<th style="text-align: right;">alpha</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">(Intercept)</td>
<td style="text-align: right;">19.2594292</td>
<td style="text-align: right;">15.7963493</td>
<td style="text-align: right;">1.2192329</td>
<td style="text-align: right;">0.2297239</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-7.3238995</td>
<td style="text-align: right;">45.8427580</td>
<td style="text-align: right;">0.612059</td>
<td style="text-align: right;">0.5647491</td>
<td style="text-align: right;">290.831</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex</td>
<td style="text-align: right;">4.0636247</td>
<td style="text-align: right;">11.5161176</td>
<td style="text-align: right;">0.3528641</td>
<td style="text-align: right;">0.7259980</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-15.3165962</td>
<td style="text-align: right;">23.4438457</td>
<td style="text-align: right;">0.612059</td>
<td style="text-align: right;">0.5647491</td>
<td style="text-align: right;">290.831</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">status</td>
<td style="text-align: right;">-0.0487626</td>
<td style="text-align: right;">0.2597806</td>
<td style="text-align: right;">-0.1877068</td>
<td style="text-align: right;">0.8520324</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-0.4859417</td>
<td style="text-align: right;">0.3884165</td>
<td style="text-align: right;">0.612059</td>
<td style="text-align: right;">0.5647491</td>
<td style="text-align: right;">290.831</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">income</td>
<td style="text-align: right;">6.1988460</td>
<td style="text-align: right;">1.0259128</td>
<td style="text-align: right;">6.0422739</td>
<td style="text-align: right;">0.0000004</td>
<td style="text-align: left;">***</td>
<td style="text-align: right;">4.4723600</td>
<td style="text-align: right;">7.9253321</td>
<td style="text-align: right;">0.612059</td>
<td style="text-align: right;">0.5647491</td>
<td style="text-align: right;">290.831</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="odd">
<td style="text-align: left;">verbal</td>
<td style="text-align: right;">-2.6086436</td>
<td style="text-align: right;">1.9938604</td>
<td style="text-align: right;">-1.3083381</td>
<td style="text-align: right;">0.1980461</td>
<td style="text-align: left;">.</td>
<td style="text-align: right;">-5.9640674</td>
<td style="text-align: right;">0.7467802</td>
<td style="text-align: right;">0.612059</td>
<td style="text-align: right;">0.5647491</td>
<td style="text-align: right;">290.831</td>
<td style="text-align: right;">0.1</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:income</td>
<td style="text-align: right;">-6.4368291</td>
<td style="text-align: right;">2.1433737</td>
<td style="text-align: right;">-3.0031296</td>
<td style="text-align: right;">0.0045385</td>
<td style="text-align: left;">**</td>
<td style="text-align: right;">-10.0438655</td>
<td style="text-align: right;">-2.8297926</td>
<td style="text-align: right;">0.612059</td>
<td style="text-align: right;">0.5647491</td>
<td style="text-align: right;">290.831</td>
<td style="text-align: right;">0.1</td>
</tr>
</tbody>
</table>

</td>
</tr>
</tbody>
</table>

## Example Usage 3.

### The ‘tablecomp()’ function.

#### Generate a table of relevant model components for a quick side-by-side comparison between models.

This function is arguably the *most* useful function in the package, as
it offers the ability to generate a *single* table for the direct
comparison of the user’s desired values between specified linear models.
Linear model predictors are displayed on the left of the table, with
each model occupying its own column/ set of columns. The values
displayed in the table are specified by the user, and can be just one, a
few, or all values. However, for the effectiveness of the comparison and
keeping to the spirit of proving a ‘quick’ comparison that maximizes
viewing efficiency/clarity, fewer values are recommended.

One quirk here is that models are displayed left to right in the order
they are supplied in the funtion. A later version would fix the lack of
model labels, but for now this is the method to identify the models
being compared–by order. It is also advised to supply the largest model
first (especially if comparing nested models), as it will ensure all
predictor names will be displayed successfully. A later version would
fix this quirk as well.

    # view supporting documentation with information regarding what can be supplied as input:
      ?tablecomp

    # supply linear model(s) for output comparison
      lmod1<-lm(gamble~sex+status+income+verbal+sex:status+sex:income+sex:verbal,data=faraway_teengamb)
      lmod2<-lm(gamble~sex+status+income+verbal+sex:income, data = faraway_teengamb)
      lmod3<-lm(gamble~sex+status+income+verbal, data = faraway_teengamb)
       
    # determine what comparison_value(s) are important for the table, or user can do one comparison value
    # per table to make viewing #even easier. Then create desired table(s) using 'comptable()'.
      
      tablecomp(lmod1) #all available components for display for one single model. 
    #> All models are of type specified: lm 
    #> Model Output Displays in the Order Specified in the Input of 'tablecomp(), when choosing to compare more than one model. 
    #> Make sure the largest model is displayed first for nested model comparison, to ensure all predictor names are displayed 
    #> 

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 9%" />
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 7%" />
<col style="width: 4%" />
<col style="width: 11%" />
<col style="width: 12%" />
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 7%" />
<col style="width: 4%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: right;">coefs</th>
<th style="text-align: right;">stderrs</th>
<th style="text-align: right;">t_vals</th>
<th style="text-align: right;">p_vals</th>
<th style="text-align: left;">stars</th>
<th style="text-align: right;">lower_confints</th>
<th style="text-align: right;">higher_confints</th>
<th style="text-align: right;">rsq</th>
<th style="text-align: right;">adj.rsq</th>
<th style="text-align: right;">aic</th>
<th style="text-align: right;">alpha</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">(Intercept)</td>
<td style="text-align: right;">27.6354030</td>
<td style="text-align: right;">17.6217643</td>
<td style="text-align: right;">1.5682540</td>
<td style="text-align: right;">0.1249008</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-8.0079797</td>
<td style="text-align: right;">63.2787857</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.05</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex</td>
<td style="text-align: right;">-33.0132447</td>
<td style="text-align: right;">35.0529702</td>
<td style="text-align: right;">-0.9418102</td>
<td style="text-align: right;">0.3520875</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-103.9145693</td>
<td style="text-align: right;">37.8880800</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.05</td>
</tr>
<tr class="odd">
<td style="text-align: left;">status</td>
<td style="text-align: right;">-0.1455658</td>
<td style="text-align: right;">0.3315805</td>
<td style="text-align: right;">-0.4390059</td>
<td style="text-align: right;">0.6630799</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-0.8162507</td>
<td style="text-align: right;">0.5251191</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.05</td>
</tr>
<tr class="even">
<td style="text-align: left;">income</td>
<td style="text-align: right;">6.0290789</td>
<td style="text-align: right;">1.0538467</td>
<td style="text-align: right;">5.7210206</td>
<td style="text-align: right;">0.0000013</td>
<td style="text-align: left;">***</td>
<td style="text-align: right;">3.8974727</td>
<td style="text-align: right;">8.1606852</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.05</td>
</tr>
<tr class="odd">
<td style="text-align: left;">verbal</td>
<td style="text-align: right;">-2.9747594</td>
<td style="text-align: right;">2.4265408</td>
<td style="text-align: right;">-1.2259260</td>
<td style="text-align: right;">0.2275778</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-7.8829014</td>
<td style="text-align: right;">1.9333827</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.05</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:status</td>
<td style="text-align: right;">0.3528830</td>
<td style="text-align: right;">0.5492327</td>
<td style="text-align: right;">0.6425018</td>
<td style="text-align: right;">0.5243068</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-0.7580451</td>
<td style="text-align: right;">1.4638111</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.05</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sex:income</td>
<td style="text-align: right;">-5.3477745</td>
<td style="text-align: right;">2.4243570</td>
<td style="text-align: right;">-2.2058528</td>
<td style="text-align: right;">0.0333540</td>
<td style="text-align: left;">*</td>
<td style="text-align: right;">-10.2514993</td>
<td style="text-align: right;">-0.4440497</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.05</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:verbal</td>
<td style="text-align: right;">2.8355168</td>
<td style="text-align: right;">4.5973026</td>
<td style="text-align: right;">0.6167784</td>
<td style="text-align: right;">0.5409650</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-6.4634054</td>
<td style="text-align: right;">12.1344390</td>
<td style="text-align: right;">0.6243438</td>
<td style="text-align: right;">0.5569184</td>
<td style="text-align: right;">293.3186</td>
<td style="text-align: right;">0.05</td>
</tr>
</tbody>
</table>

    tablecomp(lmod1, lmod2, comparison_value= 'coefs') # only one comparison value to compare lmod1 and lmod2 that vary on the inclusion of some interaction terms.
    #> All models are of type specified: lm 
    #> Model Output Displays in the Order Specified in the Input of 'tablecomp(), when choosing to compare more than one model. 
    #> Make sure the largest model is displayed first for nested model comparison, to ensure all predictor names are displayed 
    #> 

<table>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: right;">coefs</th>
<th style="text-align: right;">coefs</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">(Intercept)</td>
<td style="text-align: right;">27.6354030</td>
<td style="text-align: right;">19.2594292</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex</td>
<td style="text-align: right;">-33.0132447</td>
<td style="text-align: right;">4.0636247</td>
</tr>
<tr class="odd">
<td style="text-align: left;">status</td>
<td style="text-align: right;">-0.1455658</td>
<td style="text-align: right;">-0.0487626</td>
</tr>
<tr class="even">
<td style="text-align: left;">income</td>
<td style="text-align: right;">6.0290789</td>
<td style="text-align: right;">6.1988460</td>
</tr>
<tr class="odd">
<td style="text-align: left;">verbal</td>
<td style="text-align: right;">-2.9747594</td>
<td style="text-align: right;">-2.6086436</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:status</td>
<td style="text-align: right;">0.3528830</td>
<td style="text-align: right;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sex:income</td>
<td style="text-align: right;">-5.3477745</td>
<td style="text-align: right;">-6.4368291</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:verbal</td>
<td style="text-align: right;">2.8355168</td>
<td style="text-align: right;">NA</td>
</tr>
</tbody>
</table>

    tablecomp(lmod1, lmod2, lmod3, comparison_value= c('coefs', 'p_vals', 'stars')) # comparing a few values between 3 models that vary on the inclusion of a few interaction terms.
    #> All models are of type specified: lm 
    #> Model Output Displays in the Order Specified in the Input of 'tablecomp(), when choosing to compare more than one model. 
    #> Make sure the largest model is displayed first for nested model comparison, to ensure all predictor names are displayed 
    #> 

<table style="width:100%;">
<colgroup>
<col style="width: 12%" />
<col style="width: 12%" />
<col style="width: 10%" />
<col style="width: 6%" />
<col style="width: 11%" />
<col style="width: 10%" />
<col style="width: 6%" />
<col style="width: 12%" />
<col style="width: 10%" />
<col style="width: 6%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: right;">coefs</th>
<th style="text-align: right;">p_vals</th>
<th style="text-align: left;">stars</th>
<th style="text-align: right;">coefs</th>
<th style="text-align: right;">p_vals</th>
<th style="text-align: left;">stars</th>
<th style="text-align: right;">coefs</th>
<th style="text-align: right;">p_vals</th>
<th style="text-align: left;">stars</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">(Intercept)</td>
<td style="text-align: right;">27.6354030</td>
<td style="text-align: right;">0.1249008</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">19.2594292</td>
<td style="text-align: right;">0.2297239</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">22.5556506</td>
<td style="text-align: right;">0.1967736</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sex</td>
<td style="text-align: right;">-33.0132447</td>
<td style="text-align: right;">0.3520875</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">4.0636247</td>
<td style="text-align: right;">0.7259980</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-22.1183301</td>
<td style="text-align: right;">0.0101118</td>
<td style="text-align: left;">*</td>
</tr>
<tr class="odd">
<td style="text-align: left;">status</td>
<td style="text-align: right;">-0.1455658</td>
<td style="text-align: right;">0.6630799</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-0.0487626</td>
<td style="text-align: right;">0.8520324</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">0.0522338</td>
<td style="text-align: right;">0.8534869</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">income</td>
<td style="text-align: right;">6.0290789</td>
<td style="text-align: right;">0.0000013</td>
<td style="text-align: left;">***</td>
<td style="text-align: right;">6.1988460</td>
<td style="text-align: right;">0.0000004</td>
<td style="text-align: left;">***</td>
<td style="text-align: right;">4.9619792</td>
<td style="text-align: right;">0.0000179</td>
<td style="text-align: left;">***</td>
</tr>
<tr class="odd">
<td style="text-align: left;">verbal</td>
<td style="text-align: right;">-2.9747594</td>
<td style="text-align: right;">0.2275778</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-2.6086436</td>
<td style="text-align: right;">0.1980461</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">-2.9594935</td>
<td style="text-align: right;">0.1803109</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:status</td>
<td style="text-align: right;">0.3528830</td>
<td style="text-align: right;">0.5243068</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">sex:income</td>
<td style="text-align: right;">-5.3477745</td>
<td style="text-align: right;">0.0333540</td>
<td style="text-align: left;">*</td>
<td style="text-align: right;">-6.4368291</td>
<td style="text-align: right;">0.0045385</td>
<td style="text-align: left;">**</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">sex:verbal</td>
<td style="text-align: right;">2.8355168</td>
<td style="text-align: right;">0.5409650</td>
<td style="text-align: left;"></td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: right;">NA</td>
<td style="text-align: left;">NA</td>
</tr>
</tbody>
</table>

## Conclusion.

This package, ‘modcomp’, simplifies a common task for many working with
linear regression models, especially for graduate students taking
courses similar to Biostatistical Methods I & II. As model comparison
after implementing changes is a common check and source of interest,
this package enables users to condense the relevant comparison values
into one table, or as a stack of tables. Furthermore, the extract\_lm
package is useful as it offers a way to compute pvalue significance in
terms of a user-defined alpha, if happens to differ from the common
standard of 0.05.

## Future Version in the works… stay tuned.

The framework for this package can easily be expanded to deliver the
same capabilities for other classes of models. For the purposes of this
first version, the scope was restricted to linear models only; however,
it will be a straightforward path to allow for the inclusion of glms,
coxphs, and more model types. An ‘extract\_’ function can be defined for
each model class, and all can be integrated to work into the ‘tablecomp’
and ‘tablestack’ frameworks, with an additional restriction that the
models being compared are of the same class.

## A Note to the User.

Model comparison should be done responsibly; it is most commonly an
appropriate step when working with nested models, and similar models
based on the same dataset. Use thought and care when comparing models,
with added caution to the level of appropriateness for the comparisons
and what information can be drawn from the comparisons.

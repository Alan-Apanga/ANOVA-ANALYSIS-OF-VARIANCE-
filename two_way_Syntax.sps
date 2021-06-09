* Encoding: UTF-8.
*Assumptions check:
    1.Normality tests with QQ plots for Gender and ease of use categorcal variables

EXAMINE VARIABLES=sales BY online_store gender
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.





*Reorganize data based on gender

SORT CASES  BY gender.
SPLIT FILE SEPARATE BY gender.





*Remove gender from the factor list

EXAMINE VARIABLES=sales BY online_store
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.



*Analyze all(undo reorg by gender)

SPLIT FILE OFF.


*Two way ANOVA
    Metric dependent variable:sales 
    Categorical dependent variable:ease of use & gender

UNIANOVA sales BY online_store gender
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=online_store(QREGW) 
  /PLOT=PROFILE(online_store*gender) TYPE=LINE ERRORBAR=CI MEANREFERENCE=NO YAXIS=AUTO
  /PRINT ETASQ DESCRIPTIVE PARAMETER HOMOGENEITY OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=online_store gender online_store*gender.

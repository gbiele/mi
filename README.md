# mi
Missing Data Imputation and Model Checking

This is a version of Goodrich, Gelman et al.'s mi R package with following modifications
- improved handling of parallel processing
- support for zero inflated negative binomial model for count data 
- usage of pmm imputation when ppd leads to verly loarge predicted values

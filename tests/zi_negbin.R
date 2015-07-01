library(devtools)
install_github("gbiele/mi")

library(mi)
options(error = recover)

n = 5000

v1 = rnorm(n)
v2 = rnorm(n)/2 + v1/2
v3 = rnbinom(n,mu = (v1 + rnorm(n))/2+5,size = 10)
v4 = cut(v1+v2,breaks = seq(min(v1+v2),max(v1+v2),length = 8))
df = data.frame(v1,v2,v3,v4)
rm(v1,v2,v3,v4)

for (v in names(df)) df[sample(n,100),v] = NA
mdf = missing_data.frame(df[rowSums(is.na(df)) < 4,])
mdf <- change(mdf, y = "v3", what = "model", to = "zinegbin")
mdf <- change(mdf, y = "v4", what = "type", to = "ordered-categorical")


 missingness_columns =  grep("missing",colnames(mdf@X))
 for (iv in names(mdf@index)){
   dropvars = c(grep("^idx|^group",colnames(mdf@X)),grep(paste("^",iv,sep = ""),colnames(mdf@X)))
   mdf@index[[iv]] = sort(c(mdf@index[[iv]],missingness_columns))
 }

IMP <- mi(mdf, n.chains = 1, max.minutes = 2100, n.iter = 25,parallel = F,verbose = T,save_model = T)
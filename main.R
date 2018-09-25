library(tercen)
library(dplyr)
library(reshape2)
library(tidyr)
?library(edgeR)

data = (ctx = tercenCtx())  %>% 
  select(.ri, .ci, .y) %>% 
  reshape2::acast(.ri ~ .ci, value.var='.y', fill=NaN, fun.aggregate=mean) 

dataNorm = calcNormFactors(data)

data.frame(.ci = seq(from=0,to=length(dataNorm)-1), norm_factor=dataNorm) %>%
  ctx$addNamespace() %>%
  ctx$save()
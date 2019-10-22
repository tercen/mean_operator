library(tercen)
library(dplyr)

mean.matrix = (ctx = tercenCtx()) %>% as.matrix(fill=NaN) 

data = data.frame(.ri = as.vector(row(mean.matrix)-1),
                  .ci = as.vector(col(mean.matrix)-1),
                  mean = as.vector(mean.matrix)) %>%
  ctx$addNamespace() %>%
  ctx$save()

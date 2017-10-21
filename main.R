library(tercen)
library(dplyr)

(ctx = tercenCtx())  %>% 
  select(.values, .cindex, .rindex) %>% 
  group_by(.cindex, .rindex) %>%
  summarise(mean = mean(.values)) %>%
  ctx$addNamespace() %>%
  ctx$save()

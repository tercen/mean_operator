library(tercenApi)
library(tercen)
library(data.table)
library(dtplyr)
library(dplyr, warn.conflicts = FALSE)

ctx = tercenCtx()

ctx  %>% 
  select(.y, .ci, .ri) %>% 
  lazy_dt() %>%
  group_by(.ci, .ri) %>%
  summarise(mean = mean(.y)) %>%
  as_tibble() %>%
  ctx$addNamespace() %>%
  ctx$save()

library(tercen)
library(dplyr)

# options("tercen.workflowId"= "2e6fffab1bcd8ff472773c007d0e4c9d")
# options("tercen.stepId"= "ebda5081-aae4-45fc-b91b-f7b4b19d402a")
ctx = tercenCtx()

ctx  %>% 
  select(.y, .ci, .ri) %>% 
  group_by(.ci, .ri) %>%
  summarise(mean = mean(.y)) %>%
  ctx$addNamespace() %>%
  ctx$save()

library(RPostgreSQL)
library(dplyr)
bety_src <- src_postgres(dbname = "bety", password = 'bety', host = 'terra-bety.default', user = 'bety', port = 5432)

species <- tbl(bety_src, 'species') %>% 
  mutate(specie_id = id)




files <- dir("~/genesys_stc/", pattern = '.csv', full.names = TRUE)
accessions <- read.csv(files[6])
files <- files[c(1:5,7:30)]
tables <- gsub(".csv", "", basename(files))

for(i in seq_along(files)){
  next_table <- read.csv(files[i])
  next_table$datasetId <- NULL
  colnames(next_table)[colnames(next_table) == 'value'] <- tables[i]
  
  accessions <- merge(accessions, next_table, by = 'genesysId',all.accessions=TRUE)
}


df_traits_stc = accessions
write.csv(df_traits_stc, file = "df_traits_stc.csv")

my_data <- accessions[, c(3,5:15)]
corMatrix <- cor(my_data)
round(corMatrix, 3)

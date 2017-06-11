
files <- dir("~/genesys_nutrition/", pattern = '.csv', full.names = TRUE)
accessions <- read.csv(files[2])
files <- files[c(1,3:12)]
tables <- gsub(".csv", "", basename(files))

for(i in seq_along(files)){
  next_table <- read.csv(files[i])
  next_table$datasetId <- NULL
  colnames(next_table)[colnames(next_table) == 'value'] <- tables[i]
  
  accessions <- merge(accessions, next_table, by = 'genesysId',all.accessions=TRUE)
}

my_data <- accessions[, c(3,5:15)]
corMatrix <- cor(my_data)
round(corMatrix, 3)

corMatrix_nutrition = corMatrix

write.csv(corMatrix_nutrition, file = "corrMatrix_nutrition.csv")

df_traits_nutrition = accessions
write.csv(df_traits_nutrition, file = "df_traits_nutrition.csv")



######################## extracting genesys data ######################
files <- dir("~/genesys", pattern = '.csv', full.names = TRUE)
accessions <- read.csv(files[6])
files <- files[c(1:5,7:36)]
tables <- gsub(".csv", "", basename(files))


#The $ allows you extract elements by name from a named list.
for(i in seq_along(files)){
  next_table <- read.csv(files[i])
  next_table$datasetId <- NULL
  colnames(next_table)[colnames(next_table) == 'value'] <- tables[i]
  accessions <- left_join(accessions, next_table, by = 'genesysId')
}

genesys_data <- accessions %>%
  mutate(acceNumb = gsub("PI ", "PI", acceNumb))

#sort genesys_data by the PIs
genesys_data_sorted <- genesys_data[order(genesys_data$acceNumb),]

######################## extracting vcf data #########################################
install.packages("vcfR")
library(vcfR)
vcf_data <- read.vcfR(file="/data/terraref/sites/genomics/derived_data/ril/gbs/imp_TERRA_RIL_SNP.vcf")

vcf_fix = vcf_data@fix
vcf_gt = vcf_data@gt
vcf_meta = vcf_data@meta

vcf_fix %>% 
  mutate(ifelse())

colnames(vcf_gt)<-gsub(".MERGE", "",colnames(vcf_gt))

#######################   match   ##############################################
match_vcf<-colnames(vcf_gt) %in% genesys_data_sorted$acceNumb
colnames(vcf_gt)[match_vcf]

match_genesys<- genesys_data_sorted$acceNumb  %in% colnames(vcf_gt)
genesys_data_sorted[match_genesys,]$acceNumb

#Test if the 19 PIs are really the same
colnames(vcf_gt)[match_vcf]==genesys_data_sorted[match_genesys,]$acceNumb

sum(matching)  #number of TRUE positions -only 19!

#extract 19 matches from genesys
genesys_data_match <- genesys_data_sorted[match_genesys,]

#extract 19 matches from vcf
vcf_gt_match <- vcf_gt[,match_vcf]
vcf_data_match@fix <- vcf_data@fix
vcf_data_match@meta <- vcf_data@meta
vcf_data_match@gt <- vcf_gt_match

write_csv(genesys_data_match, '~/genesys_data_match.csv')

# Used genome_table@gt[0,c(212:304)] to get the PI's from the 'genome data'
#First genome_table@gt[1,c(212:304)]
#Last genome_table@gt[70693,c(212:304)]
# PIs from Terraref genome data: c('PI 291234', 'PI 291235', 'PI 297245', 'PI 297247', 'PI 457747','PI 508372', 'PI 510709', 'PI 510904', 'PI 510907', 'PI 510917','PI 510918', 'PI 510921', 'PI 510922', 'PI 510923', 'PI 510924','PI 510925', 'PI 510931', 'PI 510932', 'PI 510933', 'PI 510934','PI 510943', 'PI 510944', 'PI 510945', 'PI 510946', 'PI 510948','PI 510950', 'PI 510951', 'PI 510963', 'PI 510966', 'PI 510972','PI 510974', 'PI 510975', 'PI 510977', 'PI 510978', 'PI 510980','PI 510981', 'PI 510983', 'PI 510989', 'PI 510991', 'PI 510993','PI 510994', 'PI 511002', 'PI 511011', 'PI 511015', 'PI 511016','PI 511018', 'PI 511019', 'PI 511020', 'PI 511257', 'PI 511258','PI 560493', 'PI 562238', 'PI 562712', 'PI 562777', 'PI 563068','PI 563392', 'PI 563398', 'PI 563409', 'PI 563430', 'PI 563447','PI 563448', 'PI 563449', 'PI 563450', 'PI 563451', 'PI 563452','PI 563453', 'PI 563454', 'PI 563455', 'PI 563457', 'PI 563485','PI 563638', 'PI 565120', 'PI 565123', 'PI 569812', 'PI 585346','PI 585347', 'PI 585348', 'PI 585349', 'PI 585350', 'PI 585351','PI 585353', 'PI 585355', 'PI 585359', 'PI 585363', 'PI 585365','PI 585368', 'PI 585369', 'PI 585372', 'PI 585373', 'PI 585374','PI 585376', 'PI 585379', 'PI 586046')
# c('PI 510904', 'PI 510907', 'PI 510917', 'PI 510921', 'PI 510922', 'PI 510923', 'PI 510924','PI 510925', 'PI 510931', 'PI 510934', 'PI 510946', 'PI 510948', 'PI 510950', 'PI 510951','PI 510972', 'PI 510974', 'PI 510977', 'PI 510991', 'PI 510993', 'PI 510994', 'PI 511002','PI 511011', 'PI 511015', 'PI 511016', 'PI 511018', 'PI 560493', 'PI 562777', 'PI 563068','PI 563392', 'PI 563398', 'PI 563409', 'PI 563430', 'PI 563447', 'PI 563448', 'PI 563449','PI 563450', 'PI 563451', 'PI 563452', 'PI 563453', 'PI 563454', 'PI 563455', 'PI 563485','PI 565120', 'PI 569812', 'PI 585368', 'PI 585369', 'PI 585373', 'PI 585379')

## Prelim data
library(vcfR)
#May have a different location for you...
#genome_table=read.vcfR('~/imp_TERRA_RIL_SNP.vcf')
genome_table=read.vcfR('/data/terraref/sites/genomics/derived_data/ril/gbs/imp_TERRA_RIL_SNP.vcf')
acceNumb = c('PI 291234', 'PI 291235', 'PI 297245', 'PI 297247', 'PI 457747','PI 508372', 'PI 510709', 'PI 510904', 'PI 510907', 'PI 510917','PI 510918', 'PI 510921', 'PI 510922', 'PI 510923', 'PI 510924','PI 510925', 'PI 510931', 'PI 510932', 'PI 510933', 'PI 510934','PI 510943', 'PI 510944', 'PI 510945', 'PI 510946', 'PI 510948','PI 510950', 'PI 510951', 'PI 510963', 'PI 510966', 'PI 510972','PI 510974', 'PI 510975', 'PI 510977', 'PI 510978', 'PI 510980','PI 510981', 'PI 510983', 'PI 510989', 'PI 510991', 'PI 510993','PI 510994', 'PI 511002', 'PI 511011', 'PI 511015', 'PI 511016','PI 511018', 'PI 511019', 'PI 511020', 'PI 511257', 'PI 511258','PI 560493', 'PI 562238', 'PI 562712', 'PI 562777', 'PI 563068','PI 563392', 'PI 563398', 'PI 563409', 'PI 563430', 'PI 563447','PI 563448', 'PI 563449', 'PI 563450', 'PI 563451', 'PI 563452','PI 563453', 'PI 563454', 'PI 563455', 'PI 563457', 'PI 563485','PI 563638', 'PI 565120', 'PI 565123', 'PI 569812', 'PI 585346','PI 585347', 'PI 585348', 'PI 585349', 'PI 585350', 'PI 585351','PI 585353', 'PI 585355', 'PI 585359', 'PI 585363', 'PI 585365','PI 585368', 'PI 585369', 'PI 585372', 'PI 585373', 'PI 585374','PI 585376', 'PI 585379', 'PI 586046')
genome_data = genome_table@gt[,c(212:304)]

## Functions for distance
locus_tovalue <- function(genome_seq){
  genome_value<-matrix(nrow = length(genome_seq),ncol =2)
  genome_value[genome_seq =='0|0']<-c(0,0)
  genome_value[genome_seq =='1|1']<-c(1,1)
  genome_value[genome_seq =='0|1']<-c(0,1)
  genome_value[genome_seq == '1|0']<-c(1,0)
  return(as.numeric(genome_value)) 
} 
hamming <- function(genome_seq1,genome_seq2){
  genome_value1 <- locus_tovalue(genome_seq1)
  genome_value2 <- locus_tovalue(genome_seq2)
  point_dif<-genome_value1-genome_value2
  distance <- sum(abs(genome_value1 - genome_value2))
  return(distance)
}

## Dist
genome_dist = genome_data[1,]
for(i in c(1:length(genome_dist))){
  genome_dist[i] = hamming(genome_data[,i],'0|0')
}

## 10
genome_ten = genome_data[10,]
for(i in c(1:length(genome_ten))){
  genome_ten[i] = hamming(genome_ten[i],'0|0')
}

genome_ten

## Pulling the accession numbers with both available genes and traits
func_genomefeature_trait <- function(file,locus_n){
  # reduced list of PI numbers
  PIs_merged <- merge(data.frame(acceNumb),file,by="acceNumb")
  PIs_restricted <- PIs_merged[,1]
  acceNumb = PIs_restricted
  
  
  ## Merge feature from reduced genome data
  locus_10 = genome_ten[acceNumb]
  feature <- data.frame(acceNumb,locus_10)
  #genome_dist = genome_dist[acceNumb]
  #feature <- data.frame(acceNumb,genome_dist)
  #genome_restricted = genome_data[,acceNumb]
  #feature <- data.frame(acceNumb,genome_restricted[locus_n,])
  feature_traits <- merge(file,feature,by="acceNumb")
}

## Correlation between Nutrition and locus10
df_traits_nutrition <- read.csv(file = '~/Team5/data/df_traits_nutrition.csv')
locus10_nutrition = func_genomefeature_trait(df_traits_nutrition,10)
locus10_nut <- locus10_nutrition[, c(6:17)]
locus10_nut
locus10_nut[,12] <- as.numeric(as.character(locus10_nut[,12]))
corMatrix_nut_locus10 = cor(locus10_nut)
write.csv(corMatrix_nut_locus10, file = "corMatrix_nut_locus10.csv")

## Correlation between Nutrition and Genome dist
df_traits_nutrition <- read.csv(file = '~/Team5/data/df_traits_nutrition.csv')
locus_nutrition = func_genomefeature_trait(df_traits_nutrition,1)
locus_nut_num <- locus_nutrition[, c(6:17)]
locus_nut_num
locus_nut_num[,12] <- as.numeric(as.character(locus_nut_num[,12]))
corMatrix_nut_genomedist = cor(locus_nut_num)
write.csv(corMatrix_nut_genomedist, file = "corMatrix_nut_genomedist.csv")

## Correlation between Growth and Genome dist
df_traits_growth <- read.csv(file = '~/Team5/data/df_traits_growth.csv')
locus_growth = func_genomefeature_trait(df_traits_growth,1)
locus_gro_num <- locus_growth[, c(7:11)]
locus_gro_num
locus_gro_num[,5] <- as.numeric(as.character(locus_gro_num[,5]))
corMatrix_gro_genomedist = cor(locus_gro_num)
write.csv(corMatrix_gro_genomedist, file = "corMatrix_gro_genomedist.csv")

## Prelim data
library(vcfR)
#May have a different location for you...
genome_table=read.vcfR('/data/terraref/sites/genomics/derived_data/ril/gbs/imp_TERRA_RIL_SNP.vcf')
genome_data = genome_table@gt[,c(212:304)]
colnames(genome_data) <- gsub(".MERGE","",colnames(genome_data))
colnames(genome_data) <- gsub("PI","PI ",colnames(genome_data))
acceNumb <- colnames(genome_data)


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


## Pulling the accession numbers with both available genes and traits
func_genomefeature_trait <- function(file,prop){
  PIs_merged <- merge(data.frame(acceNumb),file,by="acceNumb")
  PIs_restricted <- PIs_merged[,1]
  acceNumb = PIs_restricted
  
  ## Merge feature from reduced genome data
  genome_feature = prop[acceNumb]
  featuredf <- data.frame(acceNumb,genome_feature)
  feature_traits <- merge(file,featuredf,by="acceNumb")
}

## Correlation between traits and genome data
## Dist
genome_dist = genome_data[1,]
for(i in c(1:length(genome_dist))){
  genome_dist[i] = hamming(genome_data[,i],'0|0')
}

## Locus10
genome_ten = genome_data[10,]
for(i in c(1:length(genome_ten))){
  genome_ten[i] = hamming(genome_ten[i],'0|0')
}

## Correlation between Nutrition and locus10
df_traits_nutrition <- read.csv(file = '~/Team5/data/df_traits_nutrition.csv')
locus10_nutrition = func_genomefeature_trait(df_traits_nutrition,genome_ten)
locus10_nut <- locus10_nutrition[, c(6:17)]
locus10_nut[,12] <- as.numeric(as.character(locus10_nut[,12]))
corMatrix_nut_locus10 = cor(locus10_nut)
#write.csv(corMatrix_nut_locus10, file = "corMatrix_nut_locus10.csv")

## Correlation between Nutrition and Genome dist
df_traits_nutrition <- read.csv(file = '~/Team5/data/df_traits_nutrition.csv')
locus_nutrition = func_genomefeature_trait(df_traits_nutrition,genome_dist)
locus_nut_num <- locus_nutrition[, c(6:17)]
locus_nut_num[,12] <- as.numeric(as.character(locus_nut_num[,12]))
corMatrix_nut_genomedist = cor(locus_nut_num)
#write.csv(corMatrix_nut_genomedist, file = "corMatrix_nut_genomedist.csv")

## Correlation between Growth and Genome dist
df_traits_growth <- read.csv(file = '~/Team5/data/df_traits_growth.csv')
locus_growth = func_genomefeature_trait(df_traits_growth,genome_dist)
locus_gro_num <- locus_growth[, c(7:11)]
locus_gro_num[,5] <- as.numeric(as.character(locus_gro_num[,5]))
corMatrix_gro_genomedist = cor(locus_gro_num)
#write.csv(corMatrix_gro_genomedist, file = "corMatrix_gro_genomedist.csv")


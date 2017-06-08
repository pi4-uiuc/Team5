## Prelim data
library(vcfR)

genome_table=read.vcfR('~/Team5/data/imp_TERRA_RIL_SNP.vcf')
acceNumb = c('PI 291234', 'PI 291235', 'PI 297245', 'PI 297247', 'PI 457747','PI 508372', 'PI 510709', 'PI 510904', 'PI 510907', 'PI 510917','PI 510918', 'PI 510921', 'PI 510922', 'PI 510923', 'PI 510924','PI 510925', 'PI 510931', 'PI 510932', 'PI 510933', 'PI 510934','PI 510943', 'PI 510944', 'PI 510945', 'PI 510946', 'PI 510948','PI 510950', 'PI 510951', 'PI 510963', 'PI 510966', 'PI 510972','PI 510974', 'PI 510975', 'PI 510977', 'PI 510978', 'PI 510980','PI 510981', 'PI 510983', 'PI 510989', 'PI 510991', 'PI 510993','PI 510994', 'PI 511002', 'PI 511011', 'PI 511015', 'PI 511016','PI 511018', 'PI 511019', 'PI 511020', 'PI 511257', 'PI 511258','PI 560493', 'PI 562238', 'PI 562712', 'PI 562777', 'PI 563068','PI 563392', 'PI 563398', 'PI 563409', 'PI 563430', 'PI 563447','PI 563448', 'PI 563449', 'PI 563450', 'PI 563451', 'PI 563452','PI 563453', 'PI 563454', 'PI 563455', 'PI 563457', 'PI 563485','PI 563638', 'PI 565120', 'PI 565123', 'PI 569812', 'PI 585346','PI 585347', 'PI 585348', 'PI 585349', 'PI 585350', 'PI 585351','PI 585353', 'PI 585355', 'PI 585359', 'PI 585363', 'PI 585365','PI 585368', 'PI 585369', 'PI 585372', 'PI 585373', 'PI 585374','PI 585376', 'PI 585379', 'PI 586046')
genome_data = genome_table@gt[,c(212:304)]

## Pulling the accession numbers with both available genes and traits
func_genomefeature_trait <- function(file,locus_n){
  # reduced list of PI numbers
  PIs_merged <- merge(data.frame(acceNumb),file,by="acceNumb")
  PIs_restricted <- PIs_merged[,1]
  # reduced genome data
  genome_restricted = genome_data[,PIs_restricted]
  
  # Merge feature from genome
  acceNumb = PIs_restricted
  feature <- data.frame(acceNumb,genome_restricted[locus_n,])
  feature_traits <- merge(file,feature,by="acceNumb")
}

df_traits_growth <- read.csv(file = 'df_traits_growth.csv')
df_traits_nutrition <- read.csv(file = 'df_traits_nutrition.csv')
locus10_nutrition = func_genomefeature_trait(df_traits_nutrition,10)


locus10_nutritions <- locus10_nutrition[, c(1,6:17)]
locus10_nutritions

#write.csv(genesys_vcf_48, file = "genesys_vcf_48.csv")

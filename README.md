# Team5

For formating in markdown, see [here](http://rmarkdown.rstudio.com/authoring_basics.html).

### Names:

* Stacey Butler
* Michael Livesay
* Robert Rennie
* Sarka Petrickova
* Mary Angelica Tursi

### Ideas:

* Genotype/phenotype correlation analysis
* Topological data analysis
* Competitive dynamical models based on stock spacing

### Types:

* height vs time, genotype, stock spacing

### Algorithms:

* Spectral clustering methods
* Gilpin-Ayala equations
* python mapper
* persistant homology

### Data: 

* vcf: Read /Team5/Accessing_genome_data.Rmd

```{r}
file.copy(from = "/data/terraref/sites/genomics/derived_data/ril/gbs/imp_TERRA_RIL_SNP.vcf", to = '~/Team5/Data/')
```
* genesys: Use shell to download compressed .cvd file, extract, and upload to RStudio

```{r}
wget https://github.com/pi4-uiuc/Team5/files/1049350/genesys-dataset-bd6e6ee9-7919-11e3-9d0a-5254001a6979.zip

tar -xvf genesys-dataset-bd6e6ee9-7919-11e3-9d0a-5254001a6979.zip
```

* terraref traits: Read /Team5/terraref_traits.Rmd

* To match vcf and genesys: Read /Team5/match_vcf_genesys.R



******

-Mike
  I am building a correlation matrix for over between the "Passport Data Completeness Index" and the various variables given below, for each "Accession Number".
Example:
Accession Number: PI 533774
PDCI: 7.8/10
Variables:
  Crude protein percentage
  12-hour in vitro Dry Matter Digestibility
  Absence or presence of Sorghum Yellow Banding Virus
  Starch percentage
  Average Seedling vigor 
  Net Energy for lactation (cattle) epxressed in Mcal/cwt
  Aluminum toxicity tolerance


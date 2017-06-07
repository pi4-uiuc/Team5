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





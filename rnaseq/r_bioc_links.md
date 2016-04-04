# R and Bioconductor links

* [Central R Archive Network (CRAN)](http://cran.rstudio.com/)
* [RStudio](http://www.rstudio.com/)
* [Bioconductor](http://bioconductor.org/install)

We will allow either R version 3.1.3, 3.2.0 or 3.2.4 for this class.

* R 3.1.3 is linked to Bioconductor version 3.0
* R 3.2.0 is linked to Bioconductor version 3.1
* R 3.2.4 is linked to Bioconductor version 3.2

Once you have installed R, running the following lines in your console will install Bioconductor:

```
source("http://bioconductor.org/biocLite.R")
biocLite()
```

Make sure to hit `[a]` to update all packages. This is important so that your answers will match the answers accepted by the grading bot.

To install specific packages from Bioconductor use, for example:

```
biocLite(c("pasilla","DEXSeq"))
```

We will provide a list of all packages we will use [here]().

If you want to see what version of Biocondutor you are using and whether your packages are up to date:

```
library(BiocInstaller)
biocVersion()
biocValid()
```

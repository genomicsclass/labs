# Installing Bioconductor and finding help

## Installing Bioconductor

In order to install Bioconductor, copy the following two lines into your R console.


```r
source("http://bioconductor.org/biocLite.R")
biocLite()
```


This will install the core Bioconductor packages. Further packages can be installed using the `biocLite` function and specifying a character vector of which packages to install. For example:


```r
biocLite(c("affy", "genefilter"))
```


## Finding help

There are many ways to find help directly from within R. Typically, every function will have its own manual page which is accessible by typing a question mark ?, followed by the function name and hitting return.


```r
`?`(median)
```


Simply typing the name of the function, without parenthises, and hitting return will show the source code of the function.

The manual page contains a *description*, example *usage*, explanation of all *arguments*, further *details*, explanation of the returned *value*, *references*, "*see also*", and *examples*.

If you have a question about a particular object in R, you might want to look up the help for the "class" of that object, which will tell you how to construct such an object and what methods are available for manipulating such objects. For example, we can find the name of the class of an object and look up help:


```r
class(6)
`?`(numeric)
```


Sometimes, it is necessary to put "-class" on the end of the class name and wrap the class name in quote marks, as in `?"eSet-class"`.

## Vignettes

"Vignettes" are documents which accompany R packages and are required for every Bioconductor package. They typically show an example workflow of the functions of the package using code chunks with descriptive text, exactly as the document you are currently reading. You can find Bioconductor vignettes in PDF or R script form on the Bioconductor website, but they are even easier to access directly through R. Furthermore, accessing vignettes through R guarantees that the vignette is for the correct version of the package that you are using. The following code will list the names of the vignettes for a given package:


```r
library("Biobase")  # first load the package
vignette(package = "Biobase")
```


A further call to `vignette` with the name of the vignette will launch a PDF viewer:


```r
vignette("ExpressionSetIntroduction")
```


In addition, an HTML browser can be launched with links to the various vignettes of a package using `browseVignettes(package="Biobase")`.


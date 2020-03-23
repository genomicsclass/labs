# R and Bioconductor links

* [Central R Archive Network (CRAN)](http://cran.rstudio.com/)
* [RStudio](http://www.rstudio.com/)
* [Bioconductor](http://bioconductor.org/install)

Once you have installed R and the `BiocManager` package, running the following lines in your console will install Bioconductor:

```
BiocManager::install()
```

Make sure to hit `[a]` to update all packages. This is important so that your answers will match the answers accepted by the grading bot.

To install specific packages from Bioconductor use, for example:

```
BiocManager::install(c("pasilla", "DEXSeq"))
```

We will provide a list of all packages we will use [here](rnaseq_pkgs.R).

If you want to see what version of Bioconductor you are using and whether your packages are up to date:

```
BiocManager::version()
BiocManager::valid()
```

# Exploratory Data Analysis

In this document, we will review the meaning and how to generate some key plots for exploring data: scatterplots, boxplots, histograms and stripplots.

## Scatterplot


```r
if (!"UsingR" %in% installed.packages()[, 1]) install.packages("UsingR")
library("UsingR")
```

```
## Loading required package: MASS
```

```r
data("father.son")
head(father.son)
```

```
##   fheight sheight
## 1   65.05   59.78
## 2   63.25   63.21
## 3   64.96   63.34
## 4   65.75   62.79
## 5   61.14   64.28
## 6   63.02   64.24
```

```r
plot(father.son$fheight, father.son$sheight, main = "Pearson's data set on heights\nof fathers and their sons")
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 


## Download and load a microarray expression set


```r
if (!"maPooling" %in% installed.packages()[, 1]) {
    if (!"devtools" %in% installed.packages()[, 1]) {
        install.packages("devtools")
    }
    library("devtools")
    install_github("maPooling", "mikelove")
}
library("Biobase")
library("maPooling")
data("maPooling")
e <- maPooling
```


## Box plot


```r
library("RColorBrewer")
cols <- brewer.pal(8, "Dark2")
par(mar = c(7, 5, 3, 3))
boxplot(exprs(e)[, 1:12], col = cols, las = 2)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


## Scatter plot


```r
par(mar = c(5, 5, 3, 3))
plot(exprs(e)[, 1:2])
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 



```r
smoothScatter(exprs(e)[, 1:2])
```

```
## KernSmooth 2.23 loaded
## Copyright M. P. Wand 1997-2009
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


## Histogram


```r
hist(exprs(e)[, 1], col = "grey")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


## Strip plot


```r
genes <- rownames(e)[1:5]
names(genes) <- genes
l <- lapply(genes, function(i) exprs(e)[i, ])
par(mar = c(5, 7, 3, 3))
stripchart(l, pch = 1, method = "jitter", las = 1)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


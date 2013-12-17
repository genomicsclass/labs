# EDA plots for microarray


```r
shistogram <- function(z, unit, plotHist = TRUE) {
    n <- length(z)
    main <- paste("Shistogram of", deparse(substitute(z)))
    d <- density(z)
    ymax <- max(d$y * n * unit)
    if (plotHist) {
        h <- hist(z, breaks = seq(from = min(z) - unit, to = max(z) + unit, 
            by = unit), plot = FALSE)
        ymax <- max(ymax, h$count)
        plot(h, col = "grey", main = main, xlab = deparse(substitute(z)), ylim = c(0, 
            1.1 * ymax))
    } else {
        ymax <- ymax
        h <- hist(z, breaks = seq(from = min(z) - unit, to = max(z) + unit, 
            by = unit), plot = FALSE)
        plot(0, 0, type = "n", xlim = c(min(z) - unit, max(z) + unit), ylim = c(0, 
            1.1 * ymax), xlab = deparse(substitute(z)), ylab = "Frequency", 
            main = main)
    }
    lines(d$x, d$y * n * unit, lwd = 3, col = "dodgerblue")
    arrows(min(z) - unit, ymax, min(z), ymax, angle = 90, code = 3, length = 0.1)
    text(min(z), ymax, paste("unit =", unit), pos = 4)
}
```



```r
set.seed(1)
n <- 1000
x <- rnorm(n)
par(mfrow = c(2, 2))
shistogram(x, unit = 1)
shistogram(x, unit = 2)
shistogram(x, unit = 0.5)
shistogram(x, unit = 0.5, plotHist = FALSE)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


# biocLite("SpikeInSubset")
library(SpikeInSubset)
data(rma95)
library(genefilter)
fac <- factor(rep(1:2,each=3))
tt <- rowttests(exprs(rma95),fac)
mask <- with(tt, abs(dm) < .2 & p.value < .01)
cols <- ifelse(mask,"red","black")
with(tt, plot(dm, -log10(p.value), cex=.5,
     xlim=c(-1,1), ylim=c(0,5),
     col=cols))
abline(h=2,v=c(-.2,.2), lty=2)

tt$s <- tt$dm / tt$statistic
with(tt, plot(-log10(p.value), s,
              log="y",
              cex=.5, col=cols))

library(limma)
fit <- lmFit(rma95, model.matrix(~ fac))
ebfit <- ebayes(fit)
limmares <- data.frame(dm=coef(fit)[,"fac2"], p.value=ebfit$p.value[,"fac2"])
with(limmares, plot(dm, -log10(p.value),
     cex=.5, col=cols,
     xlim=c(-1,1), ylim=c(0,4)))
abline(h=2,lty=2)

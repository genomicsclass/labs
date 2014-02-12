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
     xlim=c(-1,1), ylim=c(0,5)))
abline(h=2,v=c(-.2,.2), lty=2)


n <- 40
qs <- seq(from=0,to=.2,length=n)
idx <- sapply(seq_len(n),function(i) which(as.integer(cut(tt$s^2,qs)) == i)[1])
idx <- idx[!is.na(idx)]
plot(1,1,xlim=c(0,.17),ylim=c(0,1),type="n",
     xlab="",ylab="")
segments((tt$s^2)[idx],rep(.1,n),
         ebfit$s2.post[idx],rep(.9,n))

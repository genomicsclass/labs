
## ----options, echo=FALSE-------------------------------------------------
opts_chunk$set(fig.path=paste0("figure/", sub("(.*).Rmd","\\1",basename(knitr:::knit_concord$get('infile'))), "-"))


## ----definingHeights, message=FALSE--------------------------------------
library(UsingR)
x=father.son$fheight


## ------------------------------------------------------------------------
round(sample(x,20),1)


## ----histogram, fig.width=4, fig.height=4--------------------------------
hist(x,breaks=seq(floor(min(x)),ceiling(max(x))),main="",xlab="Height")


## ------------------------------------------------------------------------
xs<-seq(floor(min(x)),ceiling(max(x)),0.1)
plot(xs,ecdf(x)(xs),type="l",xlab="x=Height",ylab="F(x)")


## ------------------------------------------------------------------------
1-pnorm(72,mean(x),sd(x)) 


## ------------------------------------------------------------------------
ps <- seq(0.01,0.99,0.01)
qs <- quantile(x,ps)
normalqs <- qnorm(ps,mean(x),sd(x))
plot(normalqs,qs,xlab="Normal percentiles",ylab="Height percentiles")
abline(0,1) ##identity line


## ------------------------------------------------------------------------
qqnorm(x)
qqline(x)


## ----fig.width=4, fig.height=4-------------------------------------------
hist(exec.pay)
qqnorm(exec.pay)
qqline(exec.pay)


## ----fig.width=4, fig.height=4-------------------------------------------
boxplot(exec.pay,ylab="10,000s of dollars",ylim=c(0,400))


## ----fig.width=4, fig.height=4-------------------------------------------
data("father.son")
x=father.son$fheight
y=father.son$sheight
plot(x,y,xlab="Father's height in inches",ylab="Son's height in inches",main=paste("correlation =",signif(cor(x,y),2)))


## ----fig.width=6, fig.height=3-------------------------------------------
boxplot(split(y,round(x)))
print(mean(y[ round(x) == 72]))


## ----fig.width=3, fig.height=3-------------------------------------------
x=(x-mean(x))/sd(x)
y=(y-mean(y))/sd(y)
means=tapply(y,round(x*4)/4,mean)
fatherheights=as.numeric(names(means))
plot(fatherheights,means,ylab="average of strata of son heights",ylim=range(fatherheights))
abline(0,cor(x,y))


## ----fig.width=3, fig.height=3-------------------------------------------
a=rnorm(100);a[1]=10
b=rnorm(100);b[1]=11
plot(a,b,main=paste("correlation =",signif(cor(a,b),2)))



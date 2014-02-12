drawU <- function(a,y,boxes=FALSE,xmax=1) {
  plot(1,1,type="n",xlim=c(0,xmax),ylim=c(0,1.2*y),bty="L",xlab="p",ylab="",las=1)
  lines(c(0,1,1,0,0),c(0,0,y,y,0))
  polygon(c(0,a,a,0),c(0,0,y,y),col=rgb(1,0,0,.5))
  polygon(c(a,1,1,a),c(0,0,y,y),col=rgb(0,0,0,.1))
  x <- 1/a
  if (boxes) {
    segments(0:x/x, 0, 0:x/x, y)
  }
}

drawU(.3,1)
drawU(1/20,1)
drawU(1/20,20000/20,TRUE)
drawU(1/100,20000/100,TRUE)
drawU(1/1000,20000/1000,TRUE,.01)

z <- rnorm(100)
brks <- 0:20/20
hist(pnorm(z),col="grey",main="",xlab="p",breaks=brks)

z <- rnorm(10000)
hist(pnorm(z),col="grey",main="",xlab="p",breaks=brks)

z <- c(rnorm(10000), rep(-3.72,500))
h <- hist(pnorm(z),col="grey",main="",xlab="p",breaks=brks)
abline(h=10000/20,col="red",lwd=4,lty=3)
abline(h=h$counts[1],col="blue",lwd=4,lty=3)

h <- hist(pnorm(z),col="grey",main="",xlab="p",breaks=0:50/50)
abline(h=10000/50,col="red",lwd=4,lty=3)
abline(h=h$counts[1],col="blue",lwd=4,lty=3)

h <- hist(pnorm(z),col="grey",main="",xlab="p",breaks=0:100/100)
abline(h=10000/100,col="red",lwd=4,lty=3)
abline(h=h$counts[1],col="blue",lwd=4,lty=3)

h <- hist(pnorm(z),col="grey",main="",xlab="p",breaks=0:10000/10000)
abline(h=10000/10000,col="red",lwd=4,lty=3)
abline(h=sum(h$counts[1]),col="blue",lwd=4,lty=3)
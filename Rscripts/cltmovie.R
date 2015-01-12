dat<-read.csv("http://www.biostat.jhsph.edu/bstcourse/bio751/data/USheights_subsample.csv")

library(animation)
saveGIF({
    set.seed(1)
    N=10
    L<-1000
    means<-vector("numeric",L)
    LIM=seq(69.28-4,69.28+4,0.33/sqrt(N)*sqrt(10))
    LIM2=seq(69.28-4,69.28+4,0.1)
    for(i in 1:L){
        means[i]<-mean(sample(dat$Height[dat$Gender==1],N))
         if(i%%20==1){
             dd=dnorm(LIM2,mean(dat$Height[dat$Gender==1]),sd(dat$Height[dat$Gender==1])/sqrt(N))
             tmp=hist(means[1:i],ylim=c(0,150),xlim=range(LIM),breaks=LIM,freq=TRUE,xlab="average height",ylab="Density",main=paste0("N=",N))
             k=sum(tmp$counts)/sum(dd)*length(dd)/length(tmp$counts) ##this is a normalizing constant to assure same are on plot
             lines(LIM2,dd*k,type="l",col=2,lwd=2)
         }
    }
},'clt10.gif', interval = .05)



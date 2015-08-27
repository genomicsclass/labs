##If you have ImageMagic installed on your computer, 
##you can create an animated gif with code 
##below. Note that the computation will make several
##gifs so it might take some time to compute. 
##Make sure to pick a `filename` that does not already exist in the working directory.

set.seed(3)
prev <- 1/20
acc <- 0.90
##For the animation we use 20 x 80 
N <- 20; M <- 80
x<-rbinom(N*M,1,p=prev)
cols <- c("grey","red")
people <- expand.grid(1:M,N:1)
people2 <- expand.grid(1:(M/2),N:1)

cols1 <- cols[x+1]
cols2 <- rep(NA,length(cols1));count2<-1
cols3 <- rep(NA,length(cols1));count3<-1

library(rafalib)
library(animation)
filename <- 'bayes.gif'
saveGIF({
  i=1
  while(count3 <= N*M/2 & count2 <= N*M/2){
    test <- sample(100,1);min=round(100*acc)
    mypar()
    layout(matrix(c(1,2,1,3),2,2))
    plot(people,col=cols1,pch=16,xaxt="n",yaxt="n",xlab="",ylab="",main=paste0("Population: ",round(mean(x)*100),"% are red"))
    if(test>min) axis(side=1,M/2,"X",col="red",tick=FALSE,cex.axis=3,line=1.5) else axis(side=1,M/2,"O",col="black",tick=FALSE,cex.axis=2,line=1.5)
    points(people[i,],pch=1,cex=1.5)
    if(all(is.na(cols2))) plot(people2,type="n",pch=16,xaxt="n",yaxt="n",xlab="",ylab="",main="Tested Positive") else plot(people2,col=cols2,pch=16,xaxt="n",yaxt="n",xlab="",ylab="",main=paste0("Tested Positive: ",round(mean(cols2=="red",na.rm=TRUE)*100),"% are red"))
    if(all(is.na(cols3))) plot(people2,type="n",pch=16,xaxt="n",yaxt="n",xlab="",ylab="",main="Tested Negative") else plot(people2,col=cols3,pch=16,xaxt="n",yaxt="n",xlab="",ylab="",main=paste0("Tested Negative: ",round(mean(cols3=="red",na.rm=TRUE)*100,1),"% are red"))
    outcome <- ifelse(x[i]==1, as.numeric(test<=min), as.numeric(test>min))
    if(outcome==0) {cols3[count3]<-cols1[i];count3<-count3+1} else {cols2[count2]<-cols1[i];count2<-count2+1}
    i<-i+1
  }},filename, interval = .1, ani.width = 800, ani.height = 500)


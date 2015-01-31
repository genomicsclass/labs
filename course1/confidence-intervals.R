
## ----,results=FALSE,echo=FALSE-------------------------------------------
set.seed(1) ##so that we get same results


## ------------------------------------------------------------------------
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- tempfile()
download.file(url,destfile=filename,method="curl")
dat <- read.csv(filename)


## ------------------------------------------------------------------------
head(dat)


## ------------------------------------------------------------------------
chowPopulation <- dat[dat$Sex=="F" & dat$Diet=="chow",3]


## ------------------------------------------------------------------------
mu_chow <- mean(chowPopulation)
print(mu_chow)


## ------------------------------------------------------------------------
N <- 30
hf <- sample(chowPopulation,N)


## ------------------------------------------------------------------------
se=sd(hf)/sqrt(N)
print(se)


## ------------------------------------------------------------------------
plot(mean(chowPopulation)+c(-7,7),c(1,1),type="n",xlab="weight",ylab="interval",ylim=c(1,100))
abline(v=mean(chowPopulation))
Q <- qnorm(1- 0.05/2)
lines( c(mean(hf)-Q*se, mean(hf)+Q*se ), c(1,1))
for(i in 2:100){
  hf <- sample(chowPopulation,N)
  se=sd(hf)/sqrt(N)
  interval <- c(mean(hf)-Q*se, mean(hf)+Q*se )
  color <- ifelse(mean(chowPopulation)<= interval[2] & mean(chowPopulation)>=interval[1],1,2)
  lines( interval, c(i,i),col=color)
}


## ------------------------------------------------------------------------
plot(mean(chowPopulation)+c(-7,7),c(1,1),type="n",xlab="weight",ylab="interval",ylim=c(1,100))
abline(v=mean(chowPopulation))
Q <- qnorm(1- 0.05/2)
N<-5
for(i in 1:100){
  hf <- sample(chowPopulation,N)
  se=sd(hf)/sqrt(N)
  interval <- c(mean(hf)-Q*se, mean(hf)+Q*se )
  color <- ifelse(mean(chowPopulation)<= interval[2] & mean(chowPopulation)>=interval[1],1,2)
  lines( interval, c(i,i),col=color)
}


## ------------------------------------------------------------------------
plot(mean(chowPopulation)+c(-7,7),c(1,1),type="n",xlab="weight",ylab="interval",ylim=c(1,100))
abline(v=mean(chowPopulation))
Q <- qt(1- 0.05/2, df=4)
N<-5
for(i in 1:100){
  hf <- sample(chowPopulation,N)
  se=sd(hf)/sqrt(N)
  interval <- c(mean(hf)-Q*se, mean(hf)+Q*se )
  color <- ifelse(mean(chowPopulation)<= interval[2] & mean(chowPopulation)>=interval[1],1,2)
  lines( interval, c(i,i),col=color)
}


## ------------------------------------------------------------------------
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- tempfile()
download.file(url,destfile=filename,method="curl")
dat <- read.csv(filename)


## ------------------------------------------------------------------------
control <- dat[1:12,2]
treatment <- dat[13:24,2]
diff <- mean(treatment)-mean(control)
print(diff)


## ------------------------------------------------------------------------
t.test(treatment,control)



# biocLite("gaschYHS")
library(gaschYHS)
data(gaschYHS)
e <- gaschYHS
head(pData(e)[,c("time","status")],12)

e <- e[,1:8]
e <- e[!apply(exprs(e), 1, anyNA),]

# question 1

condition <- factor(rep(1:2,c(5,3)))
design <- model.matrix(~ condition)
library(limma)
fit <- lmFit(e, design)
fit <- eBayes(fit)
(tt <- topTable(fit, coef=2))
tt["YDR171W",]

# question 2

e = e[,1:5]
time <- pData(e)$time
design <- model.matrix(~ time + I(time^2))

fit <- lmFit(e, design)
fit <- eBayes(fit)
(tt <- topTable(fit, coef=2:3))
tt["YGR211W",]


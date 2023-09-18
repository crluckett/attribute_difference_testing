library(dplyr)
library(BradleyTerry2)


sun <- readRDS(file = "sun.rds")

#dumb model
test <- BTm(cbind(Win1,Win2), Prod1, Prod2, data = sun[[1]])
#another try
suns <- as.data.frame(cbind(sun_long$More.Spreadable,sun_long$Less.Spreadable))
names(suns) <- c("more","less")
result <- rep(1, nrow(suns))
BTmodel <- BTm(result, more, less, data = sun$sensory)


sun$rheol <- sun$rheol[,-1]
rownames(sun$rheol) <- sun$rheol[,1]
names(sun$rheol) -> c("PC1", "PC2", "PC3", "PC4")
sun.model <- BTm(result, more, less,
                     ~ PC1 + PC2 + PC3 + PC4,
                     data = sun)

test.tbl <- table(sun_long$More.Spreadable,sun_long$Less.Spreadable)

sun.bt <- rbind(aggregate(N ~ Attribute + Samples, b.cata, sum, na.rm=TRUE)
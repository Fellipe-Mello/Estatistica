library(dplyr)

setwd("DIRETORIO/SUBPASTA")
list.files()

Covar      <- read.csv("Zonal_Stats_Arapora.csv", header = T, sep = ";", dec = ".")
Ref        <- read.csv("Arapora_Predict.csv", header = T, sep = ";", dec = ".", fileEncoding="latin1")

head(Covar)
head(Ref)

colnames(Covar)
colnames(Ref)


str(Covar$KEY)
str(Ref$KEY)

names(Covar)[names(Covar) == 'Layer'] <- 'KEY'

Teste   <- merge(Ref, Covar, by.x = "KEY", all.x = TRUE)

write.csv(Teste, "DIRETORIO/SUBPASTA/Teste2.csv", row.names=TRUE)

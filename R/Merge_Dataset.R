setwd("DIRETORIO/SUBPASTA")
list.files()
Tanabi     <- read.csv("Centroids_Tanabi.csv", header = T, sep = ";", dec = ".")
Centroids   <- read.csv("Centroids.csv", header = T, sep = ";", dec = ".")
Ref        <- read.csv("Relação.csv", header = T, sep = ";", dec = ".")

head(Tanabi)
head(Centroids)
head(Ref)

colnames(Tanabi)
colnames(Centroids)
colnames(Ref)


str(Tanabi)
str(Centroids)
str(Ref)

colnames(Tanabi)    <- c("AdMapKey","LAYER","BLOCO","TALHAO","x","y")
colnames(Centroids)  <- c("AdMapKey","LAYER","KEY","BLOCO","TALHAO","x","y")
colnames(Ref)       <- c("X","Empresa","Setor","Fazenda","BLOCO","Bloco_","TALHAO")

Ref <- Ref[,c(3,4,5)]


Teste   <- merge(Centroids, Ref, by = "BLOCO")

write.csv(Teste, "DIRETORIO/SUBPASTA/Ref_Teste.csv", row.names=TRUE)

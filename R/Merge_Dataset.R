setwd("C:/Fellipe/Reginaldo/TEREOS")
list.files()
Tanabi     <- read.csv("Centroids_Tanabi.csv", header = T, sep = ";", dec = ".")
UIA_UISJ   <- read.csv("Centroids_UIA_UISJ.csv", header = T, sep = ";", dec = ".")
Ref        <- read.csv("Relação_Tereos.csv", header = T, sep = ";", dec = ".")

head(Tanabi)
head(UIA_UISJ)
head(Ref)

colnames(Tanabi)
colnames(UIA_UISJ)
colnames(Ref)


str(Tanabi)
str(UIA_UISJ)
str(Ref)

colnames(Tanabi)    <- c("AdMapKey","LAYER","BLOCO","TALHAO","x","y")
colnames(UIA_UISJ)  <- c("AdMapKey","LAYER","KEY","BLOCO","TALHAO","x","y")
colnames(Ref)       <- c("X","Empresa","Setor","Fazenda","BLOCO","Bloco_","TALHAO")

Ref <- Ref[,c(3,4,5)]


Teste   <- merge(UIA_UISJ, Ref, by = "BLOCO")

write.csv(Teste, "C:/Fellipe/Reginaldo/TEREOS/UIA_UISJ_Ref_Teste.csv", row.names=TRUE)

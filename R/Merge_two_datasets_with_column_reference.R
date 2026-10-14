# Script para unir dois datasets com base em uma coluna em comum
# Link https://www.programmingr.com/examples/r-dataframe/merge-data-frames/#:~:text=Using%20rbind()%20to%20merge%20two%20R%20data%20frames&text=This%20function%20stacks%20the%20two,and%20the%20same%20column%20names.

setwd("DIRETORIO/SUBPASTA")
list.files()
Pts_Filtrado <- read.csv("Pts_covariates_2_NH_Filtrado.csv", header = T, sep = ";")
Pts_Completo <- read.csv("covariates_sampled_buffer_60m.csv", header = T, sep = ";", dec = ",")

colnames(Pts_Completo_2)
colnames(Pts_Filtrado)
Pts_Completo_2 <- Pts_Completo[,c(1:10)]
jointdataset <- merge(Pts_Filtrado, Pts_Completo_2, by = 'FID')

str(jointdataset)

write.csv(jointdataset, file = "Pts_Filtrado_Solo.csv", row.names = FALSE)

install.packages("ggfortify")
library(ggfortify)
library(caret)
library(ggplot2)
library(tidyverse)

setwd("C:/PD_Fellipe/Artigo_4/Dados/stats")

bd <- read.csv("RJ.csv", 
               header = TRUE, 
               sep = ";")

# Renaming columns using dplyr
bd <- bd %>%
  rename(FeReact = Fe.React,
         FePyrite = Fe.Pyrite)


colnames(bd)

bd <- bd[,c(1,4:12)]

# Normalizar os dados
process <- preProcess(as.data.frame(bd), 
                      method=c("range"))

norm_scale <- predict(process, as.data.frame(bd))

# Estrutura dos dados 

# Excluir a coluna Site
numeric_data <- norm_scale[, -which(names(norm_scale) == "Area")]

# Obter PCA
pca_result <- prcomp(numeric_data, center = TRUE, scale. = TRUE)

# Plotar
autoplot(pca_result)

setwd("C:/PD_Fellipe/Artigo_4/Figuras")
tiff("biplot_PCA-RJ.tif", width = 3000, height = 3000, res = 400)    

         
         autoplot(pca_result, data = norm_scale, colour = 'Area', 
                  loadings = TRUE, 
                  loadings.colour = 'black',
                  loadings.label = TRUE, 
                  loadings.label.size = 7,
                  loadings.label.colour = "black",
                  loadings.label.vjust = 0.5,
                  loadings.label.hjust = 0.5) +
           theme_bw() +
           theme(
             legend.title = element_text(size = 22),  
             legend.text = element_text(size = 21),
             axis.title.x = element_text(size = 18), 
             axis.title.y = element_text(size = 18),  
             axis.text.x = element_text(size = 18),  
             axis.text.y = element_text(size = 18),  
           ) +
           geom_point(aes(colour = Area), size = 5) +
           geom_hline(yintercept = 0, linetype = "dashed", color = "black") + 
           geom_vline(xintercept = 0, linetype = "dashed", color = "black")
         
      
         dev.off()

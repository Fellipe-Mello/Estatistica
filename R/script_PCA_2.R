setwd("DIRETORIO/SUBPASTA")

bd2 <- read.csv("dados_pca.csv", 
               header = TRUE, 
               sep = ";")

library(caret)

# Normalizar os dados
process <- preProcess(as.data.frame(bd2), 
                      method=c("range"))

norm_scale <- predict(process, as.data.frame(bd2))

#estrutura dos dados

str(bd2)
bd2$Eh <- as.numeric(bd2$Eh)



head(norm_scale)
sum(is.na(norm_scale))

pca_result <- prcomp(norm_scale, center = TRUE, scale. = TRUE)

install.packages("ggfortify")
library(ggplot2)
library(ggfortify)

# Excluir a coluna X
numeric_data <- norm_scale[, -which(names(norm_scale) == "LULC")]

# Obter PCA
pca_result <- prcomp(numeric_data, center = TRUE, scale. = TRUE)

# Plotar
autoplot(pca_result)

colnames(bd)

setwd("DIRETORIO/SUBPASTA")
tiff("biplot_PCA.tif", width = 3000, height = 3000, res = 400)    


autoplot(pca_result, data = norm_scale, colour = "LULC", 
         loadings = FALSE, 
         loadings.colour = 'black',
         loadings.label = TRUE, 
         loadings.label.size = 5,
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
  geom_point(aes(colour = LULC), size = 3) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "black") + 
  geom_vline(xintercept = 0, linetype = "dashed", color = "black")


dev.off()


# Sem legenda no vetor

tiff("biplotPCA.tif", width = 3000, height = 2500, res = 400)  

autoplot(pca_result, data = norm_scale, colour = "LULC", 
         loadings = TRUE,  # Ativa os vetores (setinhas)
         loadings.colour = 'black',  # Define a cor das setas
         loadings.label = FALSE) +  # Remove os rótulos dos vetores (sem nomes)
  theme_bw() +
  theme(
    legend.title = element_text(size = 22),  
    legend.text = element_text(size = 21),
    axis.title.x = element_text(size = 18), 
    axis.title.y = element_text(size = 18),  
    axis.text.x = element_text(size = 18),  
    axis.text.y = element_text(size = 18)
  ) +
  geom_point(aes(colour = LULC), size = 3) +  # Mantém a legenda apenas para os pontos
  geom_hline(yintercept = 0, linetype = "dashed", color = "black") + 
  geom_vline(xintercept = 0, linetype = "dashed", color = "black") +
  guides(colour = guide_legend(),  # Mantém a legenda para as cores (LULC)
         fill = "none")  # Nenhuma legenda adicional


dev.off()

########################################################################################
# com as cores personalizadas


cores_personalizadas <- c("PRS" = "#228B22",  # Verde escuro
                          "MSF" = "#90EE99",  # Verde claro
                          "SF"  = "#5A9BD3",  # Azul médio
                          "PST" = "#D2691E")  # Laranja escuro

tiff("plot_PCA.tif", width = 3000, height = 2500, res = 400)  

autoplot(pca_result, data = norm_scale, colour = "LULC", 
         loadings = TRUE,  
         loadings.colour = 'black',  
         loadings.label = FALSE) +  
  theme_bw() +
  theme(
    legend.title = element_text(size = 22),  
    legend.text = element_text(size = 21),
    axis.title.x = element_text(size = 18), 
    axis.title.y = element_text(size = 18),  
    axis.text.x = element_text(size = 18),  
    axis.text.y = element_text(size = 18)
  ) +
  geom_point(aes(colour = LULC), size = 3) +  
  geom_hline(yintercept = 0, linetype = "dashed", color = "black") + 
  geom_vline(xintercept = 0, linetype = "dashed", color = "black") +
  guides(colour = guide_legend(),  
         fill = "none") +  
  scale_color_manual(values = cores_personalizadas, 
                     breaks = c("PRS", "MSF", "SF", "PST"))

dev.off()

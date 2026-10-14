setwd("DIRETORIO/SUBPASTA")
dados <- read.csv("RJ.csv", header = TRUE, sep = ";")

# selecionar colunas 1-12
dados <- dados[,c(4:12)]

# Renaming columns using dplyr
dados <- dados %>%
  rename(FeReact = Fe.React,
         FePyrite = Fe.Pyrite)

# padronizar 
dados_scale <- scale(dados)
dados <- as.data.frame(dados_scale)
str(dados)

# Fazer a Correlação de todos os atributos de uma vez
library(corrplot)
corrplot(dados, method="circle")

corr_matrix <- cor(dados)
M <- corr_matrix
corrplot(corr_matrix, method = "circle")


###################################################################################################
setwd("DIRETORIO/SUBPASTA/Figuras")
tiff("Matrizcorrelacao-RJ.tif", width = 3500, height = 3060, res = 400)

           # Criando uma paleta de cores e os intervalos desejados
           breaks <- seq(-1, 1, by = 0.25)  # Intervalos de 0,25
           palette <- colorRampPalette(c("#D2691E", "#5A9BD3", "#90EE90", "#228B22"))(length(breaks) - 1)
           
           # Plot da matriz de correlação
          
           corrplot(
             M, 
             method = 'number', 
             type = "lower", 
             order = "AOE",  # Escolha da ordenação
             number.cex = 1.7, 
             tl.col = "black", 
             tl.cex = 1.5,
             cl.cex = 1.5,
             col = palette,  # Paleta de cores personalizada
             cl.lim = c(-1, 1)  # Limites da legenda
           )
           
           dev.off()

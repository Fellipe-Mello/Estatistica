install.packages("ggplot2")
library(ggplot2)

setwd('DIRETORIO/SUBPASTA')

bd <- read.csv("ARQUIVO.csv", sep = ";")
is.na(bd)
str(bd)
bd$ZM         = as.character(as.integer(bd$ZM))

str(bd)

# Specify the three names you want to filter by
specific_names <- c("Silte", "Argila", "Areia")

# Use subset function to filter the dataframe based on the specific names
bd1 <- subset(bd, Textura %in% specific_names)


# grouped boxplot
tiff("Boxplot_ZM_Textura.tif", width = 700, height = 500, res = 100)
ggplot(bd1, aes(x=Textura, y=Valor, fill=ZM)) + 
  geom_boxplot() +
  labs(y = "Valor (%)", x = "Textura")+
  mynamestheme+
  ggtitle("Classes Texturais x Zonas de Manejo")
dev.off()

mynamestheme <- theme(
  plot.title = element_text(family = "Arial", face = "bold", size = (14)),
  legend.title = element_text(colour = "black", face = "bold.italic", family = "Arial"),
  legend.text = element_text(face = "italic", colour = "black", family = "Arial"),
  axis.title = element_text(family = "Arial", size = (14), colour = "black"),
  axis.text = element_text(family = "Arial", colour = "black", size = (14))
)

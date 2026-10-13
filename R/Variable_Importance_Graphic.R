# Como montar o gráfico https://www.r-graph-gallery.com/267-reorder-a-variable-in-ggplot2.html
# Como reordenar        https://sebastiansauer.github.io/ordering-bars/
# Library
install.packages("forcats")
library(forcats)
library(ggplot2)
library(dplyr)

# Definir Diretório
setwd("G:/Doutorado/Treinamento_Solos_Hidro/Treinamento_Solos_Hidro/Scripts")
list.files()

# Abrir a tabela
data <- read.csv("Variables_Importance.csv", header = TRUE, sep = ";")
str(data)
colnames(data)

#Montar a Figura
p <-ggplot(data, aes(x = reorder(Variable, -Importance), y = Importance, fill=Class)) +
    geom_bar(position = position_dodge(),stat = 'identity') +
    coord_flip() +
    xlab("") +
    theme_bw()

p1 <- p+labs(x ="Environmental Variables", y = "Variables Importance")

p2 <- p1+theme(
  plot.title = element_text(color="black", size=18),
  axis.title.x = element_text(color="black", size=18),
  axis.title.y = element_text(color="black", size=18)
)

# Exportar a Figura em alta resolução
tiff("var_imp_.tif", width = 2000, height = 2300, res = 300)
p2 + theme(axis.text.x = element_text(color="black",size=18),
           axis.text.y = element_text(color="black",size=18))
dev.off()




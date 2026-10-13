# Como montar o gr?fico https://www.r-graph-gallery.com/267-reorder-a-variable-in-ggplot2.html
# Como reordenar        https://sebastiansauer.github.io/ordering-bars/
# Library
install.packages("forcats")
library(forcats)
library(ggplot2)
library(dplyr)
library(scales)

# Definir Diret?rio C:\PD_Fellipe\Leticia
setwd("C:/PD_Fellipe/Leticia")
list.files()

# Abrir a tabela
data <- read.csv("Biomas_Count.csv", header = TRUE, sep = ";")
str(data)
colnames(data)

# Change Attribute format
data$Count <- as.numeric(as.integer(data$Count))  # Convert one variable to numeric
p1 <- ggplot(data, aes(x = reorder(State, -Count), y = Count, fill = Class)) +
  geom_bar(position = position_dodge(), stat = 'identity') +
  scale_y_break(c(5000, 25000)) +  # Axis break for y-axis
  scale_y_continuous(breaks = seq(0, 25000, by = 1000))+  # Adjust interval
  coord_flip() +
  labs(x ="State", y = "Count") +
  theme_bw() +
  theme(
    plot.title = element_text(color="black", size=18),
    axis.title.x = element_text(color="black", size=18),
    axis.title.y = element_text(color="black", size=18),
    axis.text.x = element_text(color="black",size=18, angle = 90),
    axis.text.y = element_text(color="black",size=18),
    axis.text.x.top = element_blank(),
    axis.ticks.x.top = element_blank(),
    legend.text = element_text(size=14)
  )

print(p1)


# Exportar a Figura em alta resolu??o
tiff("var_imp_states.tif", width = 3500, height = 4500, res = 400)
p1
dev.off()

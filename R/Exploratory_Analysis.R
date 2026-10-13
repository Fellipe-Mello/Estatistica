###Set working directory###
setwd("G:/Doutorado/Tabelas") # Adjusting directory
list.files()
Solo <- read.csv("Solo_Filtrado_Completo2.csv", header = T, sep = ";", dec = ",")
#########################################################################
#Mudar formato de um atributo
sapply(Solo, class) 
Solo$Sinuosidad <- as.numeric(as.character(Solo$Sinuosidad))  # Convert one variable to numeric
sapply(Solo, class)
#########################################################################
#PLOTAR UM GRÁFICO DE REGRESSÃO
colnames(Solo)
x <- Solo_PCA$Clay
y <- Solo_PCA$DD
# Plot with main and axis titles
# Change point shape (pch = 19) and remove frame.
plot(x, y, main = "Main title",
     xlab = "X axis title", ylab = "Y axis title",
     pch = 19, frame = FALSE)
# Add regression line
plot(x, y, main = "Main title",
     xlab = "X axis title", ylab = "Y axis title",
     pch = 19, frame = FALSE)
abline(lm(y ~ x, data = mtcars), col = "blue")

#########################################################################
#Plotar um gráfico de Boxplot
# Load ggplot2
library(ggplot2)
boxplot(Solo$Clay_gkg)
boxplot(Solo$OM_gkg)
boxplot(Solo$Sand_gkg)
boxplot(Solo$DD_30m)
#########################################################################
#Exportar csv
write.csv(Solo,"G:/Doutorado/Tabelas/Solo_Filtrados.csv", row.names = FALSE)


library("car")
scatterplot(Clay_gkg ~ Sinuosidad, data = Solo)
#########################################################################
# Exploratory Analysis

Solo_Exp_analy <- Solo_PCA[,c(2,4,5)]
mean(Solo_Exp_analy[,1])
median(Solo_Exp_analy[,1])
sqrt(var(Solo_Exp_analy[,1]))
sd(Solo_Exp_analy[,1])
summary(Solo_Exp_analy)

sd(Solo$OM)
summary(Solo)
count(Solo)
# calculate skewness in r
install.packages("moments")
library(moments)

skewness(Solo$OM)



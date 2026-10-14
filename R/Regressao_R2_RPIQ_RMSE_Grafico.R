setwd("DIRETORIO/SUBPASTA")
getwd()
list.files()
Clay_Val <- read.csv("validacao.csv", header = TRUE, sep = ";")
Clay_Val
summary(Clay_Val)
row.has.na <- apply(dados2, 1, function(x){any(is.na(x))}) # Verifica linhas c/ NAs
sum(row.has.na)
dados2 <- dados2[complete.cases(dados2),]


install.packages("ggpmisc")
install.packages("ggplot2")
install.packages("Metrics")
install.packages("ggpubr")
install.packages("ggpmisc")
library(Metrics)
library(ggpmisc)
library(ggplot2)
library(ggpubr)
library(ggpmisc)
require(Metrics)

#rmse(actual, predicted)

x <- Clay_Val$Argila_g_k 
y <- Clay_Val$Argila_Lit
#rmse(actual, predicted)
quantile(c(1,2,3,4,5))
# Ratio of performance to interquartile distance
# Standard error of prediction ^2
SEP2 <- mean((x -y)^2)
# Standard error of prediction
SEP <- sqrt(SEP2)
IQ <- c(quantile(x))[4] - c(quantile(y))[2]
RPIQ <- IQ / SEP


error <- rmse(x, y)
hu <- paste("RMSE=", round(rmse (x, y), 2), sep = "=")
rpiq <- paste("RPIQ=", "0.84", sep = "=" )

my.formula <- y ~ x
p1 <- ggplot(Clay_Val, aes(x, y)) +
  geom_point() + geom_smooth(method = "lm", color = "red", se=F) + theme_classic() + geom_abline(slope = 1, intercept = 0, color = "black") + 
  ylab(expression(bold(paste("Clay (g ",kg^-1,")", sep = "")))) + xlab("") +
  theme(axis.text.x=element_text(colour="black", size = 18), axis.text.y=element_text(colour="black", size = 18), axis.title.y = element_text(size = 18, face="bold")) +
  stat_poly_eq(formula = my.formula, label.x = "right", label.y = "bottom",
               aes(label = paste(..rpiq..,..hu.., ..rr.label.., sep = "~~")),
               parse = TRUE, cex= 6) + xlim(0, 600) + ylim(0, 600)

p1 
ggsave("Clay_lit.png", plot = last_plot(), width = 7, height = 5, units = "in", dpi = 300)


###############################################################################################################
####################################    SAND ##################################################################
###############################################################################################################
###############################################################################################################


Sand_Val <- read.csv("Validacao.csv", header = TRUE, sep = ";")
Sand_Val
summary(Sand_Val)
row.has.na <- apply(dados2, 1, function(x){any(is.na(x))}) # Verifica linhas c/ NAs
sum(row.has.na)
dados2 <- dados2[complete.cases(dados2),]


install.packages("ggpmisc")
install.packages("ggplot2")
install.packages("Metrics")
install.packages("ggpubr")
install.packages("ggpmisc")
library(Metrics)
library(ggpmisc)
library(ggplot2)
library(ggpubr)
library(ggpmisc)
require(Metrics)

#rmse(actual, predicted)

x <- Sand_Val$Areia_g_kg 
y <- Sand_Val$Argila_Lit
#rmse(actual, predicted)
quantile(c(1,2,3,4,5))
# Ratio of performance to interquartile distance
# Standard error of prediction ^2
SEP2 <- mean((x -y)^2)
# Standard error of prediction
SEP <- sqrt(SEP2)
IQ <- c(quantile(x))[4] - c(quantile(y))[2]
RPIQ <- IQ / SEP


error <- rmse(x, y)
hu <- paste("RMSE=", round(rmse (x, y), 2), sep = "=")
rpiq <- paste("RPIQ=", "1.15", sep = "=" )

my.formula <- y ~ x
p1 <- ggplot(Sand_Val, aes(x, y)) +
  geom_point() + geom_smooth(method = "lm", color = "red", se=F) + theme_classic() + geom_abline(slope = 1, intercept = 0, color = "black") + 
  ylab(expression(bold(paste("Sand (g ",kg^-1,")", sep = "")))) + xlab("") +
  theme(axis.text.x=element_text(colour="black", size = 18), axis.text.y=element_text(colour="black", size = 18), axis.title.y = element_text(size = 18, face="bold")) +
  stat_poly_eq(formula = my.formula, label.x = "right", label.y = "bottom",
               aes(label = paste(..rpiq..,..hu.., ..rr.label.., sep = "~~")),
               parse = TRUE, cex= 6) + xlim(0, 1000) + ylim(0, 1000)

p1 
ggsave("Sand_Lit.png", plot = last_plot(), width = 7, height = 5, units = "in", dpi = 300)




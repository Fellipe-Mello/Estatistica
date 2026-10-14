# library
library(ggplot2)


setwd("DIRETORIO/SUBPASTA")
dados <- read.csv("RJ_Boxplot.csv", header = TRUE, sep = ";")

colnames(dados)
# create a data frame
variety=rep(LETTERS[1:7], each=40)
treatment=rep(c("high","low"),each=20)
note=seq(1:280)+sample(1:150, 280, replace=T)
data=data.frame(variety, treatment ,  note)

# I reorder the groups order : I change the order of the factor data$names
dados$Area <- factor(dados$Area , levels=c("2011", "2013", "2015", "NV", "R"))

# one box per variety
p2 <- ggplot(dados, aes(x=Attribute, y=Value, fill=Area)) + 
  geom_boxplot() +
  facet_wrap(~Attribute, scale="free")


setwd("DIRETORIO/SUBPASTA/Figuras")
p2
dev.off()
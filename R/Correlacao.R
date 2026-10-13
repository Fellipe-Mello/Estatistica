install.packages("corrplot")
install.packages("GGally")
install.packages("ggcorrplot")
library(corrplot)
library(GGally)
library(ggcorrplot)

setwd("C:/Fellipe/BENRI")
bd      <- read.csv("Arapora_Pred_Zonal.csv", header = T, sep = ";", dec = ".")


colnames(bd)

bd$TCH_PREDICTION_AJUST

bd1 <- bd[,c(33,42,43,53:72)]

colnames(bd1)
str(bd1)

bd1$TCH_PREDICTION_AJUST        = as.numeric(as.integer(bd1$TCH_PREDICTION_AJUST))

colnames(bd1)       <- c("Prod","TCH_Pred","Prod_Pred","SoloB1_mean",
                         "SB1_med","SB2_mean","SB2_med","SB3_mean","SB3_med",
                         "SB4_mean","SB4_med","SB5_mean","SB5_med","SB6_mean",
                         "SB6_med","SLP_mean","SLP_med","TWI_mean","TWI_med","LSF_mean",
                         "LSF_med","RSP_mean","RSP_med")


## Retirada dos NAs 
PTS_Model_NA <- na.omit(bd1)                            # Apply na.omit in R
PTS_Model_NA                                             # Print data_omit to RStudio console
bd1 <- PTS_Model_NA


x = scale(bd1, center = TRUE, scale = TRUE)

mydata.cor = cor(x, method = c("spearman"))

setwd("C:/Fellipe/BENRI")
tiff("Correlacao.tif", width = 1000, height = 1000, res = 100) 
ggcorrplot(mydata.cor,
           hc.order = TRUE,
           type = "lower",
           lab = TRUE,
           lab_size = 3.5,
           outline.color = "white",
           ggtheme = ggplot2::theme_gray,
           colors = c("#6D9EC1", "white", "#E46726"))
dev.off()          
 
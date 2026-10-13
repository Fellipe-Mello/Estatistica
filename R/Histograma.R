# library
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(raster)

setwd('C:/Users/fellipe.alcantara/OneDrive - GATEC S A GESTAO AGROINDUSTRIAL/Fellipe_OneDriver/ASCANA')
list.files()

bd <- read.csv("Histogram.csv", sep = ";")

colnames(bd)

# Represent it
p <- bd %>%
  ggplot( aes(x=bd$P, fill=type)) +
  geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
  scale_fill_manual(values=c("#69b3a2", "#404080")) +
  theme_ipsum() +
  labs(fill="")

data <- data.frame(
  type = c( rep("variable 1", 1000), rep("variable 2", 1000) ),
  value = c( rnorm(1000), rnorm(1000, mean=4) )
)


colnames(bd_cor)

# Plot Histogram
setwd("C:/Users/fellipe.alcantara/OneDrive - GATEC S A GESTAO AGROINDUSTRIAL/Fellipe_OneDriver/ASCANA/Mapas-Apresentacao")
tiff("Hist-M-Lab.tif", width = 800, height = 600, res = 100)
par(cex.axis = 1.5)
hist(bd_cor$m, main = "M (%) Laboratório", xlab = "M (%)", ylab = "Frequência", cex.main= 2, cex.lab= 2,
     col = "grey", border = "black", breaks = seq(0, 8, by = 1), ylim = c(0, 15))
dev.off()



setwd('C:/Users/fellipe.alcantara/OneDrive - GATEC S A GESTAO AGROINDUSTRIAL/Fellipe_OneDriver/ASCANA/Pred_Maps_2')
list.files()

raster_data <- raster("M.tif")

raster_df <- as.data.frame(raster_data, xy = TRUE)
raster_df <- na.omit(raster_df)


# Plot Histogram
setwd("C:/Users/fellipe.alcantara/OneDrive - GATEC S A GESTAO AGROINDUSTRIAL/Fellipe_OneDriver/ASCANA/Mapas-Apresentacao")
tiff("Hist-M-Pred.tif", width = 800, height = 600, res = 100)
par(cex.axis = 1.5)
hist(raster_df$M, main = "M Predita", xlab = "M (%)", ylab = "Frequência", cex.main= 2, cex.lab= 2,
     col = "grey", border = "black", breaks = seq(0, 4, by = 0.2), ylim = c(0, 400))
dev.off()


"mmolc/dm³"











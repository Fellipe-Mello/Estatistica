library(dplyr)
library(sp)
library(tidyr)
library(rgdal)
library(raster)

# Abrir SYSI
setwd("C:/Fellipe/BENRI/Veget_Index/Indices/Clip_Interpolation")
list.files()
NDVI <- stack("SAVI_2019_044_Clip.tif")
NDVI[NDVI == 0] <- NA  
NDVI[NDVI < 0] <- NA 

# Mudan?a para DF com XY
b1 <- as.data.frame(NDVI, xy=TRUE)
colnames(b1)
# Renomear vari?veis
colnames(b1) <- c('x', 'y', 'b1')

b1$b1[is.na(b1$b1)] <- median(b1$b1, na.rm = TRUE)

coordinates(b1)=~x+y
proj4string(b1)=CRS("+init=epsg:4326") # set it to lat-long
pts = spTransform(b1,CRS("+init=epsg:4326 +proj=longlat +datum=WGS84"))
gridded(pts) = TRUE

r = raster(pts)
projection(r) = CRS("+init=epsg:4326 +proj=longlat +datum=WGS84")

plot(r)

setwd("C:/Fellipe/BENRI/Veget_Index/Indices/Clip_Interpolation")
writeRaster(r, "./Teste_044", format = "GTiff", datatype = "FLT4S", overwrite = T)

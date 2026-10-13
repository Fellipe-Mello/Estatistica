setwd("F:/Doutorado/Producoes/Danilo/Intemperismo/Figures")
getwd()
install.packages("fmsb")
library(fmsb)
install.packages("RColorBrewer")
library(RColorBrewer)
# Library
library(fmsb)
# Tutorial do site para entender ##############################################
# Create data: note in High school for Jonathan:
data <- as.data.frame(matrix( sample( 2:20 , 10 , replace=T) , ncol=10))
colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding", "data-viz" , "french" , "physic", "statistic", "sport" )

# Referencia      https://www.r-graph-gallery.com/143-spider-chart-with-saveral-individuals.html
#                 https://www.r-graph-gallery.com/142-basic-radar-chart.html

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
data <- rbind(rep(20,10) , rep(0,10) , data)
data
# Check your data, it has to look like this!
head(data)

# The default radar chart 
radarchart(data)

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each variable to show on the plot!
data <- rbind(rep(20,5) , rep(0,5) , data)

# Create data: note in High school for several students
set.seed(99)
data <- as.data.frame(matrix( sample( 0:20 , 15 , replace=F) , ncol=5))
colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding" )
rownames(data) <- paste("mister" , letters[1:3] , sep="-")
data


#############################################################################################
#Importar data
data2 = read.csv("Var_Imp_5.csv", header = TRUE, row.names = 1 ,sep = ";")
#Inserir na tabela uma linha com o valor mínimo e uma com o valor máximo
data2 <- rbind(rep(100,10) , rep(0,10) , data2)
colnames(data2)


# plot with default options:
radarchart(data2)#plotar o gráfico de radar
display.brewer.all()
#Definir as cores das três linhas do radar
colors_lines <- c(col=brewer.pal(n = 4, name = "RdBu"), col=brewer.pal(n = 3, name = "Spectral"),col=brewer.pal(n = 3, name = "RdBu"))

tiff("Area_A.tif", width = 2200, height = 2000, res = 300)#Salvar gráfico no disco 
#Plotar o gráfico de radar com todas as configurações
radarchart(data2  , pcol = "black", plty = 1, plwd = 2, axistype=1, cglcol="dark grey", cglty=1, axislabcol="grey", 
            caxislabels=seq(0,20,5), cglwd=0.8, vlcex=0.8)
dev.off()#Salvar gráfico no disco 


tiff("Radar_Geophysic_Relief.tif", width = 1800, height = 1500, res = 300)#Salvar gráfico no disco 
# plot with default options:
radarchart( data2  , axistype=1 , 
            #custom polygon
            pcol="firebrick" , plwd=2 , plty=1,
            #custom the grid
            cglcol="dimgray", cglty=1, axislabcol="black", caxislabels=seq(0,100,25), cglwd=1,
            #custom labels
            vlcex=1.2,calcex=1.3 
)
dev.off()#Salvar gráfico no disco 



















###########################################################################################

# Customizar o gráfico
# Library
library(fmsb)

# Create data: note in High school for several students
set.seed(99)
data <- as.data.frame(matrix( sample( 0:20 , 15 , replace=F) , ncol=5))
colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding" )
rownames(data) <- paste("mister" , letters[1:3] , sep="-")

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each variable to show on the plot!
data <- rbind(rep(20,5) , rep(0,5) , data)

# Color vector
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )

# plot with default options:
radarchart( data2  , axistype=2 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=2 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
            #custom labels
            vlcex=0.8)

# Add a legend
legend(x=1, y=1.2, legend = rownames(data2[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)



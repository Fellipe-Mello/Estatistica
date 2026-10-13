# Triangulo textural
setwd("F:/Doutorado/Producoes/Salman/Texture")
getwd()
list.files()
install.packages("soiltexture")
library(soiltexture)
Text_Tri <- read.csv("Textural_Triangle.csv", header = T, sep = ";", dec = ",")
TT.plot(class.sys = "SiBCS13.TT")

# A ordem das colunas deve ser esta abaixo:
# Teste para produzir um triangulo abaixo:
my.text <- data.frame(
  "CLAY" = c(05,60,15,05,25,05,25,45,65,75,13,47),
  "SILT" = c(05,08,15,25,55,85,65,45,15,15,17,43),
  "SAND" = c(90,32,70,70,20,10,10,10,20,10,70,10),
  "OC" = c(20,14,15,05,12,15,07,21,25,30,05,28)
)

my.text

TT.plot(
  class.sys = "SiBCS13.TT",
  tri.data = my.text,
  main = "Soil texture data"
)
##################################################################
 #################################################################
# Dados Salman
# Montando os triangulos
#Importando CSV
A_Pred = read.csv("A_Predicted.csv", header = TRUE, sep = ";")
A_Trad = read.csv("A_Traditional.csv", header = TRUE, sep = ";")
B_Pred = read.csv("B_Predicted.csv", header = TRUE, sep = ";")
B_Trad = read.csv("B_Traditional.csv", header = TRUE, sep = ";")

# Plotando os Triangulos separadamente  
TT.plot(
  class.sys = "USDA.TT",
  tri.data = Text_Tri,
  main = "Soil texture",
  col = "chocolate3", pch = 16, cex = 0.8
  )

TT.plot(
  class.sys = "USDA.TT",
  tri.data = A_Trad,
  main = "Soil texture",
  col = "#FC4E07", pch = 3, cex = 0.8
)

TT.plot(
  class.sys = "USDA.TT",
  tri.data = B_Pred,
  main = "Soil texture",
  col = "#00AFBB", pch = 16, cex = 0.8
) 

TT.plot(
  class.sys = "USDA.TT",
  tri.data = B_Trad,
  main = "Soil texture",
  col = "#00AFBB", pch = 3, cex = 0.8
) 

########################################################################################
# Plotando os triangulos e ajustando duas tabelas em um triangulo só

tiff("Text_Triangle.tif", width = 2200, height = 2000, res = 300)

TT.plot(class.sys = "USDA.TT", add = TRUE,
        tri.data = Text_Tri, col = "chocolate1", class.lab.col = "black", 
        main = "Soil texture", arrows.show = T,
        cex.axis = 1.5, cex.lab = 2, css.lab = c("Clay (%)", "Silt (%)", "Sand (%)"),
        cex = 1, lwd = 2, cex.main = 2, tri.sum.tst = FALSE) 
dev.off()

geo <- TT.plot(class.sys = "USDA.TT", add = TRUE,
        tri.data = A_Trad, col = "#00AFBB", class.lab.col = "black", 
        main = "Soil texture", arrows.show = TRUE,
        cex.axis = 1, cex.lab = 1, css.lab = c("Clay (%)", "Silt (%)", "Sand (%)"),
        cex = 1, lwd = 1, pch = 19, cex.main = 1, tri.sum.tst = FALSE)
 
 
 TT.points(tri.data = A_Pred, geo, 
           col = "#FC4E07", tri.sum.tst = FALSE, pch = 3, cex = 1,lwd = 1)
 dev.off()
 
 # Plotando os triangulos e ajustando duas tabelas em um triangulo só

tiff("Area_B.tif", width = 2200, height = 2000, res = 300) 

 
TT.plot(class.sys = "USDA.TT", add = TRUE,
        tri.data = B_Pred, col = "#FC4E07", class.lab.col = "black", 
        main = "Soil texture", arrows.show = TRUE,
        cex.axis = 1, cex.lab = 1, css.lab = c("Clay (%)", "Silt (%)", "Sand (%)"),
        cex = 1, lwd = 1, pch = 3, cex.main = 1, tri.sum.tst = FALSE)


geo <- TT.plot(class.sys = "USDA.TT", add = TRUE,
        tri.data = B_Trad, col = "#00AFBB", class.lab.col = "black", 
        main = "Soil texture", arrows.show = TRUE,
        cex.axis = 1, cex.lab = 1, css.lab = c("Clay (%)", "Silt (%)", "Sand (%)"),
        cex = 2, lwd = 3, pch = 1, cex.main = 1, tri.sum.tst = FALSE)


TT.points(tri.data = B_Pred, geo, 
          col = "#FC4E07", tri.sum.tst = FALSE, pch = 3, cex = 1, lwd = 1)

dev.off()








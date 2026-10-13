# Boxplot Múltiplo 

# Dados com 3 colunas: LULC, Attribute e Value

setwd("C:/PD_Fellipe/Artigo_4/Dados/stats")

bd <- read.csv("RJ_Boxplot.csv", 
               header = TRUE, 
               sep = ";")

# LULC como character, Attribute como character e Value como numeric
str(bd)

# One box per treatment// cores personalizadas para artigo Nature Communications
cores_personalizadas <- c("PRS" = "#228B22",  # Verde escuro
                          "MSF" = "#90EE99",  # Verde claro
                          "SF"  = "#5A9BD3",  # Azul médio
                          "PST" = "#D2691E")  # Laranja escuro
bd$LULC <- factor(bd$LULC, levels = c("PRS", "MSF", "SF", "PST"))

cores_personalizadas2 <- c("HTF" = "#D2691E",  # Verde escuro
                          "RM" = "#90EE99",  # Verde claro
                          "MM"  = "#228B22") # Laranja escuro

cores_personalizadas3 <- c("2011" = "#228B22",  # Verde escuro
                          "2013" = "#90EE99",  # Verde claro
                          "2015"  = "#00FA9A",  # Azul médio
                          "NV" = "#D2691E",  # Azul médio
                          "R" = "#006400")  # Laranja escuro
bd$Area <- factor(bd$Area, levels = c("2011", "2013", "2015", "NV", "R"))

setwd("C:/PD_Fellipe/Artigo_4/Figuras")
tiff("Boxplot-RJ.tif", width = 4000, height = 2000, res = 400)

ggplot(bd, aes(x=Attribute, y=Value, fill=Area)) + 
  geom_boxplot() +
  facet_wrap(~Attribute, scales = "free", ncol = 4) +  # Corrigido "scale" para "scales"
  theme_minimal() +
  theme(
    text = element_text(size = 14, color = "black"),  
    axis.title = element_text(size = 16, color = "black"),  
    axis.text = element_text(size = 14, color = "black"),  
    strip.text = element_text(size = 14, color = "black"),
    panel.background = element_rect(fill = NA, color = "black"),
    axis.text.x = element_blank(),  # Remove os rótulos do eixo X
    axis.ticks.x = element_blank()   # Remove as marcações do eixo X
  ) +
  scale_fill_manual(values = cores_personalizadas3, 
                    breaks = c("2011", "2013", "2015", "NV", "R"))  # Aplica a paleta e define a ordem

dev.off()



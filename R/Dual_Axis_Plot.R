library(ggplot2)
library(ggthemes)
library(scales)

setwd("DIRETORIO/SUBPASTA")
list.files()

bd <- read.csv("Mangue-Camarao-PA.csv", header = TRUE, sep=";")
str(bd)
summary(bd)
bd$Year <- as.character(as.integer(bd$Year))
bd$Production <- as.numeric(as.integer(bd$Production))

bd$Mangrove <- bd$Mangrove / 1000
bd$Production <- bd$Production / 1000

# Creating the plot
p1<-ggplot(bd, aes(x = Year, group = 1)) +
  # Bar plot for Shrimp Production
  geom_bar(aes(y = Production), stat = "identity", fill = "#5A9BD3", alpha = 0.7) +
  # Line plot for Mangrove area
  geom_line(aes(y = (Mangrove - 220) / (240 - 220) * (155 - 35) + 35), color = "#228B22", size = 1.5) +
  geom_point(aes(y = (Mangrove - 220) / (240 - 220) * (155 - 35) + 35), color="black", fill="#228B22", size=3, shape=21, stroke=1) +
  
  # Labels and titles
  labs(title = "Shrimp Production in Pará State") +
  
  # Formatting the theme
  theme_economist(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 20, face = "bold"),
    axis.text.x = element_text(color="black",size=16, face = "bold", margin = margin(t = 3, r = 20, b = 5, l = 0)),
    axis.text.y = element_text(color="black",size=20, face = "bold"),
    axis.title.y = element_text(color="#5A9BD3",size=20, face = "bold", margin = margin(t = 0, r = 20, b = 0, l = 0)),
    axis.title.x = element_text(color="black",size=20, face = "bold"),
    panel.background = element_rect(fill = "#f0f0f0"),
    plot.background = element_rect(fill = "#f0f0f0"),
    axis.title.y.right = element_text(color = "#228B22")
  ) +
  
  # Left Y-axis
  scale_y_continuous(
    name = "Shrimp Production (10³ kg)",
    sec.axis = sec_axis(~ ((. - 35) * (240 - 220) / (155 - 35) + 220), name = "Mangrove Area (10³ ha)")
  ) +
  
  # X-axis label
  xlab("Year")


setwd("DIRETORIO/SUBPASTA/Figuras")
tiff("Mangrove-Shrimp.tif", width = 3500, height = 2000, res = 400)
p1
dev.off()
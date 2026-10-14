library(dplyr)
library(ggplot2)

# Setwd
setwd("DIRETORIO/SUBPASTA")
list.files()

# Load your dataset
df <- read.csv("RJ_SHI.csv", sep = ";")   # adjust path if needed

# Summarise SHI per Land Use (ignore depth)
sumdf <- df %>%
  group_by(Land.Use) %>%
  summarise(
    mean = mean(SHI, na.rm = TRUE),
    sd   = sd(SHI, na.rm = TRUE),
    n    = n(),
    se   = sd / sqrt(n),
    .groups = "drop"
  )

# Set Land Use factor to control order (top to bottom)
sumdf$Land.Use <- factor(sumdf$Land.Use, levels = c("R","2015","2013","2011","NV"))

# Custom color palette
Color_Palette <- c("2011" = "#228B22",
                   "2013" = "#90EE99",
                   "2015" = "#00FA9A",
                   "NV"   = "#D2691E",
                   "R"    = "#006400")



setwd("DIRETORIO/SUBPASTA/Figuras")
tiff("SHI-RJ.tif", width = 2000, height = 2000, res = 400)
# Horizontal bar plot
ggplot(sumdf, aes(x = mean, y = Land.Use, fill = Land.Use)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_errorbar(aes(xmin = mean - se, xmax = mean + se), color = "black") +
  scale_fill_manual(values = Color_Palette) +
  labs(x = "Soil Health Index (SHI)", y = "Restoration Stage",
       title = "Mean SHI per Land Use (± SE)") +
  theme_minimal(base_size = 14) +
  theme(
    text = element_text(size = 12, color = "black"),
    axis.title = element_text(size = 14, color = "black"),  
    axis.text = element_text(size = 12, color = "black"),  
    legend.position = "none")
dev.off()
# ============================================================
# PUBLICATIONS BY YEAR AND COUNTRY
# ============================================================

# Packages
library(dplyr)
library(ggplot2)
library(tidyr)
library(ggbreak)

# ------------------------------------------------------------
# 1. LOAD YOUR DATA
# ------------------------------------------------------------

# Your data should have two columns:
#   Country = country name
#   Year    = publication year
#

setwd("C:/Fellipe/Artigos/Artigo_6/Dados")
data <- read.csv("Country_Year.csv", header = TRUE, sep = ";")

# ------------------------------------------------------------
# 2. CLEAN THE DATA
# ------------------------------------------------------------
data <- data %>%
  mutate(
    Country = as.character(Country),
    Year = as.numeric(Year)
  ) %>%
  filter(
    !is.na(Country),
    !is.na(Year)
  )


# ------------------------------------------------------------
# 3. IDENTIFY THE 10 MOST PRODUCTIVE COUNTRIES
# ------------------------------------------------------------

top10 <- data %>%
  count(Country, sort = TRUE) %>%
  slice_head(n = 10) %>%
  pull(Country)


# ------------------------------------------------------------
# 4. CREATE COUNTRY GROUPS
# ------------------------------------------------------------

data_plot <- data %>%
  mutate(
    Country_group = ifelse(
      Country %in% top10,
      Country,
      "Other"
    )
  )


# ------------------------------------------------------------
# 5. COUNT ARTICLES BY YEAR AND COUNTRY
# ------------------------------------------------------------

plot_data <- data_plot %>%
  count(Year, Country_group)


# ------------------------------------------------------------
# 6. CREATE A COMPLETE YEAR SEQUENCE
# ------------------------------------------------------------

all_years <- seq(
  min(data_plot$Year),
  max(data_plot$Year)
)

plot_data <- plot_data %>%
  complete(
    Year = all_years,
    Country_group = c(top10, "Other"),
    fill = list(n = 0)
  )


# ------------------------------------------------------------
# 7. ORDER COUNTRIES
# ------------------------------------------------------------

country_order <- data_plot %>%
  count(Country_group, sort = TRUE) %>%
  filter(Country_group != "Other") %>%
  pull(Country_group)

plot_data <- plot_data %>%
  mutate(
    Country_group = factor(
      Country_group,
      levels = c(country_order, "Other")
    )
  )


# ------------------------------------------------------------
# 8. COLOR PALETTE
# ------------------------------------------------------------

# EDIT THESE COLORS AS YOU WISH

country_colors <- c(
  "#1B9E77",
  "#D95F02",
  "#7570B3",
  "#E7298A",
  "#66A61E",
  "#E6AB02",
  "#A6761D",
  "#666666",
  "#1F78B4",
  "#B2DF8A"
)

names(country_colors) <- country_order

country_colors <- c(
  country_colors,
  "Other" = "gray70"
)


# ------------------------------------------------------------
# 9. LABEL SIZE OPTIONS
# ------------------------------------------------------------

axis_text_size     <- 14
axis_title_size    <- 16
legend_text_size   <- 14
legend_title_size  <- 16
title_size         <- 16


# ------------------------------------------------------------
# 10. DEFINE THE PERIODS TO COMPRESS
# ------------------------------------------------------------

# These are the periods you want to visually compress:

excluded_years <- c(
  1956:1970,
  1973,
  1975,
  1978:1986,
  1989,
  1993:1995
)


# ------------------------------------------------------------
# 11. CREATE COMPRESSED X-AXIS POSITIONS
# ------------------------------------------------------------

# compression_factor controls how much the excluded periods
# are compressed.
#
# 0.00 = completely compressed
# 0.05 = very strongly compressed
# 0.10 = strongly compressed
# 0.20 = moderately compressed
#
# I recommend starting with 0.05.

compression_factor <- 0.05


# Start with the first year at position 1
plot_data <- plot_data %>%
  arrange(Year) %>%
  mutate(
    year_difference = Year - min(all_years)
  )


# Create the new x-axis position
#
# Normal years:
#     normal spacing
#
# Excluded periods:
#     reduced spacing

plot_data <- plot_data %>%
  mutate(
    Year_plot = min(all_years) +
      sapply(
        year_difference,
        function(x) {
          
          if (x == 0) {
            return(0)
          }
          
          # Count how many year intervals are compressed
          compressed_intervals <- sum(
            (min(all_years):(min(all_years) + x - 1)) %in%
              excluded_years
          )
          
          # Normal intervals
          normal_intervals <- x - compressed_intervals
          
          # New compressed position
          return(
            normal_intervals +
              compressed_intervals * compression_factor
          )
        }
      )
  )


# ------------------------------------------------------------
# 12. CREATE X-AXIS LABEL POSITIONS
# ------------------------------------------------------------

# We only show labels for years outside the compressed periods.

years_to_show <- all_years[
  !all_years %in% excluded_years
]


# Calculate the corresponding positions for the labels

axis_positions <- plot_data %>%
  filter(
    Year %in% years_to_show,
    Country_group == country_order[1]
  ) %>%
  select(
    Year,
    Year_plot
  ) %>%
  distinct()


# ------------------------------------------------------------
# 13. CREATE THE GRAPH
# ------------------------------------------------------------

plot <- 
  ggplot(
  plot_data,
  aes(
    x = Year_plot,
    y = n,
    fill = Country_group
  )
) +
  
  geom_bar(stat = "identity", width = 0.8) +
  
  scale_fill_manual(
    values = country_colors,
    name = "Country"
  ) +
  
  # ----------------------------------------------------------
# X AXIS
# ----------------------------------------------------------

scale_x_continuous(
  breaks = axis_positions$Year_plot,
  labels = axis_positions$Year
) +
  
  # ----------------------------------------------------------
# LABELS
# ----------------------------------------------------------

labs(
  x = "Year",
  y = "Number of publications",
  title = "Scientific publications by year and country"
) +
  
  # ----------------------------------------------------------
# THEME
# ----------------------------------------------------------

theme_classic() +
  
  theme(
    axis.text.x =  element_text(size = axis_text_size, angle = 45, hjust = 1),
    axis.text.y =  element_text(size = axis_text_size),
    axis.title.x = element_text(size = axis_title_size),
    axis.title.y = element_text(size = axis_title_size),
    legend.text =  element_text(size = legend_text_size),
    legend.title = element_text(size = legend_title_size),
    plot.title =   element_text(size = title_size, face = "bold")
    )


# Exportar em Vetor
install.packages("devEMF")
library(devEMF)

setwd("C:/Fellipe/Artigos/Artigo_6/Figuras")
emf("Teste.emf",
    width = 12,   # inches
    height = 6,
    bg = "white")

print(plot)

dev.off()






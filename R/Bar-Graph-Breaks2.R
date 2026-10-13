# ------------------------------------------------------------
# 3. CLEAN DATA
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
# 4. DETERMINE FIRST YEAR
# ------------------------------------------------------------

first_year <- min(data$Year)

print(paste("First year in dataset:", first_year))


# ------------------------------------------------------------
# 5. IDENTIFY THE 10 MOST PRODUCTIVE COUNTRIES
# ------------------------------------------------------------

top10 <- data %>%
  count(Country, sort = TRUE) %>%
  slice_head(n = 10) %>%
  pull(Country)


# Check the 10 countries
print(top10)


# ------------------------------------------------------------
# 6. CREATE COUNTRY GROUPS
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
# 7. CREATE THE HISTORICAL PERIOD
# ------------------------------------------------------------

# All publications from the first year through 1999
# are grouped together.

historical_data <- data_plot %>%
  filter(
    Year <= 1999
  ) %>%
  summarise(
    n = n()
  ) %>%
  mutate(
    Period = paste0(
      first_year,
      "-1999"
    ),
    Country_group = "Historical"
  )


# ------------------------------------------------------------
# 8. CREATE ANNUAL DATA FROM 2000 ONWARD
# ------------------------------------------------------------

annual_data <- data_plot %>%
  filter(
    Year >= 2000
  ) %>%
  count(
    Year,
    Country_group
  )


# ------------------------------------------------------------
# 9. CREATE COMPLETE YEARS FROM 2000 ONWARD
# ------------------------------------------------------------

if (any(data$Year >= 2000)) {
  
  years_after_1999 <- seq(
    2000,
    max(data$Year)
  )
  
  annual_data <- annual_data %>%
    complete(
      Year = years_after_1999,
      Country_group = c(top10, "Other"),
      fill = list(n = 0)
    )
  
}


# ------------------------------------------------------------
# 10. CREATE THE HISTORICAL BAR DATA
# ------------------------------------------------------------

historical_plot <- historical_data %>%
  mutate(
    x = 1999
  ) %>%
  select(
    x,
    n,
    Country_group
  )


# ------------------------------------------------------------
# 11. CREATE THE ANNUAL BAR DATA
# ------------------------------------------------------------

annual_plot <- annual_data %>%
  mutate(
    x = Year
  ) %>%
  select(
    x,
    n,
    Country_group
  )


# ------------------------------------------------------------
# 12. COMBINE HISTORICAL + ANNUAL DATA
# ------------------------------------------------------------

# The historical bar uses "Historical"
# while annual bars use the 10 countries + Other.

plot_data <- bind_rows(
  historical_plot,
  annual_plot
)


# ------------------------------------------------------------
# 13. DEFINE COUNTRY ORDER
# ------------------------------------------------------------

country_order <- data_plot %>%
  count(
    Country_group,
    sort = TRUE
  ) %>%
  filter(
    Country_group != "Other"
  ) %>%
  pull(
    Country_group
  )


# ------------------------------------------------------------
# 14. DEFINE COLORS
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


# Assign colors to the 10 countries

names(country_colors) <- country_order


# Other countries = gray

country_colors <- c(
  country_colors,
  "Other" = "gray70",
  "Historical" = "gray50"
)


# ------------------------------------------------------------
# 15. DEFINE FACTOR ORDER
# ------------------------------------------------------------

plot_data <- plot_data %>%
  mutate(
    
    Country_group = factor(
      Country_group,
      levels = c(
        "Historical",
        country_order,
        "Other"
      )
    )
    
  )


# ------------------------------------------------------------
# 16. LABEL SIZE OPTIONS
# ------------------------------------------------------------

axis_text_size     <- 16
axis_title_size    <- 18
legend_text_size   <- 16
legend_title_size  <- 18
title_size         <- 16


# ------------------------------------------------------------
# 17. CREATE X-AXIS LABELS
# ------------------------------------------------------------

# Historical bar is positioned at 1999
# but labelled with the complete period.

x_breaks <- c(
  1999,
  seq(
    2000,
    max(data$Year),
    by = 1
  )
)

x_labels <- c(
  paste0(
    first_year,
    "-1999"
  ),
  seq(
    2000,
    max(data$Year),
    by = 1
  )
)


# ------------------------------------------------------------
# 18. CREATE GRAPH
# ------------------------------------------------------------

plot2 <- ggplot(
  plot_data,
  aes(
    x = x,
    y = n,
    fill = Country_group
  )
) +
  
  geom_bar(
    stat = "identity",
    width = 0.8
  ) +
  
  scale_fill_manual(
    values = country_colors,
    name = "Country"
  ) +
  
  scale_x_continuous(
    breaks = x_breaks,
    labels = x_labels
  ) +
  
  labs(
    x = "Year",
    y = "Number of publications",
    
  ) +
  
  theme_classic() +
  
  theme(
    
    axis.text.x = element_text(
      size = axis_text_size,
      angle = 45,
      hjust = 1
    ),
    
    axis.text.y = element_text(
      size = axis_text_size
    ),
    
    axis.title.x = element_text(
      size = axis_title_size
    ),
    
    axis.title.y = element_text(
      size = axis_title_size
    ),
    
    legend.text = element_text(
      size = legend_text_size
    ),
    
    legend.title = element_text(
      size = legend_title_size
    ),
    
    plot.title = element_text(
      size = title_size,
      face = "bold"
    )
  )




# Exportar em Vetor
install.packages("devEMF")
library(devEMF)

setwd("DIRETORIO/SUBPASTA")
emf("Teste2.emf",
    width = 12,   # inches
    height = 4,
    bg = "white")

print(plot2)

dev.off()

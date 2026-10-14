# ============================
# PCA
# ============================

# Load your data
data <- read.csv("DIRETORIO/SUBPASTA/PCA.csv", header = TRUE, sep = ";")
data
colnames(data)
# Select numeric variables for PCA
pca_data <- data[, c("Zn","Cu","Pb","N","pH","eH","C","Sand","SC")]

# Run PCA
pca <- prcomp(pca_data,
              scale. = TRUE,
              center = TRUE)

# ============================
# 1. Eigenvalues
# ============================

eigenvalues <- pca$sdev^2

eigenvalues


# ============================
# 2. Variance explained
# ============================

variance <- eigenvalues / sum(eigenvalues) * 100

variance


# ============================
# 3. Cumulative variance
# ============================

cumulative_variance <- cumsum(variance)

cumulative_variance


# ============================
# 4. Eigenvectors
# ============================

eigenvectors <- pca$rotation

eigenvectors


# ============================
# 5. Communalities
# ============================

communalities <- rowSums(eigenvectors^2)

communalities


# ============================
# Create a summary table
# ============================

PCA_summary <- data.frame(
  PC = paste0("PC", 1:length(eigenvalues)),
  Eigenvalue = eigenvalues,
  Variance = variance,
  Cumulative_Variance = cumulative_variance
)

PCA_summary

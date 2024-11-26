#'@name unit02_sample_presence_absence_points.R
#'@date 21.11.2024
#'@author Lisa Bald [bald@staff.uni-marburg.de]
#'@description sample presence absence points from the virtual species
#'@misc: https://borisleroy.com/virtualspecies_tutorial/


# 1 - install and load packages  ####
#-----------------------------------#

# Define the required packages for the script
list.of.packages <- c("terra", "sf", "virtualspecies", "blockCV", "predicts")

# Loop to check if packages are installed, and install any that are missing
for (pkg in list.of.packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) { # Check if the package is not installed
    install.packages(pkg, dependencies = TRUE) # Install the package with dependencies
  }
  library(pkg, character.only = TRUE) # Load the package
}
rm(list.of.packages,pkg)


# 2 - sample occurance points #####
#---------------------------------#
# Set a random seed for reproducibility in sampling
set.seed(21112024)

# Read the virtual species object from a pre-saved RDS file
species1 = readRDS("data/virtualSpecies/species1.RDS")

# Extract the second element, which contains the presence-absence raster
pa = species1[[2]]

# Sample 300 presence-absence points with 50% prevalence
poPoints <- sampleOccurrences(
  pa,
  n = 300, # Number of points to sample
  type = "presence-absence", # Sampling type
  sample.prevalence = 0.5 # Prevalence rate
)



# 3 - restricting the sampling area ####
#---------------------------------------#

# Create background points from the presence-absence raster
p = sf::st_as_sf(
  x = as.data.frame(predicts::backgroundSample(pa$pa.raster, n = 300)), # Create 300 background points
  coords = c("x", "y"), # Coordinate columns
  crs = sf::st_crs("epsg:32633") # Set the CRS
)

# Generate spatial blocks using squares
blocks = blockCV::cv_spatial(
  r = pa$pa.raster, # Presence-absence raster
  hexagon = F, # Use square blocks
  x = p # Background points
)

# Generate spatial blocks using bars
blocks = blockCV::cv_spatial(
  r = pa$pa.raster, # Presence-absence raster
  rows_cols = c(5, 0), # Divide into 5 horizontal rows
  hexagon = F, # Use rows
  x = p # Background points
)

# Generate spatial blocks using hexagons
blocks = blockCV::cv_spatial(
  r = pa$pa.raster, # Presence-absence raster
  size = 100, # Hexagon size 
  hexagon = T, # Use hexagons
  x = p # Background points
)

# Filter the sampling area to only include folds 1 and 2
samplingArea = blocks$blocks %>% dplyr::filter(folds %in% c(1, 2))

# Sample 300 presence-absence points from the restricted sampling area
poPoints <- sampleOccurrences(
  pa,
  sampling.area = samplingArea, # Restrict sampling to specific area
  n = 300, # Number of points to sample
  type = "presence-absence", # Sampling type
  sample.prevalence = 0.5 # Prevalence rate
)




# 4 - sampling bias ####
#----------------------#












points= sampleOccurrences(
  pa$pa.raster,
  30,
  type = "presence only",
  extract.probability = FALSE,
  sampling.area = NULL,
  detection.probability = 1,
  correct.by.suitability = FALSE,
  error.probability = 0,
  bias = "no.bias",
  bias.strength = 50,
  bias.area = NULL,
  weights = NULL,
  sample.prevalence = NULL,
  replacement = FALSE,
  plot = TRUE
)




# create sampling bias with block cv package












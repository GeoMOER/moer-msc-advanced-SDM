#' @name nlm.R
#' @date 01.11.2024
#' @author Lisa Bald [bald@staff.uni-marburg.de]
#' @description Create a random polygon inside your raster to use as a border.

set.seed(1112024)
# Define packages
list.of.packages <- c("terra", "predicts", "sf", "NLMR")

# Check and install missing packages
for (pkg in list.of.packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    # Install remotes package if necessary
    if (!requireNamespace("remotes", quietly = TRUE)) {
      install.packages("remotes")
    }
    if (pkg == "NLMR") {
      remotes::install_github("ropensci/NLMR")
    }
  }
}

# Load the packages
lapply(list.of.packages, library, character.only = TRUE)

# Step 1: Create a distance gradient raster (here you load your .tif file with all environmental variables instead)
NLM1 <- terra::rast(NLMR::nlm_distancegradient(ncol = 497, nrow = 497, origin = c(20, 200, 10, 15)))
terra::crs(NLM1) <- "EPSG:32633"  # Assign a CRS

# Step 2: Get original extent
original_extent <- ext(NLM1)
print(original_extent)  # Print the original extent

# Define shrinkage amount
shrink_amount <- 50  # Adjust this value as needed

# Calculate new extent
new_extent <- ext(
  xmin(original_extent) + shrink_amount,  # Shrink left
  xmax(original_extent) - shrink_amount,  # Shrink right
  ymin(original_extent) + shrink_amount,  # Shrink bottom
  ymax(original_extent) - shrink_amount   # Shrink top
)

# Step 3: Crop the raster to the new extent
cropped_raster <- crop(NLM1, new_extent)

# Step 4: Create random points throughout the raster
points <- as.data.frame(predicts::backgroundSample(mask = cropped_raster, n = 52))
points <- sf::st_as_sf(points, coords = c("y", "x"), crs = sf::st_crs("EPSG:32633"))
points <- sf::st_buffer(points, 62)

# Step 5: Create one polygon
x <- sf::st_union(points)
plot(x)

# Step 7: Mask the raster with the polygon
r <- terra::mask(NLM1, terra::vect(x))
terra::plot(r)

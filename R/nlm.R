#'@name nlm.R
#'@date 13.09.2024
#'@author Lisa Bald [bald@staff.uni-marburg.de]
#'@description generate neutral landscape models (NLMs), simulated landscapes 
#'@misc: https://docs.ropensci.org/NLMR/articles/getstarted.html


# 1 - install packages  ####
#-------------------------#

# Define packages
list.of.packages <- c("RandomFieldsUtils", "RandomFields", "NLMR", "landscapetools")

# Check and install missing packages
for (pkg in list.of.packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    # Install remotes package if necessary
    if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
    
    # Install package based on source
    if (pkg %in% c("RandomFieldsUtils", "RandomFields")) {
      remotes::install_github(paste("cran", pkg, sep = "/"))
    } else if (pkg %in% c("NLMR", "landscapetools")) {
      remotes::install_github(paste("ropensci", pkg, sep = "/"))
    }
  }
}

# Load the packages
lapply(list.of.packages, library, character.only = TRUE)

# 1 - create 6 NLMs  ####
#-----------------------#


# distance gradient
NLM1 <- terra::rast(NLMR::nlm_distancegradient(ncol = 497, nrow = 497,
                                origin = c(20, 200, 10, 15)))

#spatially correlated random fields (Gaussian random fields)
NLM2 <- terra::rast(NLMR::nlm_gaussianfield(ncol = 497, nrow = 497,
                             autocorr_range = 60,
                             mag_var = 8,
                             nug = 5))

# midpoint displacement
NLM3 <- terra::rast(NLMR::nlm_mpd(ncol = 499,
                   nrow = 499,
                   roughness = 0.5))


# Simulates a midpoint displacement neutral landscape model.
NLM4 <- terra::rast(NLMR::nlm_mpd(ncol = 499, nrow = 499,roughness = 0.5))

# now we will create a raster from several NLMs
# Merging landscapes: see https://ropensci.github.io/NLMR/articles/getstarted.html#merging-landscapes


NLM5.1 <- terra::rast(NLMR::nlm_edgegradient(ncol = 497,
                             nrow = 497,
                             direction = 68))

# merge the raster with:
NLM5.2 <- terra::rast(NLMR::nlm_gaussianfield(ncol = 497,
                                  nrow = 497,
                                  autocorr_range = 120))

NLM5.3 <- terra::rast(NLMR::nlm_random(ncol = 497,
                        nrow = 497))

NLM5 <- NLM5.1 + (NLM5.2+NLM5.3);rm(NLM5.1, NLM5.2, NLM5.3)

# lastly we will include one categorical raster for this we will use a function from the package landscapetools


NLM6.1 <- NLMR::nlm_mpd(499, 499, roughness = 0.6 # Controls the level of spatial autocorrelation 
                          )

NLM6 <- terra::rast(landscapetools::util_classify(NLM6.1, weighting = c(0.5, 0.25, 0.25)));rm(NLM6.1)

# save all your NLMs in one raster stack
r=terra::rast(list(NLM1, NLM2, NLM3, NLM4, NLM5, NLM6))
terra::crs(r) <- "EPSG:32633" # assign a crs

terra::writeRaster(r, "C:/DATA/Lehre/moer-msc-advanced-SDM/data/NLMs.tif", 
                   overwrite = TRUE, filetype = "GTiff", datatype = "FLT4S")



######################################################################################
r=terra::rast("C:/DATA/Lehre/moer-msc-advanced-SDM/data/NLMs.tif")
names(r)<- c("NLM1", "NLM2", "NLM3", "NLM4", "NLM5", "NLM6")
NLM5=landscapetools::util_rescale(raster::raster(r$NLM5))
r=terra::rast(list(terra::subset(r, c("NLM1", "NLM2", "NLM3", "NLM4")), terra::rast(NLM5)))
terra::plot(r)

library(tidyterra)
library(ggplot2)

ggplot() +
  geom_spatraster(data = r) +
  facet_wrap(~lyr)+
  # facet_wrap(~lyr, ncol = 4) +
  scale_fill_whitebox_c(
    palette = "viridi",
    #limits=c(0,1),
  #  labels = scales::label_number(suffix = ""),
    n.breaks = 10,
    guide = guide_legend(reverse = TRUE)
  )
 

################################################



# ADDITIONAL LEARNING MATERIAL COR




#############################################

# Define packages
list.of.packages <- c("terra", "corrplot")

# Check and install missing packages
for (pkg in list.of.packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    # Install the package if not already installed
    install.packages(pkg, dependencies = TRUE)
  }
  # Load the package
  library(pkg, character.only = TRUE)
}

# Load the packages
lapply(list.of.packages, library, character.only = TRUE)

# Load required libraries
library(terra)
library(corrplot)

r=terra::rast("C:/DATA/Lehre/moer-msc-advanced-SDM/data/NLMs.tif")
names(r)<- c("NLM1", "NLM2", "NLM3", "NLM4", "NLM5", "NLM6")
correlation=terra::layerCor(r, fun="cor")
correlation=correlation$correlation

# plot correlation
corrplot::corrplot(correlation, method="circle",
                   addCoef.col = 'black',
                   type = c("full"),
                   diag = FALSE)



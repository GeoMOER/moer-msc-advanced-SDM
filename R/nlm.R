#'@name nlm.R
#'@date 13.09.2024
#'@author Lisa Bald [bald@staff.uni-marburg.de]
#'@description generate neutral landscape models (NLMs), simulated landscapes 
#'@misc: https://docs.ropensci.org/NLMR/articles/getstarted.html


# 1 - install packages  ####
#-------------------------#

# Define packages
list.of.packages <- c("RandomFieldsUtils", "RandomFields", "NLMR")

# Check and install missing packages
for (pkg in list.of.packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    # Install remotes package if necessary
    if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
    
    # Install package based on source
    if (pkg %in% c("RandomFieldsUtils", "RandomFields")) {
      remotes::install_github(paste("cran", pkg, sep = "/"))
    } else if (pkg == "NLMR") {
      remotes::install_github("ropensci/NLMR")
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
terra::plot(NLM1)


#spatially correlated random fields (Gaussian random fields)
NLM2 <- terra::rast(NLMR::nlm_gaussianfield(ncol = 497, nrow = 497,
                             autocorr_range = 80,
                             mag_var = 8,
                             nug = 5))
terra::plot(NLM2)

# midpoint displacement
NLM3 <- terra::rast(NLMR::nlm_mpd(ncol = 499,
                   nrow = 499,
                   roughness = 0.5))
terra::plot(NLM3)

#Simulates a random curd neutral landscape model with optional wheys.
x <- NLMR::nlm_curds(curds = c(0.5, 0.3, 0.6),
                     recursion_steps = c(32, 6, 2))
raster::plot(x)


x=terra::rast(c(NLM2, NLM1, NLM3))








#1.  First, the species' suitable habitat or niche is defined as a function of environmental variables

#2. This habitat suitability function is then projected into geographic space and converted to the required 
#response (such as occurrence, abundance or occupancy).

#3. The response is then sampled and used to calibrate SDMs, which can then be tested against the known species distribution.

x <- NLMR::nlm_random(20,400)
raster::plot(x)

#Simulates a random curd neutral landscape model with optional wheys.
x <- NLMR::nlm_curds(curds = c(0.5, 0.3, 0.6),
                     recursion_steps = c(32, 6, 2))
raster::plot(x)

# distance gradient
x <- NLMR::nlm_distancegradient(ncol = 499, nrow = 499,
                                origin = c(20, 200, 10, 15))
raster::plot(x)

# edge gradient
x <- NLMR::nlm_edgegradient(ncol = 100, nrow = 100, direction = 80)
raster::plot(x)

# two-dimensional fractional Brownian motion
x <- NLMR::nlm_fbm(ncol = 30, nrow = 30, fract_dim = 0.8)
raster::plot(x)

#spatially correlated random fields (Gaussian random fields)
x <- NLMR::nlm_gaussianfield(ncol = 90, nrow = 90,
                             autocorr_range = 60,
                             mag_var = 8,
                             nug = 5)
raster::plot(x)

#random mosaic fields
x <- NLMR::nlm_mosaicfield(ncol = 499,
                           nrow = 499,
                           n = NA,
                           infinit = TRUE,
                           collect = FALSE)
raster::plot(x)


#?????????
x <- NLMR::nlm_mosaicgibbs(ncol = 499,
                           nrow = 499,
                           germs = 100,
                           R = 0.02,
                           patch_classes = 120)
raster::plot(x)

# midpoint displacement
x <- NLMR::nlm_mpd(ncol = 100,
                   nrow = 100,
                   roughness = 0.5)
raster::plot(x)




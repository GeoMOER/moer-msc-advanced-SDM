#'@name virtual_species.R
#'@date 04.11.2024
#'@author Lisa Bald [bald@staff.uni-marburg.de]
#'@description create virtual species based on NLMs 
#'@misc: https://borisleroy.com/virtualspecies_tutorial/


# 1 - install and load packages  ####
#-----------------------------------#

# Define packages
list.of.packages <- c("terra", "sf", "predicts", "virtualspecies")

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


# 2 - load the NLMs we prepared before ####
#-----------------------------------------#

r=terra::rast("C:/DATA/Lehre/moer-msc-advanced-SDM/data/NLMs.tif")
# have a look at your rasters  
plot(r)  

# 3 - create random virtual species ####
#--------------------------------------#

# make sure your variables are named:
names(r) <- paste0("NLM", 1:6)

# the simplest way to create a species is by using the "generateRandomSp" function and just using a raster stack with all variables
random.sp <- generateRandomSp(r,  niche.breadth="wide")





#################################

# SECOND PART SP WITH RESPONSE FUNCTIONS

#################################


# 4 - plot some response functions ####
#-------------------------------------#







#1.  First, the species' suitable habitat or niche is defined as a function of environmental variables

#2. This habitat suitability function is then projected into geographic space and converted to the required 
#response (such as occurrence, abundance or occupancy).

#3. The response is then sampled and used to calibrate SDMs, which can then be tested against the known species distribution.

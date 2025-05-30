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

rm(random.sp)
# 4 - plot some response functions ####
#-------------------------------------#
library(ggplot2)
library(gridExtra)

# Extract the values from your raster layer
v = terra::values(r$NLM1)

log1 <- virtualspecies::logisticFun(v, alpha = -0.1, beta = 0.25)
logisticplot<- ggplot(data.frame(x = v, y = log1), aes(x = v, y = log1)) +
  geom_point(color = rgb(0.4, 0.4, 0.8, 0.6), size = 2) +
  labs(x = "Value range environmental variable", y = "Suitability for species", 
       title = "Logistic function")

# Linear function plot
l1 <- virtualspecies::linearFun(v, a=-0.5, b = 0.25)
linearplot <- ggplot(data.frame(x=v, y=l1), aes(x = v, y = l1)) +
  geom_point(color=rgb(0.4, 0.4, 0.8, 0.6), size=2) +
  labs(x="Value range environmental variable", y="Suitability for species", 
       title="Linear function")

# Beta function plot
b1 <- virtualspecies::betaFun(v, p1=0.25, p2=0.55, alpha=0.2, gamma=0.4)
betaplot <- ggplot(data.frame(x=v, y=b1), aes(x = v, y = b1)) +
  geom_point(color=rgb(0.4, 0.4, 0.8, 0.6), size=2) +
  labs(x="Value range environmental variable", y="Suitability for species", 
       title="Beta function")

# Quadratic function plot
q1 <- virtualspecies::quadraticFun(v, a = -1, b = 1, c = 0.8)
quadraticplot <- ggplot(data.frame(x=v, y=q1), aes(x = v, y = q1)) +
  geom_point(color=rgb(0.4, 0.4, 0.8, 0.6), size=2) +
  labs(x="Value range environmental variable", y="Suitability for species", 
       title="Quadratic function")

# Arrange all plots
p=grid.arrange(linearplot, betaplot, logisticplot, quadraticplot, ncol=2)
ggsave("C:/DATA/Lehre/moer-msc-advanced-SDM/docs/assets/images/unit02/functions2.png", plot = p, width = 8, height = 6)

###################################################


# STUDENT TUTORIAL CREATE SPECIES WITH FUNCTION


rm(b1,l1,log1,a1,v,quadraticplot,logisticplot,linearplot,betaplot,q1,v1,p,list.of.packages,pkg)
#####################################################





plot(r)

# create first virtual species with 

params <- formatFunctions(NLM4 = c(fun = 'logisticFun', alpha = -0.1, beta = 0.25),
                          NLM2 = c(fun = 'quadraticFun', a = -1, b = 1, c = 0.8),
                          NLM1 = c(fun = 'betaFun', p1=0.25, p2=0.55, alpha=0.2, gamma=0.4))

# Generation of the virtual species
species1 <- generateSpFromFun(raster.stack = r[[c("NLM4", "NLM2", "NLM1")]],
                                 parameters = params,
                                 formula = "5.5 * NLM4^2 - 3 * sqrt(NLM2) +0.5*NLM1",
                                 plot = TRUE)

species1PA=convertToPA(species1, plot = TRUE)


### Example Code:
# Define the response functions for the environmental variables
params <- formatFunctions(NLM4 = c(fun = 'logisticFun', alpha = -0.1, beta = 0.25),
                          NLM2 = c(fun = 'quadraticFun', a = -1, b = 1, c = 0.8),
                          NLM1 = c(fun = 'betaFun', p1 = 0.25, p2 = 0.55, alpha = 0.2, gamma = 0.4))

# Generate the virtual species based on the defined parameters and formula
species1 <- generateSpFromFun(raster.stack = r[[c("NLM4", "NLM2", "NLM1")]],
                              parameters = params,
                              formula = "5.5 * NLM4^2 - 3 * sqrt(NLM2) + 0.5 * NLM1",  # Formula defining suitability
                              plot = TRUE)  # Plot the environmental suitability map

# Convert the continuous suitability values to presence-absence data
species1PA <- convertToPA(species1, plot = TRUE)  # Generate and plot presence-absence map


## Plot

# Load the necessary library for plotting
library(ggplot2)

# Extract the values from the environmental variable raster using the terra package
v = terra::values(r$NLM1)

# Apply the quadratic response function from the virtualspecies package to the environmental variable values (v)
q1 <- virtualspecies::quadraticFun(v, a = -1, b = 1, c = 0.8)

# Create a plot using ggplot2 to visualize the relationship between the environmental variable values and species suitability
# The x-axis represents the environmental variable values (v), and the y-axis represents the suitability values (q1)
ggplot(data.frame(x = v, y = q1), aes(x = v, y = q1)) +
  geom_point(color = rgb(0.4, 0.4, 0.8, 0.6), size = 2) +  # Plot the points with a semi-transparent color and size 2
  labs(x = "Value range environmental variable", 
       y = "Suitability for species",  # Labels for the x and y axes
       title = "Quadratic function")  # Title of the plot

# Note: if your rasters are very larkge it can take a while. You can also do it on a subsample.














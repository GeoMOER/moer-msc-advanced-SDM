---
title: "SDM workflow I - Exercise: get your training data"
header:
  image: '/assets/images/unit05/butterfly.png'
  caption: '[Internet Archive Book Images via flickr.com](https://www.flickr.com/photos/internetarchivebookimages/page7) [public domain](https://creativecommons.org/publicdomain/zero/1.0/){:target="_blank"}'
toc: true
---

## Exercise: Create your training data
The with code below, you can prepare predictors and training data for species distribution modeling. We will use the butterflies in Pakistan dataset that you can find in ILIAS for demonstration purposes. First start by loading all necessary packages into R 
Then set your working directory to a folder were you want to store the data for this exercise. Download the dataset "PakistanLadakh.csv" from ILIAS into the folder. Load the data into R with the function `read.csv` as a dataframe.

```r
# load packages that are needed
library(predicts)
library(caret)
library(sf)
library(geodata)
library(dismo)
library(dplyr)

# set your working directory to the path were you want to store your data 
# download the dataset "PakistanLadakh.csv" from ILIAS into the folder
setwd("D:/sdmWorkflow_Kurs/")


# load the .csv data as dataframe into R
data=read.csv("PakistanLadakh.csv")
colnames(data)<- c("species","x","y")

# check how your data looks like
str(data)
```
We will use just one of the many species available in this dataset for the demonstration of the SDM workflow: the species `Aglais caschmirensis`. We will filter all other species out using the `filter()`function from the [package dplyr]( https://cran.r-project.org/web/packages/dplyr/index.html). Feel free to use one of the other species for this unit.

```r
# for demonstration purposes we are now selecting a single species from the dataset:
Aglais_caschmirensis=dplyr::filter(data, species=="Aglais_caschmirensis");rm(data)
```
For the further processing of the occurrence records we will transform the dataframe into a `sf object`
The [`sf` package]( https://r-spatial.github.io/sf/) in R is used for handling and manipulating spatial data in a simple features format. It provides functions for reading, writing, analyzing, and visualizing spatial data. With `sf`, users can easily work with spatial data from various file formats, perform spatial operations, transform coordinate reference systems, and create customized maps. It is a versatile package that is commonly used in spatial analysis and modeling workflows, offering seamless integration with other packages for spatial statistics and species distribution modeling.
```r
# We are transforming the dataframe into an sf object
Aglais_caschmirensis=sf::st_as_sf(Aglais_caschmirensis, coords=c("x", "y"), remove=F, crs=sf::st_crs("epsg:4326"))
```
Have a look at the structure of your data again. What has changed?

### Environmental variables
The code below retrieves environmental layers for Pakistan using the `geodata` package, we already used in [unit 03](../unit03/unit03-05_example_SpatialDataProcessing.html). It uses the function `worldclim_country()’ to download bioclimatic variables with a resolution of 10 arc-minutes (res=10), we choose this resolution to process the data fast, to get meaningful results a higher resolution might be better. The variable argument "var" is set to "bio" to specify the bioclimatic variables. 
WorldClim provides a comprehensive set of bioclimatic variables that capture key aspects of climate across the globe. These variables are derived from long-term climate data and serve as valuable predictors in ecological and biogeographical studies. The WorldClim bioclimatic variables include measures such as temperature, precipitation, and seasonality. They offer insights into the annual and seasonal variations in climate, including parameters like mean annual temperature, temperature range, and precipitation of different months or seasons. Additionally, WorldClim provides indices related to water availability, moisture deficit, and heat stress. These bioclimatic variables enable users to assess the climatic conditions of specific regions and study their influence on species distribution patterns, ecological processes, and environmental responses.

```r
# get environmental layers:
r = geodata::worldclim_country(country="PAK", res=10, var="bio", path="D:/sdmWorkflow_Kurs/raster/", version = "2.1")
names(r)<-substr(names(r), 11, 20)

# mask to border of Pakistan
r=terra::mask(r, geodata::gadm(country="Pakistan", path="D:/sdmWorkflow_Kurs/"))
terra::writeRaster(r, "bioclim.tif", overwrite=T)
```

### Background data
We will generate background points for modeling with presence-background data as we have no absence data available. It creates background points using the `randomPoints` function from the [`dismo` package]( https://cran.r-project.org/web/packages/dismo/index.html). The function takes a raster stack as input and generates a specified number of random points (in this case, 10,000 points) across all values of the raster that are not NA. We will then convert the resulting points to an sf object. The dismo package is not compatible with `terra` however, a successor to the package is already being developed that can handle terra objects - the package `predicts`.
Then we will extract environmental information for both the background points and the species data. The `extract` function from the `terra` package is then used to extract the values of the bioclimatic variables for the corresponding points in the raster stack.
```r
# create background points
bg=sf::st_as_sf(as.data.frame(dismo::randomPoints(mask=raster::stack(r), n=10000)), crs=terra::crs(r), coords=c("x","y"), remove=F)
#the successor package for dismo is predicts, and also works with terra, but unfortunately still a bit buggy:
#bg=sf::st_as_sf(as.data.frame(predicts::backgroundSample(mask=r, n=1000)), crs=terra::crs(r), coords=c("x","y"), remove=F)

# extract environmental information for background data
bg_extr=terra::extract(r, bg)
bg=cbind(bg,bg_extr);rm(bg_extr)

Aglais_caschmirensis_extr=terra::extract(r,Aglais_caschmirensis)
Aglais_caschmirensis=cbind(Aglais_caschmirensis, Aglais_caschmirensis_extr);rm(Aglais_caschmirensis_extr)
```

{% include media4 url="/assets/misc/background.html" %} [Full screen version of the map]({{ site.baseurl }}/assets/misc/background.html){:target="_blank"}


### Create a test dataset

Create a sample of the species occurrence data, by selecting a random subset of 15% of the data points. This can be done using the `slice_sample` function from the `dplyr` package. This will be our test dataset.

Then we use a custom function called %not_in%, which negates the %in% operator.  The %in% operator allows you to check whether elements of one vector are present in another vector. This means the %not_in% operator checks for elements that are not present in a given vector. By using %not_in%, the code filters out the data points from the original species occurrence data (Aglais_caschmirensis) that are present in the testData sample. This ensures that the training data (trainData) does not include the points already selected for testing.

Don´t forget to save all your data, so we can use it next week!

```r
`%not_in%`<- Negate(`%in%`)

testData=dplyr::slice_sample(Aglais_caschmirensis, prop=.15)
trainData=dplyr::filter(Aglais_caschmirensis, ID %not_in% testData$ID )

sf::write_sf(testData, "Aglais_caschmirensis_testData.gpkg")
sf::write_sf(trainData, "Aglais_caschmirensis_trainData.gpkg")
sf::write_sf(bg, "background.gpkg")
```


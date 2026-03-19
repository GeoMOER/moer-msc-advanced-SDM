---
title: "EX | Predictions"
header:
  image: '/assets/images/unit05/butterfly.png'
  caption: '[Internet Archive Book Images via flickr.com](https://www.flickr.com/photos/internetarchivebookimages/page7) [public domain](https://creativecommons.org/publicdomain/zero/1.0/){:target="_blank"}'
toc: true
---

### Predictions
Now we create  a spatial prediction with our model and do a visual inspection of the map we created. Load the pre-trained model using the `readRDS()` function. 
Then load all the predictor variables from the raster file "bioclim.tif" using the `terra::rast()` function. This raster object has to contain all environmental variables used during model training.
To create the spatial prediction, the `terra::predict()` function is utilized. It takes the raster object and the pre-trained model as inputs, and generates predictions for each cell in the raster. The na.rm=T argument specifies that missing values should be ignored during the prediction process.
You can visualize the prediction using the `terra::plot()` function, this allows a visual assessment of the predicted spatial distribution of the modeled species. If you save your predicted raster you can also visualize it in a GIS, for example in the open-source software QGIS.
```r
library(caret)
library(terra)
library(sf)
library(Metrics)
library(ecospat)
library(raster)

# set your working directory
setwd("D:/sdmWorkflow_Kurs/")


# load your model
mod=readRDS("GamBoostModel.RDS")


# now we will create a spatial prediction of your model
# first load all your predictor variables
r=terra::rast("bioclim.tif")

# use the terra::predict function to create a spatial predcition:
pred=terra::predict(object = r,model= mod, na.rm=T)

# have a look at your predction
terra::plot(pred)

terra::writeRaster(pred, "prediction_aglais_caschmirensis.tif")
```
{% include media4 url="/assets/misc/prediction.html" %} [Full screen version of the map]({{ site.baseurl }}/assets/misc/prediction.html){:target="_blank"}
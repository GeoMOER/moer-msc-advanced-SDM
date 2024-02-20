---
title: "SDM workflow II - Exercise: Assessment & predictions"
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

# have a lookn at your predction
terra::plot(pred)

terra::writeRaster(pred, "prediction_aglais_caschmirensis.tif")
```
{% include media4 url="/assets/misc/prediction.html" %} [Full screen version of the map]({{ site.baseurl }}/assets/misc/prediction.html){:target="_blank"}


## Model assessment
One of the major challenges in species distribution modeling is assessing how good a model performs. There are several metrics around that can be calculated on left out test data. One of the most popular ones is the `area under the receiver operating characteristic curve (AUC)`. It is heavily used to assess the performance of models, there are quite a few of other metrics for example the [mean absolute error]( https://en.wikipedia.org/wiki/Mean_absolute_error) or the [boyce index]( https://doi.org/10.1016/j.ecolmodel.2006.05.017), a quite comprehensive overview of performance metrics can be found in the paper by [Konowalik & Nosol 2021](https://doi.org/10.1038/s41598-020-80062-1).
However most of these metrics are also somewhat controversial, there are entire studies dealing with the problematic use of some metrics. For example, the study [AUC: a misleading measure of the performance of predictive distribution models by Lobo et al. 2008](https://doi.org/10.1111/j.1466-8238.2007.00358.x). This makes it extremely difficult to assess the real performance of speices distribution models. In the comment from [Boris Leroy 2022]( https://doi.org/10.1111/jbi.14505), on the state of the art of species distribution modeling the topic of choosing performance metrics is listed as one of the unresolved problems of species distribution modeling.

{% include image.html url=" https://onlinelibrary.wiley.com/cms/asset/9ed9242b-6282-4326-bfd0-c1de0e6f2c47/jbi14505-fig-0001-m.png
" description=" Choosing presence-only species distribution models. Source: Boris Leroy 2022, https://doi.org/10.1111/jbi.14505." %}
In addition, metrics like the AUC are meant to be calculated with presence-absence data, which is often not available for testing predictions. We will test our model here with three metrics: the AUC, the Boyce index and the mean absolute error (MAE). For this we use the R packages Metrics and ecospat. 
For the calculation of the AUC and the MAE we will use the background points instead of absence points. The AUC can take a value between 0 and 1, whereby a value of 0.5 describes a model that is as good as random, while a higher value describes a model that is better than random.


```r


# load you testdata

testData=sf::read_sf("Aglais_caschmirensis_testData.gpkg")

# calculate the boyce-index:
boyceIndex=ecospat::ecospat.boyce(fit=raster(pred), obs=testData)
boyceIndex=boyceIndex$cor

#extract the values of the testdata from the prediction raster for AUC and MAE
extrTest=terra::extract(pred, testData)
colnames(extrTest)<-c( "ID"  , "predcicted")
extrTest$observed<-1



# load background data and extract
bg=sf::read_sf("background.gpkg")
extrBg=terra::extract(pred, bg)
colnames(extrBg)<-c( "ID"  , "predcicted")
extrBg$observed<-0

# bind both dataframes together:
testData=rbind(extrTest, extrBg)
rm(extrTest, extrBg,bg)

# calculate AUC and MAE
AUC<-Metrics::auc(actual = testData$observed, predicted = testData$predcicted)
MAE<-Metrics::mae(actual = testData$observed, predicted = testData$predcicted)


print(AUC)
print(MAE)
print(boyceIndex)

```


What do you notice when you look at the results for the three metrics along with the prediction map? To support the analysis, you can also create a map showing the prediction and the test points in order to better interpret the results.

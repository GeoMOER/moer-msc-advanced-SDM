---
title: "EX | Model Assessment 🚧"
published: false
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_cropped.png'
  caption: 'Generated with Google Gemini'
toc: true
---


[![](https://onlinelibrary.wiley.com/cms/asset/9ed9242b-6282-4326-bfd0-c1de0e6f2c47/jbi14505-fig-0001-m.png)](https://doi.org/10.1111/jbi.14505)

**Figure:** *Choosing presence-only species distribution models. Source: Boris Leroy 2022, [https://doi.org/10.1111/jbi.14505](https://doi.org/10.1111/jbi.14505).*





In addition, metrics like the AUC are meant to be calculated with presence-absence data, which is often not available for testing predictions. We will test our model here with three metrics: the AUC, the Boyce index and the mean absolute error (MAE). For this we use the R packages Metrics and ecospat. 
For the calculation of the AUC and the MAE we will use the background points instead of absence points. The AUC can take a value between 0 and 1, whereby a value of 0.5 describes a model that is as good as random, while a higher value describes a model that is better than random.


```r


# load you testdata

testData=sf::read_sf("Aglais_caschmirensis_testData.gpkg")

# calculate the boyce-index:
boyceIndex=ecospat::ecospat.boyce(fit=pred, obs=sf::st_coordinates(testData))
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

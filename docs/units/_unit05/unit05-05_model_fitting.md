---
title: "SDM workflow II - Exercise: Model fitting"
header:
  image: '/assets/images/unit05/butterfly.png'
  caption: '[Internet Archive Book Images via flickr.com](https://www.flickr.com/photos/internetarchivebookimages/page7) [public domain](https://creativecommons.org/publicdomain/zero/1.0/){:target="_blank"}'
toc: true
---

Last week we prepared the training data we will use for our species distribution modeling task. The training dataset as well as the background points will be used now to fit a model.

First set the working directory into the folder you stored your datasets `Aglais_caschmirensis_trainData.gpkg` and `background.gpkg` in. We create a vector with the names of all predictor vairbales, these will bes used later to subset the dataframe to the columns with the predictor variables.
```r
# set up
libs=c("tidyverse","sf","dplyr","terra","caret","mboost", "import","CAST","purrr")
lapply(libs, require, character.only = TRUE)
setwd("D:/sdmWorkflow_Kurs/")

# names of variables used for training the model
vars=names(terra::rast("bioclim.tif"))
```

We create a column in which we store the so called response variable, traditionally in species distribution modeling the presence rescords get the value 1 assigned while absence or background data get the value 0.  

```r
# read the presence only data
po=sf::read_sf("Aglais_caschmirensis_trainData.gpkg")
po$occ=1
bg=sf::read_sf("background.gpkg")
bg$occ=0
```

We now want to combine both datasets into one, for this we first check the structure again and then bind the rows of the dataframe together: using the function `rbind`.  There is one line in the code missing that you need before you can combine them, why can´t both dataframes be combined right now and what is missing? Add the missing code.

```r
# create one dataset with presence and background data
data=rbind(po,bg)%>%as.data.frame()%>%dplyr::select(-geom)
```
Now we have one dataset for model fitting. For this simplified example workflow we will use the R package `caret` for model training. [The `caret` package]( https://topepo.github.io/caret/) is not specifically for species distribution modeling, but *the* framework for modeling  in R. 

It is a powerful toolkit for training and evaluating various machine learning models. It provides a unified interface and a wide range of functionalities to streamline the model building process. One key function in the caret package is the `train()` function. This function serves as a high-level interface for model training and parameter tuning. It allows users to specify the model's training algorithm, tuning parameters, evaluation metrics, and data preprocessing options in a flexible and consistent manner.
The train() function takes as input a set of predictors (independent variables) and a response variable (dependent variable) and fits a specified model using the specified training algorithm. It automates the process of cross-validation and parameter tuning, ensuring that the model is optimized for performance.
The function supports a diverse set of modeling techniques, ranging from traditional regression and classification models to more advanced algorithms such as random forests, support vector machines, and neural networks. It also provides options for handling imbalanced data, computing variable importance, and making predictions on new data.

We will now define some of the model parameters. With the `trainControl`function of the caret package we define that our validation strategy is a cross-validation with five folds. We also define a tuning grid, which includes all model parameters that can be tuned. The `expand.grid()`function uses creates a grid with all possible hyperparameter combinations that are tested one after another. The more combinations you create the longer your model training will take. Thirdly we will also create some weights that are passed to the modeling function. If this process is necessary depends on your modeling function, some algorithms like random forest don’t take weights, but perform a lot better if only the same amount of background data and presence points is used. So carefully adapt this process to your modeling approach. 
Here we use the weights, as there are a lot more background points than presence points, we don´t want to loss all the information of the background points by downsampling therefore we just put a higher weight on the presence points than on the background points during model training.
Weights are therefore created based on the occurrence values, with the presence points receiving a weight of 1 and the background points down-weighted based on the ratio of presence to background points.
```r
#definde cross-validation
ctrl = caret::trainControl(method="cv",
                           number=5)

tuneGrid=expand.grid(mstop = c(50,100,150),
                     prune=c("no"))

# create weights
w <- ifelse(data$occ == 1, 1, nrow(data[data$occ==1,])/nrow(data)) # down-weighting
```
The model is trained on the environmental variables as predictors and the occurrence (presence/absence) as the response variable. The weights are considered during the model fitting process. We will use a Boosted Generalized Additive Model for demonstration purposes.
The Boosted Generalized Additive Model (gamboost) is a machine learning algorithm that combines generalized additive models with boosting. It iteratively fits a sequence of GAMs to the data, with each subsequent GAM aiming to correct the residuals of the previous models. This boosting process helps improve the model's predictive performance by creating a strong ensemble model. By incorporating nonlinear relationships through GAMs, the model can capture complex interactions between environmental variables and species occurrence.
```r
# you can also do a classification instead of a regression:
#data$occ<-as.factor(data$occ)

GamBoostModel=caret::train(data[,vars],
                           data[,c("occ")],
                           method = "gamboost",
                           tuneGrid = tuneGrid,
                           trControl=ctrl,
                           weights=w
)
```

Now you trained your first species distribution model! Save your model, so you can use it later on again: 

```r
saveRDS(GamBoostModel, "GamBoostModel.RDS")
```


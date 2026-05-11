---
title: "EX |  Model Training and Prediction"
header:
  image: '/assets/images/teaserimages/gemini_audio.png'
  caption: 'Generated with Google Gemini'
toc: true
---

In this exercise, we move from data preparation to the core of SDM: **Model Training** and **Spatio-Temporal Prediction**. We use a Random Forest (RF) classifier and address spatial autocorrelation using **k-fold Nearest Neighbor Distance Matching (kNNDM)** cross-validation.

## 1. Model Training

We begin by loading our presence/background data and environmental predictors. To ensure our model generalizes well to new geographic areas, we use the `CAST` package to create spatial folds.

Traditional random cross-validation often overestimates model performance because spatial data is inherently autocorrelated. `knndm` ensures that the distance between training and test points in the CV folds matches the distance between training data and the actual prediction domain.

```r
library(CAST)
library(sf)
library(dplyr)
library(terra)

# 1.1 Load Training Data ----
data <- sf::read_sf("data/trainingData.gpkg")
po <- data %>% dplyr::filter(presence == 1)
bg <- data %>% dplyr::filter(presence == 0)

# Load Predictor Rasters
r_files <- list.files("data/hyras_hessen/", pattern = "*.tif$", 
                      full.names = TRUE, recursive = TRUE)
predictors_stack <- terra::rast(r_files)

# 1.2 Spatial Cross-Validation Setup ----
# Generate clusters for presence points based on the model domain
knndm_folds <- CAST::knndm(tpoints = po, modeldomain = predictors_stack, k = 6)
po$KNNDM <- knndm_folds$clusters

# Assign background points to folds randomly (matching the k count)
bg$KNNDM <- sample(1:6, nrow(bg), replace = TRUE)

# Combine and clean
train_df <- rbind(po, bg) %>% 
  na.omit() %>%
  st_drop_geometry() # Remove geometry for the training function

# 1.3 Random Forest Training ----
source("[https://raw.githubusercontent.com/envima/sdmEvaluationMetrics/refs/heads/main/R/functions/rfModelTraining.R](https://raw.githubusercontent.com/envima/sdmEvaluationMetrics/refs/heads/main/R/functions/rfModelTraining.R)")

if(!dir.exists("data/output")) dir.create("data/output", recursive = TRUE)

rf_model <- rfModelTraining(
  trainingData = train_df,
  response     = "presence",
  spacevar     = "KNNDM",
  timevar      = "time",
  k            = 5,
  predictors   = c("air_temp_max", "air_temp_mean", "photoperiod", "precipitation"),
  outputPathModel = "data/output/phoenicurus_phoenicurus_rf.RDS",
  prediction   = FALSE
)
```


### Spatio-Temporal Prediction

Once the model is trained, we apply it to our raster stack. Since our predictors are time-specific (daily), we iterate through each date, rename the layers to match the model’s expected input, and generate a probability map.


```r
library(tidyterra)
library(ggplot2)

# 2.1 Setup Prediction Loop ----
rf_model <- readRDS("data/output/phoenicurus_phoenicurus_rf.RDS")
layer_names <- names(predictors_stack)
dates <- unique(gsub(".*_", "", layer_names))

results_list <- list()

for (d in dates) {
  message("Predicting for date: ", d)
  
  # Subset and rename layers to match training variable names
  daily_sub <- predictors_stack[[grep(d, layer_names)]]
  names(daily_sub) <- gsub(paste0("_", d), "", names(daily_sub))
  
  # Predict probability (selecting the 'presence' class, usually index 2)
  pred_prob <- terra::predict(daily_sub, rf_model, type = "prob", na.rm = TRUE)[[2]]
  
  # Rescale and save
  pred_rescaled <- climateStability::rescale0to1(pred_prob)
  names(pred_rescaled) <- paste0("date_", d)
  
  writeRaster(pred_rescaled, 
              filename = paste0("data/output/rf_pred_", d, ".tif"), 
              overwrite = TRUE)
  
  results_list[[d]] <- pred_rescaled
}

prediction_stack <- terra::rast(results_list)
```

### Visualizing Results

Visualizing the daily changes in occupancy probability allows us to identify phenological patterns or climate-driven shifts in the species' distribution.

```r 
ggplot() +
  geom_spatraster(data = prediction_stack) +
  facet_wrap(~lyr) +
  scale_fill_whitebox_c(
    palette = "muted",
    limits = c(0, 1),
    name = "Probability"
  ) +
  theme_minimal() +
  labs(
    title = "Daily Calling Probability: Phoenicurus phoenicurus",
    caption = "Data: DWD, HLNUG"
  )
```

![](../assets/images/unit05/pred.png)


---
title: "EX | Model evaluation"
published: false
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_cropped.png'
  caption: 'Generated with Google Gemini'
toc: true
---

Most Species Distribution Model (SDM) outputs are continuous probabilities ranging from **0** to **1**. A common pitfall for researchers is failing to realize how drastically a distribution map changes based on the threshold chosen to define a presence-absence map.

### Task

Take one of your continuous suitability map from the last unit and apply three different thresholds to create binary presence/absence maps:

*   **Strict:** (e.g., **0.8** - captures only high-confidence areas).
*   **Balanced:** (e.g., **0.5**).
*   **Liberal:** (e.g., **0.3** - predicts presence even in marginal or transition areas).



---

### Exercise

1) Transform your suitability maps to presence-absence maps with the three thresholds named above. 

2) Create a **panel map** (a single figure displaying all three versions side-by-side) to visually compare how the predicted range expands or contracts based on your mathematical choices.

3) Calculate the TSS with the three different maps.  

---


```r
# 1. Setup and Data Loading
setwd("C:/Users/bald_local/DATA/Lehre/sdmWorkflow_Kurs")

testData <- sf::read_sf("Aglais_caschmirensis_testData.gpkg")
pred     <- terra::rast("prediction_aglais_caschmirensis.tif")

# 2. Create Binary Maps (Presence/Absence)
pred_strict   <- terra::ifel(pred >= 0.8, 1, 0)
pred_balanced <- terra::ifel(pred >= 0.5, 1, 0)
pred_liberal  <- terra::ifel(pred >= 0.3, 1, 0)

# 3. Extract Values for Evaluation
# Presence points
ext_p_strict   <- terra::extract(pred_strict, testData)[,2]
ext_p_balanced <- terra::extract(pred_balanced, testData)[,2]
ext_p_liberal  <- terra::extract(pred_liberal, testData)[,2]

# Generate 1000 Background points (Pseudo-absences)
bg_coords      <- terra::spatSample(pred, size = 1000, method = "random", na.rm = TRUE, as.points = TRUE)
ext_bg_strict   <- terra::extract(pred_strict, bg_coords)[,2]
ext_bg_balanced <- terra::extract(pred_balanced, bg_coords)[,2]
ext_bg_liberal  <- terra::extract(pred_liberal, bg_coords)[,2]

# 4. Define TSS Function
calc_tss <- function(pres_vec, bg_vec) {
  # True Positives (tp) and False Negatives (fn)
  tp <- sum(pres_vec == 1, na.rm = TRUE)
  fn <- sum(pres_vec == 0, na.rm = TRUE)
  
  # False Positives (fp) and True Negatives (tn)
  fp <- sum(bg_vec == 1, na.rm = TRUE)
  tn <- sum(bg_vec == 0, na.rm = TRUE)
  
  # TSS = Sensitivity + Specificity - 1
  sensitivity <- tp / (tp + fn)
  specificity <- tn / (tn + fp)
  tss <- sensitivity + specificity - 1
  
  return(round(tss, 3))
}

# 5. Calculate and Compare Results
results <- data.frame(
  Threshold_Map = c("Strict (0.8)", "Balanced (0.5)", "Liberal (0.3)"),
  TSS = c(
    calc_tss(ext_p_strict, ext_bg_strict),
    calc_tss(ext_p_balanced, ext_bg_balanced),
    calc_tss(ext_p_liberal, ext_bg_liberal)
  )
)

print(results)


```


> What do you notice when you look at the results for the three metrics along with the prediction map? To support the analysis, you can also create a map showing the prediction and the test points in order to better interpret the results.




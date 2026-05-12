---
title: "LM | Presence-only SDM model evaluation 🚧"
published: true
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_cropped.png'
  caption: 'Generated with Google Gemini'
toc: true
---

<!--

{: .notice--warning}
-->
# The Reliability of Presence-Only Evaluation

Species Distribution Modeling (SDM) is a cornerstone of modern conservation, yet evaluating these models without true absence data remains a "pressing concern". Most researchers rely on **Presence-Background (PBG)** data, but this introduces an unknown statistical bias that can lead to misallocated conservation resources.

---

## 1. The Challenge: Evaluating the "Unseen"

In presence-only modeling, we lack confirmed "zeros." This makes it nearly impossible for standard metrics to detect **overprediction** (predicting a species where it is actually absent). 

* **Presence-Background (PBG):** Randomly samples points across the study area. These points may actually fall in suitable habitats, leading the metric to underestimate model performance.
* **Presence-Artificial-Absence (PAA):** Samples points from environmentally distant regions. This reduces the risk of "false" absences and provides a clearer baseline.

### Key Findings from Recent Research
According to **Bald et al. (under review)**, without true absence data, evaluation metrics typically deviate from actual model performance by **39% to 42%**. 

| Data Type | Median Absolute Error (MAE) | Reliability |
| :--- | :--- | :--- |
| **Presence-Only** | 0.25 - 0.44 | Low |
| **Presence-Background** | 0.14 - 0.29 | Moderate |
| **Presence-Artificial-Absence** | **0.10 - 0.18** | **Highest** |

---

## 2. Advanced Technique: Area of Applicability (AOA)

To improve evaluation accuracy, we can move away from random background points and use the **Area of Applicability (AOA)**. 

The AOA utilizes a dissimilarity index (k-nearest-neighbor) to identify areas where the environmental space is significantly different from your presence observations. By sampling "Artificial-Absences" from these dissimilar regions, we create a more robust test dataset that better approximates true absence data.

---

## 3. Exercise: Re-evaluating with AOA

In this exercise, you will test if using environmentally distant "artificial absences" changes your perception of your model's quality.

### Task
1. Identify environmentally dissimilar areas using the `aoa()` function.
2. Sample an equal number of artificial-absence points as you have presence points.
3. Recalculate your **TSS** (True Skill Statistic).

```r
# Example logic for AOA sampling
# 1. Calculate AOA
aoa_result <- CAST::aoa(newdata = env_predictors, train = presence_data_coords)

# 2. Identify areas outside the AOA (environmentally dissimilar)
# Usually DI > threshold
dist_areas <- aoa_result$DI > aoa_result$threshold

# 3. Sample artificial absences from these areas
paa_points <- terra::spatSample(dist_areas, size = nrow(presence_data), method = "random")

![](../assets/images/unit04/Bild1.png)

**Figure:** *Title. Bald et al. under review*


![](../assets/images/unit04/Bild2.png)

**Figure:** *Title. Bald et al. under review*


![](../assets/images/unit04/Bild3.png)

**Figure:** *Title. Bald et al. under review*


Work in progress 🚧!



-> calculation based on aoa 
-> exercise calculate metrics again.
-> what have we learned today? 

-> recap, how confused are you now?
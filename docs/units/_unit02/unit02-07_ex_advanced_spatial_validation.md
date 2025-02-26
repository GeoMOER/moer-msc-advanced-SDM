---
title: "EX-A | Spatial evaluation (optional / advanced)"
header:
  image: '/assets/images/unit05/butterfly.png'
  caption: '[Internet Archive Book Images via flickr.com](https://www.flickr.com/photos/internetarchivebookimages/page7) [public domain](https://creativecommons.org/publicdomain/zero/1.0/){:target="_blank"}'
toc: true
---


This is an optional exercise intended for advanced course participants.
{: .notice--warning}


# Spatial Validation and Cross-Validation in Species Distribution Modeling (SDM)

## Introduction
Spatial validation and cross-validation are essential steps in species distribution modeling (SDM) to assess model performance and ensure robust predictions. Traditional validation approaches, such as random cross-validation, may not be suitable for SDMs due to spatial autocorrelation. Spatial validation techniques account for spatial structure and improve the reliability of model evaluation.

## 1. Cross-Validation Approaches
Cross-validation is used to assess model generalizability by partitioning data into training and testing sets. Several approaches exist, with some being more appropriate for spatial data.

### 1.1 Random Cross-Validation
- **Description:** Data points are randomly split into training and testing sets.
- **Limitations:** Ignores spatial autocorrelation, leading to overestimation of model performance.

### 1.2 k-Fold Cross-Validation
- **Description:** Data is divided into k subsets (folds). The model is trained on k-1 folds and tested on the remaining fold, repeating k times.
- **Limitations:** Similar to random cross-validation, spatial dependence may violate independence assumptions.

## 2. Spatial Cross-Validation Techniques
To overcome issues related to spatial autocorrelation, spatial cross-validation techniques have been developed.

### 2.1 Spatial Block Cross-Validation
- **Description:** The study area is divided into spatial blocks, ensuring that training and testing data are spatially separated.
- **Implementation:** 
  - Create spatial blocks of fixed size.
  - Assign blocks to folds, ensuring separation of training and testing data.
- **Advantages:** Reduces spatial autocorrelation in training and testing data.
- **Disadvantages:** Block size selection impacts model evaluation.

### 2.2 Leave-One-Block-Out Cross-Validation (LOBO-CV)
- **Description:** One spatial block is left out as the testing set while the remaining blocks are used for training.
- **Advantages:** Ensures strong independence between training and testing data.
- **Disadvantages:** Computationally expensive and results depend on block size.

### 2.3 Environmental Filtering Cross-Validation
- **Description:** Data partitioning is based on environmental variables rather than geographic space.
- **Advantages:** Ensures that model evaluation accounts for environmental heterogeneity.
- **Disadvantages:** Selecting relevant environmental variables can be challenging.

## 3. Evaluating Model Performance
Model performance is assessed using multiple metrics, including:
- **AUC (Area Under the Curve):** Measures model discrimination ability.
- **TSS (True Skill Statistic):** Accounts for both sensitivity and specificity.
- **Boyce Index:** Evaluates model predictions relative to species occurrence probability.

## 4. Best Practices in Spatial Validation
- Use spatially explicit validation methods to avoid overestimation of predictive performance.
- Select an appropriate block size to balance data independence and sufficient training data.
- Compare multiple validation approaches to assess model robustness.

## Conclusion
Spatial validation and cross-validation techniques improve the reliability of SDMs by accounting for spatial structure. Choosing an appropriate validation method enhances model robustness and ensures more reliable ecological inferences.

---
### References
- Roberts, D. R., Bahn, V., Ciuti, S., et al. (2017). Cross-validation strategies for data with temporal, spatial, or phylogenetic structure. *Ecography*, 40(8), 913-929.
- Wenger, S. J., & Olden, J. D. (2012). Assessing transferability of ecological models: an underappreciated aspect of statistical validation. *Methods in Ecology and Evolution*, 3(2), 260-267.

---
title: "LM | Model evaluation 🚧"
published: false
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_cropped.png'
  caption: 'Generated with Google Gemini'
toc: true
---

<!--

{: .notice--warning}
-->



In machine learning we perform model assessment primarily to determine the model’s ability to generalize. A model that performs perfectly on its training data but fails to predict independent observations is [overfitted](https://en.wikipedia.org/wiki/Overfitting), meaning it has memorized the training data by heart but it is not able to make valuable assumptions about data that deviates from the training data. Ideally effective evaluation would allows us to communicate the qualirty of our models to stakeholders and ensure that conservation decisions are based on robust evidence. However, in Species Distribution Modeling 


[![https://en.wikipedia.org/wiki/Overfitting](https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Pyplot_overfitting.png/960px-Pyplot_overfitting.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail&_=20240704144658)](https://commons.wikimedia.org/wiki/File:Pyplot_overfitting.png)
**Figure:** *Noisy (roughly linear) data is fitted to a linear function and a polynomial function. Although the polynomial function is a perfect fit, the linear function can be expected to generalize better: If the two functions were used to extrapolate beyond the fitted data, the linear function should make better predictions. Source: [Wikimedia](https://commons.wikimedia.org/wiki/File:Pyplot_overfitting.png), Author: ThirdOrderLogic,
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.en)*


## Evaluating with Presence-Absence Data
When your study design includes "True Absences"—locations where the species was confirmed to be missing through rigorous survey—you can utilize the standard Confusion Matrix approach. This matrix serves as the foundation for most classification statistics by categorizing outcomes into True Positives, True Negatives, False Positives, and False Negatives.

### Threshold-Dependent Metrics
Most SDM algorithms, such as Generalized Linear Models (GLM) or Random Forests, produce a continuous probability output between 0 and 1. To calculate specific performance values, researchers must choose a threshold to convert these probabilities into binary "Presence" or "Absence" predictions. Two primary metrics derived from this are Sensitivity and Specificity. Sensitivity, or the true positive rate, measures the model's ability to correctly identify occupied sites. Conversely, Specificity measures the ability to correctly identify unoccupied sites. Because these metrics can be influenced by how common a species is—a concept known as prevalence—the [True Skill Statistic (TSS)](https://doi.org/10.1111/j.1365-2664.2006.01214.x) is often used in ecological studies. Calculated as (Sensitivity + Specificity - 1), TSS provides a measure of performance that is technically independent of prevalence, ranging from -1 to +1, where values above 0.6 indicate high model utility. For a deeper dive into these classifications, the Wikipedia page on [Sensitivity and Specificity](https://en.wikipedia.org/wiki/Sensitivity_and_specificity) provides a comprehensive breakdown of the underlying logic.

### Threshold-Independent Metrics
The most ubiquitous metric in SDM is the [Area Under the Receiver Operating Characteristic curve (AUC-ROC)](https://en.wikipedia.org/wiki/Receiver_operating_characteristic). The advantage of AUC is that it evaluates the model across all possible thresholds simultaneously. It effectively represents the probability that the model will rank a randomly chosen presence site higher than a randomly chosen absence site. An AUC of 0.5 suggests the model is performing no better than a random guess, while an AUC of 1.0 represents perfect discrimination. While popular, AUC has been criticized in geography for ignoring the spatial distribution of errors, which is why it should always be interpreted alongside the biological reality of the species being modeled.

## Challenges with Presence-Background Data
In many large-scale geographic studies, "True Absences" are unavailable, and we instead use "Background" or "Pseudo-absence" points to represent the available environment. This introduces a significant conceptual challenge: a model prediction in a background area cannot be strictly labeled a "False Positive" because we do not actually know if the species is absent there; it may simply be unrecorded.

Because of this uncertainty, traditional accuracy metrics become misleading. To address this, researchers often employ the [Boyce Index](https://doi.org/10.1016/j.ecolmodel.2006.05.017), which is specifically designed for presence-only evaluation. The Boyce Index measures how much the predicted presence distributions deviate from a random distribution across the entire study area. It is calculated by partitioning the predicted suitability into classes and analyzing the frequency of actual presences within those classes. A model with high predictive power will show a strong positive correlation between suitability and the number of presences. Furthermore, when using presence-background data, the [AUC interpretation changes](https://doi.org/10.1016/j.ecolmodel.2005.03.026), as it now measures the model's ability to distinguish a presence from a random location in the environment rather than a confirmed absence.

## Integrating Evaluation into the SDM Workflow
Comprehensive model assessment should not rely on a single number. A robust evaluation involves looking at the consistency between different metrics and understanding the geographic patterns of the errors. For those interested in the broader context of how these models are built and where evaluation fits into the pipeline, the Wikipedia entry on [Species Distribution Modelling](https://en.wikipedia.org/wiki/Species_distribution_modelling) offers a useful overview of the entire process. Furthermore, the [Guillera-Arroita et al. (2015)](https://doi.org/10.1111/jbi.12434) paper provides an excellent theoretical framework for determining if a model is truly "fit for purpose" based on the quality of the evaluation data available.

By moving beyond simple "accuracy" and toward a more nuanced understanding of metrics like TSS and the Boyce Index, geographers can better interpret the limitations and strengths of their predictive maps.


It is vital to recognize that a model is merely a hypothesis of a species' ecological niche projected onto a geographic map []().
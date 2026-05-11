---
title: Overview  🚧
published: false
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_cropped.png'
  caption: 'Generated with Google Gemini'
toc: true
---
This unit explores the critical uncertainties inherent in evaluating Species Distribution Models (SDMs) built with presence-only data. You will learn how to navigate the statistical bias introduced when true absence data is missing and how to implement more robust evaluation strategies to ensure your models are reliable for research and nature conservation.

<!--more-->

## Learning objectives

At the end of this unit you should be able to:

* Evaluate your models predictions map. 
* Understand the influence of the threshold on threshold dependent metrics. 
* Understand why standard metrics like AUC, Kappa, and TSS can deviate by approximately 40% from actual performance when calculated without true absence data.
* 



This unit explores the critical uncertainties inherent in evaluating Species Distribution Models (SDMs) built with presence-only data. You will learn how to navigate the statistical bias introduced when true absence data is missing and how to implement more robust evaluation strategies to ensure your models are reliable for research and nature conservation.

## Learning objectives

At the end of this unit you should be able to:

* **Evaluate your model's prediction maps:** Critically assess the spatial patterns produced by different modeling thresholds.
* **Understand the influence of thresholds:** Analyze how choosing strict, balanced, or liberal thresholds changes the outcome of threshold-dependent metrics like TSS and Kappa.
* **Understand metric deviation:** Explain why standard metrics like AUC, Kappa, and TSS can deviate by approximately 40% from actual performance when calculated without true absence data.
* **Implement robust alternatives:** Use the Area of Applicability (AOA) to generate artificial-absence points from environmentally dissimilar regions to improve metric accuracy.
* **Communicate uncertainty:** Contextualize model results for stakeholders by acknowledging the baseline errors of presence-only evaluation.
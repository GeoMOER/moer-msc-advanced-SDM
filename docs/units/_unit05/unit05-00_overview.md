---
title: Overview 
published: true
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_cropped.png'
  caption: 'Generated with Google Gemini'
toc: true
---
This unit explores the critical uncertainties inherent in evaluating Species Distribution Models (SDMs) built with presence-only data. You will learn how to navigate the statistical bias introduced when true absence data is missing and how to implement more robust evaluation strategies to ensure your models are reliable for research and nature conservation.

<!--more-->



## Learning objectives

At the end of this unit you should be able to:

* **Evaluate your model's prediction maps:** By calculating different evaluation metrics.
* **Understand the influence of thresholds:** Analyze how choosing strict, balanced, or liberal thresholds changes the outcome of threshold-dependent metrics like TSS and Kappa.
* **Understand evaluation metric limitations:** Understand that standard metrics like AUC, Kappa, and TSS can deviate from actual performance.
* **Evaluate presence-only models:** Generate artificial-absence points from environmentally dissimilar regions to calculate evaluation metrics with presence-only data.
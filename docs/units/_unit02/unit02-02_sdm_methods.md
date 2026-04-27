---
title: EX | The Algorithmic Landscape
toc: true
published: true
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_lake_cropped.png'
  caption: 'Generated with Google Gemini'
---


<!--more-->
### Correlative vs. Mechanistic Modeling

In the field of Species Distribution Modeling, we generally distinguish between two fundamental frameworks: correlative and mechanistic models. While both approaches aim to predict the spatial occurrence of a species, they rely on entirely different sets of assumptions and data types to reach their conclusions.

#### **Mechanistic Models**
Mechanistic models, often referred to as process-based models, focus on the causal biological forces that allow an organism to persist in a given environment. Rather than observing where a species currently lives, these models calculate where a species *could* live by simulating the biophysical exchange between the organism and its surroundings. This approach utilizes functional traits to model specific constraints such as metabolic rates, water loss, and thermal tolerance limits like minimum temperature and maximum temperature. The data required for these models is typically high-resolution and derived from controlled laboratory experiments, such as respirometry or heat-tolerance trials. Because they are rooted in the fundamental physiology of the species, mechanistic models are exceptionally powerful for predicting distributions in "no-analog" future climates or identifying the invasive potential of species in entirely new continents where historical spatial correlations do not yet exist. However, the primary risk of this approach is its extreme data intensity; for the vast majority of the world's taxa, the detailed physiological parameters required for a robust model are simply unavailable.

#### **Correlative (Niche) Models**
Correlative models represent the primary focus of most modern SDM applications and rely heavily on statistical associations. The underlying logic assumes that the environmental conditions present at the locations where a species is currently observed accurately represent its ecological requirements. These models use "occurrence-environment" correlations to define habitat suitability; for example, if a species is consistently found in areas with high annual rainfall and specific temperature ranges, the model identifies that environmental envelope as suitable habitat. The data requirements are relatively straightforward, consisting of occurrence points from databases like GBIF and environmental GIS layers such as WorldClim or CHELSA. Correlative models are best suited for large-scale mapping across thousands of species and for rapid conservation assessments. Their main limitation lies in extrapolation; because the model does not understand the physiological "why" behind an observation, it may fail to provide accurate predictions when projected into future climate scenarios that have no modern equivalent.

---

### Machine Learning in SDM

<em>Machine Learning (ML) is not a single tool, but a family of algorithms. [Valavi et al. explained in their 2021 benchmark study](https://doi.org/10.1002/ecm.1486) ([CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)) the differences between the different kind of model algorithms. The following text is a direct citation from this paper:

##  Regression-based models
<em>"Among the regression approaches, Generalized Linear Models (GLMs) and Generalized Additive Models (GAMs) are commonly used in species distribution modeling. GLMs use parametric functions such as linear or higher-degree polynomials to model the relationship between the response and predictors. GAMs use nonparametric smooth functions to allow nonlinearity in the fitted functions.</em>

<em>There are several options for fitting GLMs, with modern regularization methods often performing well (Reineking 2006). Lasso and ridge regression (L1 and L2 regularization, respectively) penalize the coefficients and shrink them toward zero (Friedman et al. 2010). This shrinkage reduces the variance of the regression model (i.e., its stability over different data samples), hence the fitted model may generalize better. Unlike ridge regression, lasso can reduce the coefficient of variables to exactly zero, de facto excluding those variables and resulting in sparser models (Hastie et al. 2009). A recent comparison showed penalized regression to perform as well as MaxEnt (Gastón and García-Viñas 2011). Since MaxEnt is often regarded as having strong predictive performance, this suggests these regularization approaches may be useful for predicting species distributions.</em>

<em>Multivariate Adaptive Regression Splines (MARS) is a flexible nonparametric regression similar to GAMs but using piecewise linear basis functions instead of smooth functions (Elith and Leathwick 2007). The complexity of the model varies with how many of these piecewise linear functions are fitted across each predictor variable, and that is determined with fast, inbuilt internal cross-validation methods. MARS fits interactions if that option is allowed (Leathwick et al. 2006); here we did not test that option.</em>

<em>MaxEnt is a popular modeling method for predicting species distributions, specifically developed for modeling presence-only species data (Phillips et al. 2006). We include it in the “regression-based” section due to its known links to regression methods, and particularly point process approaches (Renner and Warton 2013, Renner et al. 2015). MaxEnt has the flexibility to fit more or less complex models depending on the number of species records and user-defined settings. Complexity is controlled by use of transformed features of the predictor covariates (including linear, quadratic, product, hinge, and threshold) and also by choice of regularization settings (Elith et al. 2011). MaxNet is a new, alternative implementation of MaxEnt (Phillips et al. 2017), motivated by new understandings of the link between MaxEnt and Poisson point process models (Renner and Warton 2013). It uses infinitely-weighted logistic regression (Fithian and Hastie 2013) to fit the MaxEnt model and it is developed as an R package with no need for external software. Both MaxEnt and MaxNet use L1 regularization (Elith et al. 2011), similar to Lasso, but with potentially more flexible fitted functions (via transformed features).</em>

## Tree-based models
<em>Classification and regression trees are nonlinear (and nonparametric) models that recursively partition (“split”) the predictor space into sections with similar values of the response variable (Elith 2019). This is a conceptually simple method that has several advantages such as reliably selecting influential covariates and allowing automatic fitting of interactions between covariates (Strobl et al. 2009). Single trees are high-variance methods, changing with each training data set. They are also poorly suited to estimating smooth functions. This limits their predictive performance, but they are commonly used as the base learner in ensembles of trees, often highly effective for prediction (Hastie et al. 2009). Hence, here we test ensembles rather than single trees. Tree-based models are often categorized as machine-learning models.</em>

<em>In Boosted Regression Trees (BRT) hundreds to thousands of regression trees are selected into an ensemble in a forward stagewise fashion. At each step of model fitting, the algorithm focuses on the weakest parts of the model built so far (the observations that so far are not predicted accurately) by fitting each new tree to the residuals of the previously fitted trees (Elith et al. 2008). Here, we use an implementation of BRT that has been widely used in SDMs (Table 1) and that constructs the models using stochastic gradient boosting (Friedman 2002).</em>

<em>The XGBoost algorithm (Chen and Guestrin 2016) is a new and slightly different form of gradient boosting with several features intended to improve its scalability and control over-fitting (Prasad 2018). Despite the successful usage of XGBoost in other disciplines (Chen and Guestrin 2016), the application of XGBoost in species distribution modeling is rare (examples in ecology include Doren and Horton [2018], Huang et al. [2018]. and Herdter [2019]). This might be due to the fact that XGBoost is relatively new and that, as it is highly flexible, it includes many hyperparameters that need careful tuning (Muñoz-Mas et al. 2019).</em>

<em>Random Forests (RF) have become popular for SDMs. This modeling method approaches ensemble creation differently to BRT, not using a stagewise approach but instead using bagging (bootstrap aggregation) to combine many trees. Bagging involves taking many bootstrap samples from the training data, fitting a tree to each sample and making an average prediction over all fitted trees (Strobl et al. 2009). Unique to this method, RF uses only a random subset of the predictor variables (parameter mtry) on each split while growing each tree. This creates decorrelated trees and reduces the variance of the final model, with consequent gains for predictive performance (Hastie et al. 2009). An advantage of RF compared to similar methods such as BRT and XGBoost, is that it is not very sensitive to tuning the model parameters (Strobl et al. 2009, Freeman et al. 2016). These characteristics have made RF a relatively common SDM approach (Mi et al. 2017, Harris et al. 2018).</em>

<em>Conditional Inference Forest (cforest) is a variant of RF that uses a different form of decision trees called ctree (Hothorn et al. 2006). This method was originally developed to deal with known problems in common splitting methods used in recursive binary partitioning, particularly, that there is a selection bias toward predictor variables with many possible splits or with missing values. In contrast to RF, cforest does not grow trees to maximum size and instead applies a stopping criterion. The cforest model also uses subsampling without replacement instead of bootstrap sampling to calculate variable importance in an unbiased way (Hothorn et al. 2006, Strobl et al. 2008). The process of fitting ctrees is costly and, as a result, creating ensembles of many ctrees in cforest is computationally expensive.</em>

## Other models
<em>Support Vector Machine (SVM) is a nonparametric machine-learning technique for regression and classification problems that has been used for modeling species distributions (Guo et al. 2005, Drake et al. 2006, Ashraf et al. 2017). SVMs work by defining linear hyperplanes that best separate different classes in the data. Similar to linear regression models, SVM can use nonlinear forms of the predictor variables for increased flexibility. This is done through a kernel function (e.g., polynomial or radial basis; Hastie et al. 2009: chapter 12).</em>

<em>Model averaging is a popular technique for reducing the uncertainty of model predictions (Dormann et al. 2018). For SDMs, it has become popular to average across predictions from different methods, based on the idea that prediction uncertainty due to the choice of method is decreased (Araújo and New 2007). The package biomod is specifically written for modeling species distributions (Thuiller et al. 2009), building ensembles across several modeling methods. It includes 10 algorithms, some of them used in our study (including GAM, GLM, BRT, RF, and MaxEnt), and combines the prediction of these models (e.g., by weighted averaging of the predictions). The biomod model has become a popular modeling approach since the 2006 NCEAS study, with widespread use but narrower dedicated exploration of its predictive performance (Hao et al. 2019).</em>

<em>In addition to using biomod, we averaged several models to build our own “ensemble” model. We selected the component models before models were fitted and evaluated, and used no knowledge of the testing data set to select them. Given evidence in the tree ensemble literature that ensembles work best when the component models are not highly correlated (Elith 2019), we chose for our self-selected ensemble a set of models with a breadth of fitted functions and model fitting approaches. We targeted methods we expected (based on our experience) to do well. The chosen models were Lasso, GAM, MaxEnt, BRT, and one of the RF variants (down-sampled; explained in the next section). Their predictions were all rescaled between 0 and 1 and their (unweighted) average used to build the ensemble model."</em>

The above text is taken from:

Valavi, R., Guillera‐Arroita, G., Lahoz‐Monfort, J. J., & Elith, J. (2022). Predictive performance of presence‐only species distribution models: A benchmark study with reproducible code. *Ecological Monographs*, 92(1). [https://doi.org/10.1002/ecm.1486](https://doi.org/10.1002/ecm.1486)  ([CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

---
<hr style="height:3px;border:none;color:#333;background-color:#333;" />

### Exercise

#### **1. Selection**
Select **one of the algorithms** (e.g., MaxEnt, Random Forest, GLM) form the student tutorials on the next page. Coordinate with the group to minimize redundancy.

#### **2. Research** 
Analyze your modeling algorithms individually and try to understand it as good as possible. Look out for example for:
* Does it require Presence-Only, Presence-Absence, or Background data?
* How does it handle non-linear relationships or interactions?
* What are the known pitfalls (e.g., over-fitting, sensitivity to noise)?

#### **3. Pair**
Form grous of two (or three) people and explain your respective peer your model algorithm.

#### **4. Share**
We will reconvene as a full group to discuss the findings from each pair.



#### References

Kearney, M., & Porter, W. (**2009**). Mechanistic niche modelling: Combining physiological and spatial data to predict species’ ranges. *Ecology Letters*, 12(4), 334–350. [https://doi.org/10.1111/j.1461-0248.2008.01277.x](https://doi.org/10.1111/j.1461-0248.2008.01277.x) 

Jarnevich, C. S., Stohlgren, T. J., Kumar, S., Morisette, J. T., & Holcombe, T. R. (**2015**). Caveats for correlative species distribution modeling. *Ecological Informatics*, 29, 6–15. [https://doi.org/10.1016/j.ecoinf.2015.06.007](https://doi.org/10.1016/j.ecoinf.2015.06.007) 

Valavi, R., Guillera‐Arroita, G., Lahoz‐Monfort, J. J., & Elith, J. (2022). Predictive performance of presence‐only species distribution models: A benchmark study with reproducible code. *Ecological Monographs*, 92(1). [https://doi.org/10.1002/ecm.1486](https://doi.org/10.1002/ecm.1486)  ([CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)

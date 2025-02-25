---
title: Ex | Artificial landscapes
teoc: true
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'

---

### Exercise: Create Environmental Variables

Now it’s your turn! Use the code in the gist below to generate **six different environmental variables**. Ensure each variable has the **same spatial extent** so they can be combined into a single raster stack.

If any layers have a larger extent, use the function `terra::crop` to adjust them to the target area. Once all layers are aligned, save them as a single `.tif` file for easier access and sharing.



<script src="https://gist.github.com/uilehre/4713c1667fe1cea7b0bf0b5d600637ef.js"></script>

**Note:** NLMR has no support for the **terra** package yet, therefore we will transform each of the NLMs to a `spatRaster` after creating it.
{: .notice--info}

Once completed, you’ll have a comprehensive environmental dataset ready for analysis or modeling. Your dataset look somewhat like the one in the following figure (continuous variables plotted with **tidyterra** as explained in [Unit 01](../unit01/unit01-02_the_very_basics.html#advanced-visualization-optional) ):

![image](../assets/images/unit02/NLMs.png)

#### Additional learning material: Multicorrelinarity between environmental variables

In ecological modeling, researchers frequently incorporate a substantial number of environmental variables. In Species Distribution Modeling the number of variables can easily exceed 100 variables (e.g., [Bald et al. 2024](http://dx.doi.org/10.1002/ece3.11571)). This can quickly lead to a situation in which two or more predictor variables in a model are highly correlated, meaning that they provide redundant information about the variance in the outcome. This phenomenon, known as collinearity, is prevalent in ecological and environmental studies, particularly among interrelated variables such as temperature, precipitation, and humidity.

Collinearity can affect model performance by inflating metrics, which may result in the incorrect identification of important environmental predictors ([Dormann et al. 2012](https://doi.org/10.1111/j.1600-0587.2012.07348.x)). Consequently, it is advisable to evaluate the correlation among variables prior to model development. This can be done with a simple function in R. As a result, you will get a correlation matrix which shows you the positive and negative correlations between variables, along with their respective strengths. To mitigate the impact of collinearity, it is advisable to establish a threshold, (e.g., 0.8), and to exclude variables that exceed this threshold. 

For further insights into the implications of collinearity in ecological modeling, refer to the study by [Dormann et al. (2012)](https://doi.org/10.1111/j.1600-0587.2012.07348.x). 

You can use the script below to create a correlation matrix for the six NLMs we created in the esxercise above.

<script src="https://gist.github.com/uilehre/287d89fc6e3eaaec26eae32f70ac12c7.js"></script>

In the end your confusion matrix should look like this:

![image](../assets/images/unit02/cor.png)


## Further reading:
Grimmett, L., Whitsed, R., & Horta, A. (2021). Creating virtual species to test species distribution models: The importance of landscape structure, dispersal and population processes. Ecography, 44(5), 753–765. [https://doi.org/10.1111/ecog.05555](https://doi.org/10.1111/ecog.05555)

Leroy, B., Meynard, C. N., Bellard, C., & Courchamp, F. (2016). Virtualspecies, an R package to generate virtual species distributions. Ecography, 39(6), 599–607. [https://doi.org/10.1111/ecog.01388](https://doi.org/10.1111/ecog.01388)

Sciaini, M., Fritsch, M., Scherer, C., & Simpkins, C. E. (2018). NLMR and landscapetools: An integrated environment for simulating and modifying neutral landscape models in R. Methods in Ecology and Evolution, 9(11), 2240–2248. [https://doi.org/10.1111/2041-210X.13076](https://doi.org/10.1111/2041-210X.13076)

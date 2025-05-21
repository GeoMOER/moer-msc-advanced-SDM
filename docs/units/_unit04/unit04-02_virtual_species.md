---
title: LM | Virtual species
toc: true
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
  
---

Here, you'll learn how to generate virtual species for modeling purposes, which will later allow us to conduct a comprehensive comparison of species distribution models.

<!--more-->

<p style="text-align: center; font-style: italic;">
„Species distribution models (SDMs) have become one of the major predictive tools in ecology. However, multiple methodological choices are required during the modelling process, some of which may have a large impact on forecasting results. In this context, virtual species, i.e. the use of simulations involving a fictitious species for which we have perfect knowledge of its occurrence–environment relationships and other relevant characteristics, have become increasingly popular to test SDMs. This approach provides for a simple virtual ecologist framework under which to test model properties, as well as the effects of the different methodological choices, and allows teasing out the effects of targeted factors with great certainty. This simplification is therefore very useful in setting up modelling standards and best practice principles.” (<a href="https://doi.org/10.1111/ecog.04385">Meynard et al. 2019</a>)
</p>



As described in the excerpt above from the 2019 study by [Meynard et al.]( https://doi.org/10.1111/ecog.04385) virtual species have become an important tool today to evaluate and test species distribution models. To date, there are several frameworks that can be used to create virtual species. For example:
-	virtualspecies ([Leroy et al. 2016](https://doi.org/10.1111/ecog.01388))
-   sdmvspecies ([Duan et al. 2014](https://doi.org/10.1111/ecog.01080))
-	nicheA ([Qiao et al. 2015](https://doi.org/10.1111/ecog.01961))

The first two are R packages, while NicheA is a standalone Java platform. In this session, we will use the R package virtualspecies ([Leroy et al. 2016](https://doi.org/10.1111/ecog.01388)) along with previously designed neutral landscape models (NLMs) to generate virtual species distributions. The virtualspecies R package provides several methods for creating virtual species distributions, including approaches where species distributions are generated either completely at random or by defining the relationship between environmental variables through specific functions. The latter approach is more customizable but also more time consuming as the relationship of the species to each variable needs to be defined first. For those interested in a comprehensive guide, the [online tutorial]( https://borisleroy.com/virtualspecies_tutorial/) for the package provides more detailed instructions, as only a small portion of its functionality will be covered in this course. 

The general workflow that involves creating virtual species can be found in the figure below. It provides the comprehensive workflow of creating virtual species from scratch. As we only have limited time in this course, we will not be able to deal with all parts of it.
	
[![Stages involved in the simulation of a virtual species.](https://nsojournals.onlinelibrary.wiley.com/cms/asset/8305d1b7-e4b8-42c0-96d4-80ee503c6fd4/ecog12443-fig-0001-m.jpg)](https://nsojournals.onlinelibrary.wiley.com/cms/asset/8305d1b7-e4b8-42c0-96d4-80ee503c6fd4/ecog12443-fig-0001-m.jpg)
 *Image: Stages involved in the simulation of a virtual species. Image from [Meynard et al. 2019](https://doi.org/10.1111/ecog.04385).*

## Creating random virtual species

When creating virtual species, several factors can significantly impact the results and subsequent testing of SDMs. Considerations include:
1.	Niche Breadth: Does the virtual species occupy a broad or narrow ecological niche? It is a good idea to have several species with different niche breadth.
1.  Sampling Strategy: How were presence-absence points sampled? Was a sampling bias introduced, or were points sampled evenly across the landscape?
1.	Presence-Absence Conversion: How is the probability of occurrence converted to presence-absence maps? This is particularly crucial because methods used to set thresholds for presence-absence can influence model outcomes greatly.

We will begin by creating a simple, randomly generated virtual species. This function employs standard settings to generate a species using a [principal component analysis (PCA)]( https://en.wikipedia.org/wiki/Principal_component_analysis) from the environmental variables. By default, it also produces a presence-absence map for the species, utilizing the "probability" functionality where probabilities of occurrence are transformed with a logistic function. Alternatively, you can set a simple threshold to transform the probability, where values below the threshold indicate absence and values above it indicate presence.
However, it has been shown that this threshold-based approach can produce unrealistic species distributions, as real species may be absent from highly suitable areas or present in less suitable areas due to factors like biotic pressures or microclimatic conditions. For further information, refer to the dedicated [tutorial chapter by Boris Leroy]( https://borisleroy.com/virtualspecies_tutorial/04-presenceabsence.html) or the paper by [Meynard et al. (2019)](https://doi.org/10.1111/ecog.04385).

In this example code we are using the NLMs from the previous unit. If you had trouble creating some you can [download a raster stack with NLMs from the course server.](http://85.214.102.111/uploads/advancedSDM/)

<script src="https://gist.github.com/uilehre/b44cbe08f03bfb4debbb74526d06204f.js"></script>

As a result, three rasters are generated: suitability, probability of occurrence, and presence-absence rasters, as shown in the figure below. You can adjust the niche breadth to `narrow` to observe how this affects the results. It is also possible to select specific raster layers to create a random species based solely on these selected layers.

![image](../assets/images/unit02/random_sp.png)

## Create virtual species by defining response functions
The second, more complex way to define virtual species is by specifying the response of the species to each variable individually. The simplest way to illustrate this concept is with an example involving temperature. For instance, we could assume a linear relationship between the habitat suitability of the species and temperature, such that as the temperature increases, the habitat becomes less suitable for the species. However, other types of relationships are also conceivable. For example, there might be an optimal temperature range for the species, where temperatures that are too high or too low make the habitat unsuitable.

By defining these relationships, we can model different ways species respond to environmental variables. The `virtualspecies` package provides several built-in functions to simulate these species' responses to different variables. To achieve this, the variables are transformed using a function.

### Available transformations of environmental variables:
- **Linear function**: Assumes a direct relationship between the variable and suitability.
- **Quadratic function**: Models a peak or trough in the response.
- **Logistic function**: Creates an S-shaped curve, often used for threshold responses.
- **Beta response functions**: Allows for a more flexible bell-shaped curve.
- **Normal distribution**: Models a symmetrical response around an optimal value.
- **Custom function**: You can define your own mathematical function for transformations.

The figure below demonstrates how these functions can transform the environmental variable `NLM1` created in the previous session.

![image](../assets/images/unit02/functions2.png)
*Image: : The values of the variable NLM1 transformed with a linear, beta, logistic and quadratic function.* 

In this section, we will create a virtual species by defining its response to environmental variables using a custom function. To do this, we first use the function `formatFunction` to define how each environmental variable influences the species. You can work with one variable or multiple variables, but keep in mind that the more variables you include, the more complex it becomes to ensure that their suitability values do not contradict each other. Once the response functions are defined, we then specify a formula that determines how strongly each variable influences the habitat suitability of the species. This part is highly flexible, allowing you to be creative with how you combine the environmental variables. However, be sure that the variables you use in the formula correspond to the variables defined in the raster stack provided to the function and are consistent with the parameters you set. 

<script src="https://gist.github.com/uilehre/a11772a19b96224f129dd8789a2f75e9.js"></script>

The `generateSpFromFun` function does not automatically convert suitability values into presence-absence maps. To obtain the same output as with the `generateRandomSp` function, we use the `convertToPA` function for this conversion:

![image](../assets/images/unit02/function_species.png)




## Further reading

Grimmett, L., Whitsed, R., & Horta, A. (2021). Creating virtual species to test species distribution models: The importance of landscape structure, dispersal and population processes. Ecography, 44(5), 753–765. [https://doi.org/10.1111/ecog.05555](https://doi.org/10.1111/ecog.05555)

Leroy, B., Meynard, C. N., Bellard, C., & Courchamp, F. (2016). Virtualspecies, an R package to generate virtual species distributions. Ecography, 39(6), 599–607. [https://doi.org/10.1111/ecog.01388](https://doi.org/10.1111/ecog.01388)

Malinowska, K., Markowska, K., & Kuczyński, L. (2023). Making virtual species less virtual by reverse engineering of spatiotemporal ecological models. Methods in Ecology and Evolution, 14(9), 2376–2389. [https://doi.org/10.1111/2041-210X.14176](https://doi.org/10.1111/2041-210X.14176)

Meynard, C. N., Leroy, B., & Kaplan, D. M. (2019). Testing methods in species distribution modelling using virtual species: What have we learnt and what are we missing? Ecography, 42(12), 2021–2036. [https://doi.org/10.1111/ecog.04385](https://doi.org/10.1111/ecog.04385)

Qiao, H., Peterson, A. T., Campbell, L. P., Soberón, J., Ji, L., & Escobar, L. E. (2016). NicheA: Creating virtual species and ecological niches in multivariate environmental scenarios. Ecography, 39(8), 805–813. [https://doi.org/10.1111/ecog.01961](https://doi.org/10.1111/ecog.01961)

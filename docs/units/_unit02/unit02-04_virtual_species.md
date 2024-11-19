---
title: Virtual species
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
  
---
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

<script src="https://gist.github.com/uilehre/b44cbe08f03bfb4debbb74526d06204f.js"></script>

As a result, three rasters are generated: suitability, probability of occurrence, and presence-absence rasters, as shown in the figure below. You can adjust the niche breadth to `narrow` to observe how this affects the results. It is also possible to select specific raster layers to create a random species based solely on these selected layers.

![image](../assets/images/unit02/random_sp.png)

## Create virtual species by defining response functions

The second, more complex way, to define virtual species is by defining each response frunction

The following transformations of the environmental variables are possible:
* linear function
* Quadratic function
* Logistic function
* beta response functions
* normal distribution
* or you can write your own function

How these functions transform the environmental variable NLM1 we created in the last session can be seen in the figure below:


![image](../assets/images/unit02/functions2.png)
*Image: 


<script src="https://gist.github.com/uilehre/a11772a19b96224f129dd8789a2f75e9.js"></script>

![image](../assets/images/unit02/function_species.png)
*Image: 

 Tip:
 It might be a good idea to plot the reponse function of the vairbales bevore creating the species to get an idea about how the differnet repionseesy will interact and what this means for the species. If you transform the values completely out of the  range of a species there might be no suitability. 

<script src="https://gist.github.com/uilehre/0596a1a215b61256d3e0a3d2cfead7b1.js"></script>


## Further reading

Grimmett, L., Whitsed, R., & Horta, A. (2021). Creating virtual species to test species distribution models: The importance of landscape structure, dispersal and population processes. Ecography, 44(5), 753–765. [https://doi.org/10.1111/ecog.05555](https://doi.org/10.1111/ecog.05555)

Leroy, B., Meynard, C. N., Bellard, C., & Courchamp, F. (2016). Virtualspecies, an R package to generate virtual species distributions. Ecography, 39(6), 599–607. [https://doi.org/10.1111/ecog.01388](https://doi.org/10.1111/ecog.01388)

Malinowska, K., Markowska, K., & Kuczyński, L. (2023). Making virtual species less virtual by reverse engineering of spatiotemporal ecological models. Methods in Ecology and Evolution, 14(9), 2376–2389. [https://doi.org/10.1111/2041-210X.14176](https://doi.org/10.1111/2041-210X.14176)

Meynard, C. N., Leroy, B., & Kaplan, D. M. (2019). Testing methods in species distribution modelling using virtual species: What have we learnt and what are we missing? Ecography, 42(12), 2021–2036. [https://doi.org/10.1111/ecog.04385](https://doi.org/10.1111/ecog.04385)

Qiao, H., Peterson, A. T., Campbell, L. P., Soberón, J., Ji, L., & Escobar, L. E. (2016). NicheA: Creating virtual species and ecological niches in multivariate environmental scenarios. Ecography, 39(8), 805–813. [https://doi.org/10.1111/ecog.01961](https://doi.org/10.1111/ecog.01961)

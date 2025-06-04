---
title: "LM | Research gaps in SDM"
toc: true
header:
  image: '/assets/images/teaserimages/ai.png'
  caption: '[Marco Verch via ccnull.de](https://ccnull.de/foto/kuenstliche-intelligenz-bei-der-arbeit/1095606). [CC-BY 2.0](https://creativecommons.org/licenses/by/2.0/de/). Image cropped.'
---


This page serves as a resource to inspire your research projects in the field of SDM. You will find an overview of key research gaps, relevant studies, and methodological challenges that can help guide your work. While this list is not exhaustive, it highlights several areas where further research is needed and offers a starting point for identifying potential directions for your project.

## Identified Research Gaps

As already mentioned earlier in this course some research gaps were already identified in the comment from [Boris Leroy 2022](https://doi.org/10.1111/jbi.14505), on the state of the art of species distribution modeling:  &#x20;


[![](https://onlinelibrary.wiley.com/cms/asset/9ed9242b-6282-4326-bfd0-c1de0e6f2c47/jbi14505-fig-0001-m.png)](https://doi.org/10.1111/jbi.14505)

**Figure:** *Choosing presence-only species distribution models. Source: Boris Leroy 2022, [https://doi.org/10.1111/jbi.14505](https://doi.org/10.1111/jbi.14505).*



A good starting point for you to understanding the challenges in the performance of different SDM methods is to review benchmark studies. For instance, Valavi et al. ([2022](https://doi.org/10.1002/ecm.1486), [2023](https://doi.org/10.1111/geb.13639)) have conducted extensive research comparing different modeling methodologies. Their work provides insights into the advantages and limitations of different methods, and highlights ensemble models as the top performing method.

You could further explore ensemble models for SDM by investigating the performance of different ensemble approaches or identifying the most effective methods for constructing high-performing models. To gain deeper insights into the topic, you may also refer to the study by [Hao et al. 2019](https://doi.org/10.1111/ddi.12892).
### SDM benchmark studies

Valavi, R., Elith, J., Lahoz‐Monfort, J. J., & Guillera‐Arroita, G. (2023). **Flexible species distribution modelling methods perform well on spatially separated testing data.** Global Ecology and Biogeography, 32(3), 369–383. [https://doi.org/10.1111/geb.13639](https://doi.org/10.1111/geb.13639)

Valavi, R., Guillera‐Arroita, G., Lahoz‐Monfort, J. J., & Elith, J. (2022). **Predictive performance of presence‐only species distribution models: A benchmark study with reproducible code.** Ecological Monographs, 92(1), e01486. [https://doi.org/10.1002/ecm.1486](https://doi.org/10.1002/ecm.1486)


## Species Richness and Joint SDM  

Beyond single-species models, you can explore alternative SDM approaches that provide broader ecological insights. One such approach is species richness modeling, which predicts biodiversity patterns by modeling multiple species within a given area of interest rather than focusing on individual occurrences. Additionally, joint species distribution modeling (JSDM) represents an entire subfield dedicated to incorporating species interactions, thereby enhancing predictive accuracy and ecological realism.  

## Reading Material  

Benito, B. M., Cayuela, L., & Albuquerque, F. S. (2013). **The impact of modelling choices in the predictive performance of richness maps derived from species‐distribution models: Guidelines to build better diversity models.** Methods in Ecology and Evolution, 4(4), 327–335. [https://doi.org/10.1111/2041-210x.12022](https://doi.org/10.1111/2041-210x.12022)


Wilkinson, D. P., Golding, N., Guillera‐Arroita, G., Tingley, R., & McCarthy, M. A. (2019). **A comparison of joint species distribution models for presence–absence data.** Methods in Ecology and Evolution, 10(2), 198–211. [https://doi.org/10.1111/2041-210X.13106](https://doi.org/10.1111/2041-210X.13106)

Wilkinson, D. P., Golding, N., Guillera‐Arroita, G., Tingley, R., & McCarthy, M. A. (2021). **Defining and evaluating predictions of joint species distribution models.** Methods in Ecology and Evolution, 12(3), 394–404. [https://doi.org/10.1111/2041-210X.13518](https://doi.org/10.1111/2041-210X.13518)



## Practical tips

Creating a flowchart of your entire workflow can be extremely beneficial. A well-structured diagram will help ensure that no critical steps are overlooked while also providing a clear visual representation of the research process. This will also help you to better assess the workload of your research project.


### Addressing Your Research Question Using Virtual Species

This can be achieved using the `terra` package, where the `layerCor()` function allows you to calculate the correlation between two raster layers, providing a quantitative measure of similarity. To visually assess the differences, you can compute the absolute difference between corresponding pixels in the two rasters, highlighting spatial discrepancies in predicted and actual distributions.
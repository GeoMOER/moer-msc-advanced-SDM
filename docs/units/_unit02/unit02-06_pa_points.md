---
title: Sample Presence-Absence Points
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
---

For this course, we want to sample presence-absence points instead of presence-only points for all virtual species. We will again use the `virtualspecies` R package for this. The function `sampleOccurrences` can be used to do this task. It allows you to define how many points (`n`) you want to sample, and whether you want to sample the same number of presence and absence data points, which is referred to as `sample prevalence`. 


<script src="https://gist.github.com/uilehre/cfc5b99272f681e56dd34ed72fdfc06b.js"></script>

The sample prevalence is a number between 0 and 1. Higher values indicate a larger proportion of presence data in the presence-absence dataset. You can see the results in the image below.


![image](../assets/images/unit02/pa_sampling1.png)

## Restricting sampling areas

Apart from adjusting sample prevalence and the number of points to be sampled, many more options are available to customize the sampling of presence-absence data. In real-world scenarios, it is highly unlikely that the entire study area will be sampled. Most of the time, sampling is limited to specific regions. To demonstrate this, we will restrict our sampling area using the `blockCV` R package ([Valavi et al. 2019](https://doi.org/10.1111/2041-210X.13107)). 

The `blockCV` package is primarily designed for spatial cross-validation which means it can be used for creating spatial blocks around presence-only or presence-absence data. This makes it also a good tool for defining polygons for biased sampling of presence-absence data. To achieve this, we will first sample random background points across the study area and then create spatial blocks. Several options for block shapes are available, as shown in the image below. We will create polygons using squares, hexagons, and bars across the study area. The `size` argument allows you to specify the size of each individual block.

<script src="https://gist.github.com/uilehre/744869b31ab439b84f7e27cd7d5a00b0.js"></script>

In the following figure, you can see the results of using different polygon shapes to create spatial blocks across the study area.


![image](../assets/images/unit02/samplingPolygons.png)

Most of the time, real-world sampling areas are not perfectly symmetrical. You could use tools like QGIS to draw custom polygons that result in less symmetrical shapes. In this session however, we will use the last block type, hexagons, to sample our presence-absence points in just a few regions. For this, we use the polygons created with the `blockCV` package and sample occurrences only within a subset of these polygons.

![image](../assets/images/unit02/samplingBias.png)


## Introducing further sampling bias




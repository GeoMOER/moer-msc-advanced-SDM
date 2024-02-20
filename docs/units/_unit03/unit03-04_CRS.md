---
title: "Coordinate Reference Systems"
header:
  image: '/assets/images/teaserimages/world_temp.png'
  caption: '[Environmental Informatics Marburg](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

An integral part of all spatial data is the coordinate reference system (CRS), which is used to define meaningful distances between data points irrespective of their values.
Distances become meaningful as soon as the origin of a particular reference system and its units are known.
The origin of a CRS may lie at Earth's gravity center or at some other arbitrarily defined location.
The units of a CRS can be meters, kilometers, degrees or some other arbitrarily defined variables.

In practice, a CRS is used to represent vector or raster data in some geographical space, e.g. on Earth. 
Unfortunately, Earth is 3-dimensional (at least) and most media for representing space is 2-dimensional or planar (like paper and computer screens).
This causes a lot of trouble because it makes a 3D to 2D transformation or _projection_ necessary. 



<!--
## Projections
plag RSpatial

A major question in spatial analysis and cartography is how to transform this three dimensional angular system to a two dimensional planar (sometimes called “Cartesian”) system. A planar system is easier to use for certain calculations and required to make maps (unless you have a 3-d printer). The different types of planar coordinate reference systems are referred to as ‘projections’. Examples are ‘Mercator’, ‘UTM’, ‘Robinson’, ‘Lambert’, ‘Sinusoidal’ ‘Robinson’ and ‘Albers’.

There is not one best projection. Some projections can be used for a map of the whole world; other projections are appropriate for small areas only. One of the most important characteristics of a map projection is whether it is “equal area” (the scale of the map is constant) or “conformal” (the shapes of the geographic features are as they are seen on a globe). No two dimensional map projection can be both conformal and equal-area (but they can be approximately both for smaller areas, e.g. UTM, or Lambert Equal Area for a larger area), and some are neither.

plag
-->


## Geographic CRS

A geographic CRS is used to identify any location on Earth with two coordinates, namely _latitude_ and _longitude_.
Latitude describes the angular distance from the Equatorial plane based on a 3-dimensional spherical or ellipsoidal model of the Earth.
Longitude describes the angular distance from the Prime Meridian plane in Greenwich, UK.
A projected CRS is based on calculated 2-dimensional Cartesian coordinates, which are linked to real 3-dimensional locations on Earth by a mathematical model.


{% include figure image_path="/assets/images/sphere_RSpatial.png" caption="Angular geographic coordinate system. Source: www.rspatial.org" %}




### CRSs and projections in R
CRSs and projections can be defined in R by an [epsg](https://spatialreference.org/ref/epsg/){:target="_blank"} code or by a [proj4string](https://proj.org/usage/projections.html){:target="_blank"} character string.



## More information

For more detailed (and better) information see [www.rspatial.org](https://rspatial.org/raster/spatial/6-crs.html#){:target="_blank"} and 
[Geocomputation with R](https://geocompr.robinlovelace.net/spatial-class.html#crs-intro){:target="_blank"}





## Comments?
You can leave comments under this issue if you have questions or comments about the content on this page. Please copy the corresponding line into your comment to make it easier to answer the question. 



<script src="https://utteranc.es/client.js"
        repo="GeoMOER/moer-bsc-project-seminar-SDM"
        issue-term="unit03-04_CRS"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>

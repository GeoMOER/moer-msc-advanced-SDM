---
title: "Overview"
header:
  image: '/assets/images/teaserimages/world_temp.png'
  caption: '[Environmental Informatics Marburg](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

Get a brute-force introduction to working with different kinds of spatial data in R.

<!--more-->


## Learning objectives
At the end of this unit you should be able to

* distinguish between raster and vector data,
* know the basics for using coordinate reference systems in R, 
* know how to read in and write out spatial data, and
* apply some basic vector and raster data manipulations.


## Data Models

Reality has far too much information and to is too complex to be fully represented by data.
The basis for the reduction of complexity are data models. A data model is formed by the abstraction of individual objects (entities) and their properties (attributes). 
In this abstraction process, the same object types are bundled (e.g. rivers, roads, urban areas).
In the spatial data world and its implication in GIS, two completely different data models have been established for this purpose, which are called _raster model_ and _vector model_. 
Both data models are principally usable for the representation of continuous properties as well as for discrete (geo-) objects. 
In practice, however, continuous data is usually represented by the raster model and discrete data by the vector model.


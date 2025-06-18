---
title: R packages on OPSI PCs
header:
  image: "/assets/images/teaserimages/birds_teaser.png"
  caption: 'Image: [Kostenlose Bilder mit KI via flickr](https://www.flickr.com/photos/ai_universe/53440008559/); [CC BY 2.0 DEED](https://creativecommons.org/licenses/by/2.0/); image cropped'
toc: true
---

if you are having trouble to install packages at the university PCs that run OPSI you can try to follow the guide [on this page](https://geomoer.github.io/moer-spotlights/unit02/unit02-01_opsi.html).

### Install packages for Advanced SDM

To install the packages from the course try:

In this order (when prompted: updates of dependencies conservatively preferably only via CRAN, for now)
```r 
remotes::install_version("RandomFieldsUtils", version = "1.2.5")
remotes::install_version("RandomFields", version = "3.3.14")
remotes::install_version("landscapetools", version = "0.5.0")
remotes::install_version("spatstat.core", version = "2.4-4")
remotes::install_version("NLMR", version = "1.1")

library("RandomFieldsUtils")
library("RandomFields")
library("landscapetools")
library("spatstat.core")
library("NLMR")
```
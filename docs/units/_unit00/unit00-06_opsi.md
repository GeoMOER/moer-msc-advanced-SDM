---
title: R packages on OPSI PCs
header:
  image: "/assets/images/teaserimages/birds_teaser.png"
  caption: 'Image: [Kostenlose Bilder mit KI via flickr](https://www.flickr.com/photos/ai_universe/53440008559/); [CC BY 2.0 DEED](https://creativecommons.org/licenses/by/2.0/); image cropped'
toc: true
---



### Install R packages on OPSI PCs in your own account

Required: University computer and account
Target: R environment in the university user account, regardless of the university computer currently in use


1. Ask R where it currently installs and searches for packages:
```r
.libPaths() # First entry by default on C:/something -> not in the H: drive and therefore not in the Acount but locally on the computer.
```

2. Create your own R package folder on H: (creating once is sufficient):
```r
mypath <- "H:/R/win-library"
dir.create(mypath, recursive = TRUE, showWarnings = TRUE)
```

3. Set up R permanently in such a way that packages are installed and loaded there by making an entry in the .Rprofile file
Create (or edit) a file with the name .Rprofile in the home directory (H:/Documents/.Rprofile) with the following content:
```r
.libPaths("H:/R/win-library")
```
If you already have an .Rprofile, add this line without deleting any other content.
If you do not write this line in .Rprofile and/or the .Rprofile file is in the “wrong” place, the setting will be lost every time R is restarted.


4. check: Should now show H:/R/win-library in the first position, even after restarts and also on other computers.
```r
.libPaths()
```

### Install packages in general

Classic via CRAN
```r
?install.packages()
```

Latest development versions (often unstable) via GitHub
```r
?devtools::install_github()
```

Previous versions
```r
?remotes::install_version()
```

### Install packages for Advanced SDM

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

### RTools installation

Why? Necessary if packages do not have to be installed via CRAN, e.g. via `devtools::install_github()`

Download the appropriate RTools version from [https://cran.r-project.org/bin/windows/Rtools/](https://cran.r-project.org/bin/windows/Rtools/)
Appropriate means matching the R version. The R version appears at the top of the console when you open Rstudio, e.g. 4.4.3 (-> then select Rtools 4.4)

Installation in the folder suggested by Rtools (C:/) is possible, but is then only available on the local computer. Then it has to be executed once on each university computer















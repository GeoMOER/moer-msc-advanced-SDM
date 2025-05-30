---
title: "A | Assignment: 03"
toc: true
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
  
---

In this assignment you will use your knowledge from the previous session to create your own little kingdom. Which mean you will now create a country with neutral landscape models. 
In this assignment, you will harness the skills and concepts learned in the previous session to go on a creative journey: designing your own artificial country. Using Neutral Landscape Models (NLMs), you will generate a diverse and unique landscape.
<!--more-->


![image](../assets/images/unit02/realm.jpg)
*Image: Generated with [deepai.org](https://deepai.org/machine-learning-model/cyberpunk-generator)*


{% capture Assignment-1-1 %}
Please do the following exercises until the next session:

1. Generate a total of 12 **different** NLMs.
1. Create at least three NLMs with different ranges of spatial autocorrelation [(see Grimmmet et al. 2021)]( https://doi.org/10.1111/ecog.05555)
1. Stack all generated layers together into one `SpatRaster`
1. Come up with a name for your country.
1. Name each layer in consecutive order, following this format: `countryname1`, `countryname2`, `countryname3`, ..., `countryname20`.
1. Save the layers as a single `.tif` file using the naming convention: `countryname.tif`.
1. Check the multicollinearity of your layers.
1. Upload the `.tif` file to ILIAS along with a `PDF` file that briefly describes the layers of your artificial landscapes and also add information on multicorrelinearity. (If the .tif file is to large only upload the PDF)


**Note2:** Have a look at the [vignette](https://ropensci.github.io/NLMR/index.html) of NLMR for help and inspiration. 

{% endcapture %}
<div class="notice--success">
  {{ Assignment-1-1 | markdownify }}
</div> 

<!--
### Further development of your artificial landscape (Optional!)
If you want to give your virtual country an even more realistic feel to it you can als create a border and crop it to it. This can be done for example with loading the .tif file in a GIS software (like QGIS) and drawing a polygon of the country borders. Another way to do this is with the code snippet below. If you do this also upload a `.gpkg` of your border to ILIAS and crop your virtual landscapes to the border bevore you upload it. This is completely optional.

<script src="https://gist.github.com/uilehre/e8328e3202f660213498298e43f3cca9.js"></script>

In the end your landscape with border could look like this:

![image](../assets/images/unit02/border.png)

-->

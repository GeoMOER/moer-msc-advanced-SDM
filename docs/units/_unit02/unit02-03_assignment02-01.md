---
title: "Assignment: 02-01"
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: 'Generated with [deepai.org](https://deepai.org/machine-learning-model/cyberpunk-generator){:target="_blank"}'
  
---

In this assignment you will use your knowledge from the previous session to creste your own little kingdom. Which mean you will now create a country with neutral landscape models. 
In this assignment, you will harness the skills and concepts learned in the previous session to go on a creative journey: designing your own artificial country. Using Neutral Landscape Models (NLMs), you will generate a diverse and unique landscape that represents your artificial country.
<!--more-->



![image](../assets/images/unit02/realm.jpg)
*Image: Generated with [deepai.org](https://deepai.org/machine-learning-model/cyberpunk-generator)*

{% capture Assignment-1-1 %}
Please do the following exercises until the next session:

1. You may choose to work individually or in teams of up to two people.
1. Generate a total of 12 **different** NLMs.
1. Stack all generated layers together into one `SpatRaster`
1. Come up with a name for your country.
1. Name each layer in consecutive order, following this format: `countryname1`, `countryname2`, `countryname3`, ..., `countryname20`.
1. Save the layers as a single `.tif` file using the naming convention: `countryname.tif`.
1. save the layers as one `.tif` file using the following naming convention: name.tif
1. Upload the `.tif` file to ILIAS along with a `PDF` file that briefly describes your artificial landscapes.


**Note:** When you upload your data make sure you add both your names if you work in teams.

**Note2:** Have a look at the [vignette](https://ropensci.github.io/NLMR/index.html) of NLMR for help and inspiration. 

{% endcapture %}
<div class="notice--success">
  {{ Assignment-1-1 | markdownify }}
</div> 

### Further development of your artificial landscape (Optional!)
If you want to give your virtual country an even more realistic feel to it you can als create a border and crop it to it. This can be done for example with loading the .tif file in a GIS software (like QGIS) and drawing a polygon of the country borders. Another way to do this is with the code snippet below. If you do this also upload a `.gpkg` of your border to ILIAS and crop your virtual landscapes to the border bevore you upload it. This is completely optional.

<script src="https://gist.github.com/uilehre/e8328e3202f660213498298e43f3cca9.js"></script>

In the end your landscape with border could look like this:

![image](../assets/images/unit02/border.png)
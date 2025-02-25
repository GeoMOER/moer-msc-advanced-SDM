---
title: "A | Assignment: 04-01"
toc: true
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
  
---

In this assignment we will use everything we have learnt so far in unit 02 to create virtual species. We will use the NLMs as environmental variables and the different functionalities from the `virtualspecies` R package to create virtual species for each of your previously designed study areas.
<!--more-->

![image](../assets/images/unit02/virtualspecies.png)
*Image: Virtual species. Generated with [deepai.org](https://deepai.org/machine-learning-model/cyberpunk-generator)*

{% capture Assignment-1-1 %}
Do the following exercises until the next session:

1. You may choose to work individually or in teams of up to two people.
1. Use the 12 NLMs you prepared in the last exercise as environmental variables.
1. create in total 5 virtual species. Create them by defining the response function for each variable individually using the function `generateSpFromFun`. 
1. Transform the environmental suitability to presence-absence maps using the `convertToPA`function using the `logistic` transformation.
1. Give each species a name (e.g., species1, species2, species3, …)
1. Save the virtual species data as follows: Create a list where the first element contains the virtual species data and the second element contains the transformed presence-absence data. Save this list as an `RDS` file.
<script src="https://gist.github.com/uilehre/5aff31a058be85464d7ffb573a006d41.js"></script>
1. You don’t need to upload your results to ILIAS yet, as we will add more data to them in the next session. However, you will need the results of this assignment in the next session and cannot proceed without them.

{% endcapture %}
<div class="notice--success">
  {{ Assignment-1-1 | markdownify }}
</div>

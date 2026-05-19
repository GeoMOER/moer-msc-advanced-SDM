---
title: "A | Assignment: 06"
toc: true
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
  
---

In this assignment we will use everything we have learnt so far in unit 06 to create virtual species. We will use the bioclim as environmental variables and the different functionalities from the `virtualspecies` R package to create virtual species.


<!--more-->

![image](../assets/images/unit02/virtualspecies.png)
*Image: Virtual species. Generated with [deepai.org](https://deepai.org/machine-learning-model/cyberpunk-generator)*

{% capture Assignment-1-1 %}
Do the following exercises until the next session:

### Create virtual species

1. You may choose to work individually or in teams of up to two people.
1. Use the bioclimatic variables from the WorldClim dataset. Select a specific country, continent, or region of the world and download the corresponding WorldClim data.
1. Create in total **3** virtual species if you are working alone or **6** if you are working in a team. Create them by defining the response function for each variable individually using the function `generateSpFromFun`. 
1. Transform the environmental suitability to presence-absence maps using the `convertToPA`function using the `logistic` transformation.
1. Give each species a name (e.g., species1, species2, species3, …)
1. Save the virtual species data as follows: Create a list where the first element contains the virtual species data and the second element contains the transformed presence-absence data. Save this list as an `RDS` file.
<script src="https://gist.github.com/uilehre/5aff31a058be85464d7ffb573a006d41.js"></script>


### Sample presence-absence data

For each virtual species generate a dataset containing sampled presence-absence points. Follow these steps:

1. **Sample Presence-Absence Points**  
   - For each species, sample varying amounts of presence-absence points.  
   - Ensure diversity in dataset sizes: some species should have large datasets, while others should have smaller ones.

2. **Introduce Spatial Sampling Bias**  
   - For at least one species, introduce spatial sampling bias by limiting the sampled points to specific regions.

3. **Add Additional Sampling Bias**  
   - Incorporate other forms of bias, such as introducing an error probability in the presence-absence data for selected species.

4. **Update the Virtual Species `.RDS` File**  
   - Add the generated datasets to the `.RDS` file of virtual species.  
   - Use the following script as a reference for modifying the `.RDS` file:  
     <script src="https://gist.github.com/uilehre/a9e6fe7390af2636ddfcf9cf1cbb100b.js"></script>

5. **Prepare Files for Submission**  
   - Compress all `.RDS` files of the virtual species into a single `.zip` archive.  
   - Create a `PDF` document describing each species, including details such as:
     - Niche breadth.
     - Environmental variables used.
     - Response functions of the species to environmental variables.
     - Error probabilities in the sampled presence-absence points.  
   - Upload the `.zip` file and the `PDF` document to ILIAS.

If you are working in teams of two make sure to add both of your names.

{% endcapture %}
<div class="notice--success">
  {{ Assignment-1-1 | markdownify }}
</div>

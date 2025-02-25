---
title: "A | Assignment: 04-02"
toc: true
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
  
---


{% capture Assignment-1-1 %}
For all virtual species created during this session, generate a dataset containing sampled presence-absence points. Follow these steps:

1. **Sample Presence-Absence Points**  
   - For each species, sample varying amounts of presence-absence points.  
   - Ensure diversity in dataset sizes: some species should have large datasets, while others should have smaller ones.

2. **Introduce Spatial Sampling Bias**  
   - For at least some species, introduce spatial sampling bias by limiting the sampled points to specific regions.

3. **Add Additional Sampling Bias**  
   - Incorporate other forms of bias, such as introducing an error probability in the presence-absence data for selected species.

4. **Update the Virtual Species `.RDS` File**  
   - Add the generated datasets to the `.RDS` file of virtual species created in the previous session.  
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


{% endcapture %}
<div class="notice--success">
  {{ Assignment-1-1 | markdownify }}
</div>


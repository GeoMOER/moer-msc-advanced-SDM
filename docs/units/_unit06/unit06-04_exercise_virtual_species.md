---
title: EX | Virtual species
toc: true
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
  
---




## Exercise


Plot the habitat suitability response curves for different transformation functions and observe how they change as you adjust the values. Each course participant should choose one transformation function (e.g., `linear`, `logistic`, or `beta`) and read the corresponding help page to understand how it works. Experiment with plotting the response curve for your chosen function and explain how the parameters (e.g., `p1`, `p2`, `alpha`, `gamma` in the beta function) influence the shape and results of the curve. Explain the behavior of the functions to your peers.



**Note:** It may in general be helpful to first plot the response functions of the environmental variables before creating virtual species. This approach will give you an idea of how the different responses interact with the environmental variables and how they affect the habitat suitability for the species. Here is some basic code to help you get started with plotting the response function:
{: .notice--info}


```r
## Plot

# Load the necessary library for plotting
library(ggplot2)

# Extract the values from the environmental variable raster using the terra package
v = terra::values(r$bio_1)

# --- Subsample change starts here ---
# Keep only non-NA values and take a random subsample of 50,000 points
v <- na.omit(v)
v <- sample(v, size = min(50000, length(v)))
# --- Subsample change ends here ---

# Apply the quadratic response function from the virtualspecies package to the environmental variable values (v)
q1 <- virtualspecies::quadraticFun(v, a = -1, b = 1, c = 0.8)

# Create a plot using ggplot2 to visualize the relationship between the environmental variable values and species suitability
# The x-axis represents the environmental variable values (v), and the y-axis represents the suitability values (q1)
ggplot(data.frame(x = v, y = q1), aes(x = v, y = q1)) +
  geom_point(color = rgb(0.4, 0.4, 0.8, 0.6), size = 2) +  # Plot the points with a semi-transparent color and size 2
  labs(x = "Value range environmental variable", 
       y = "Suitability for species",  # Labels for the x and y axes
       title = "Quadratic function")  # Title of the plot

# Note: if your rasters are very large it can take a while. You can also do it on a subsample. 
```


## Further reading

Grimmett, L., Whitsed, R., & Horta, A. (2021). Creating virtual species to test species distribution models: The importance of landscape structure, dispersal and population processes. Ecography, 44(5), 753–765. [https://doi.org/10.1111/ecog.05555](https://doi.org/10.1111/ecog.05555)

Leroy, B., Meynard, C. N., Bellard, C., & Courchamp, F. (2016). Virtualspecies, an R package to generate virtual species distributions. Ecography, 39(6), 599–607. [https://doi.org/10.1111/ecog.01388](https://doi.org/10.1111/ecog.01388)

Malinowska, K., Markowska, K., & Kuczyński, L. (2023). Making virtual species less virtual by reverse engineering of spatiotemporal ecological models. Methods in Ecology and Evolution, 14(9), 2376–2389. [https://doi.org/10.1111/2041-210X.14176](https://doi.org/10.1111/2041-210X.14176)

Meynard, C. N., Leroy, B., & Kaplan, D. M. (2019). Testing methods in species distribution modelling using virtual species: What have we learnt and what are we missing? Ecography, 42(12), 2021–2036. [https://doi.org/10.1111/ecog.04385](https://doi.org/10.1111/ecog.04385)

Qiao, H., Peterson, A. T., Campbell, L. P., Soberón, J., Ji, L., & Escobar, L. E. (2016). NicheA: Creating virtual species and ecological niches in multivariate environmental scenarios. Ecography, 39(8), 805–813. [https://doi.org/10.1111/ecog.01961](https://doi.org/10.1111/ecog.01961)

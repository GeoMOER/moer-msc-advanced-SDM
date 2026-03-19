---
title: Your research project
toc: true
header:
  image: '/assets/images/teaserimages/ai.png'
  caption: '[Marco Verch via ccnull.de](https://ccnull.de/foto/kuenstliche-intelligenz-bei-der-arbeit/1095606). [CC-BY 2.0](https://creativecommons.org/licenses/by/2.0/de/). Image cropped.'
---


Now, you will create your own research project. Decide on a question and answer it by modeling species distributions with virtual species. This project will be your marked assignment (Prüfungsleistung).
<!--more-->


## Project Overview

In your final project you will compare different species distribution models with virtual species. You should choose a research question in which you need the virtual species to answer it. Use the data that you have created, as well as the data shared by your peers. If you want to do a project without the virtual species, please talk to your course instructors first.

For the project, you will need to:

1. **Select a research question**: Decide on a question that can be answered using the virtual species. You can work in groups of two people on one research questions.
2. **Use virtual species**: You are expected to create species distribution models using the virtual species data. This includes both the species you have created and those from your peers.
3. **Literature research**: While we provide some initial research ideas, you are encouraged to conduct your own literature review. You can also refer to additional reading materials listed on the next page for inspiration.

We have provided some ideas for research questions for both Bachelor's and Master's level projects, so please choose a research question that aligns with your course level. Do not worry we will give you feedback if your research question will be achievable for your skill level.

## Inspiration for Your Research Project

### Bachelor's Level

At the Bachelor's level, a good starting point could be something like a method comparison. Here, you could:

- **Compare different SDM methods**: Train at least 3 to 5 different species distribution models (e.g., Random Forest, MaxEnt, Boosted Regression Trees) using the virtual species. Compare and contrast the results, and analyze how each method performs across different species.
  

### Master's Level

At the Master's level, we encourage you to engage with more advanced comparisons. Here are a few ideas:

- **Benchmark study reproducibility**: Reproduce the results from a [published benchmark study](https://doi.org/10.1002/ecm.1486) using the virtual species. Your task will be to understand and apply the techniques from the study to the virtual species dataset and then compare the outcome.
  
- **Spatial cross-validation approaches**: Explore different spatial cross-validation methods. For example, experiment with [block cross-validation](https://doi.org/10.1111/2041-210X.13107) using varying fold sizes, shapes, and cluster distributions. Do the results differ with different block sizes? If they do, in what ways do they differ?
  
- **Background points experimentation**: Vary the number and distribution of background points in your models. Background points are critical for defining the environmental extent in which the species may occur. Test if changing the number or distribution of these points can influence your model results. You can have a look at random background points, [target-group background]( https://doi.org/10.1890/07-2153.1) or [conditioned latin hypercube sampling]( http://dx.doi.org/10.1002/ece3.10635).

## Tips to reduce stress

- **Start early**: The project may require a considerable amount of time, so it is important to start as early as possible. 
- **Be reproducible**: Ensure your code and analysis are reproducible. This will not only help in producing reliable results but will also make it easier for others to follow and understand your process.
- **Collaborate**: Work with your peers to exchange ideas and insights. Collaboration can be incredibly beneficial when tackling complex research questions.


Good luck with your research project!
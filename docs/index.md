---
title: Advanced Species Distribution Modeling
layout: splash
date: '2024-02-15 13:00:00 +0100'
header:
  overlay_color: "#000"
  overlay_filter: 0.6
  overlay_image: "/assets/images/titleimage/birds.png"
  caption: 'Image: [Kostenlose Bilder mit KI via flickr](https://www.flickr.com/photos/ai_universe/53440008559/); [CC BY 2.0 DEED](https://creativecommons.org/licenses/by/2.0/); image cropped'
  cta_label: Go to course units
  cta_url: "/units.html"
excerpt: Create virtual species, dive deep into the world of SDM and work on experimental research questions.
feature_row_intro:
- excerpt: Course of the Department of [Physical Geography](https://www.uni-marburg.de/en/fb19/disciplines/physisch){:target="_blank"} at [Marburg University](https://www.uni-marburg.de/en){:target="_blank"}
feature_row_ilos:
- image_path: "/assets/images/envobs_ilos.jpg"
  alt: PC monitor laying in the garden of the institute.
  title: Intended learning outcomes
  excerpt: "Template..."
---

 
{% include feature_row id="feature_row_intro" type="center" %}

Species distribution modelling (SDM) is a key competence for ecogeographical research and applied nature conservation. 
It allows researchers to estimate current distributions of species and to also predict their future distributions under climate change scenarios. However, SDM is a dynamic field characterized by rapid advancements and many uncertainties.

This course will go beyond the basic SDM knowledge and will delve into all the small and very specific challenges it presents. Participants will gain ability in generating virtual species, critically evaluating the selection of environmental predictors, identifying knowledge gaps in the field, and independently constructing and fine-tune SDMs. The main focus of the course will be on generating an experimental research setup in which we will tackle some of the uncertainties. 


# Intended learning outcomes
At the end of this course you should

* be familiar with virtual species and gained the ability to generate them.
* have explored the impact of selecting environmental predictors on SDM.
* be able to identified gaps in current knowledge within a specific field of research.
* be able to independently constructed your own SDMs.
* engaged with various machine learning strategies including tuning, variable selection, training, testing, and validation techniques.
* have designed, executed, and analyzed your own scientific experiments.
* have developed awareness regarding the capabilities and limitations of SDMs.


# Course features

This course is intended as a blended learning module in our study program although the provided introductions, explanations and examples might be useful for self-study, too.

This course will take place in the classroom (**building | room**). The first session will take place **on weekday DD.MM.YYYY at HH:MM am**.
Course material will be provided in the [Ilias course environment](https://ilias.uni-marburg.de/goto.php?target=crs_3203176){:target="_blank"} (only accessible for members of the course who are logged-in into Ilias). 
{: .notice--info}


# Course times

Weekday hh:mm - hh:mm.


# Syllabus

| Session |  Date | Topic                        | Content                                                                          |
|---------|-------|------------------------------|----------------------------------------------------------------------------------|
||| **SDM Basics** ||
| 01 | DD.MM.YYYY | Spatial data in R basics              | Course introduction, expectations, organisational matters, R, R Studio, R Markdown, GitHub     |
| 02 | DD.MM.YYYY | SDM Basics                  | definitions and how it works                   |
| 03 | DD.MM.YYYY | different sdm techniques      | maxent, spatialmaxent, glm... |
| 04 | DD.MM.YYYY |     | Raster data, vector data, coordinate reference systems, reading and writing spatial data, spatial operators, mapping |
| 05 | DD.MM.YYYY | SDM Basics                   | Why SDM?, applicability of SDM, ecological concepts, SDM modelling cycle. Student tutorial assignment                          |
||| **Exemplary SDM workflow**          ||
| 06 | DD.MM.YYYY | How to Frankenstein Your Own Species | Overview, conceptualisation, data processing which SDM packages and functions to choose?          |
| 07 | DD.MM.YYYY | SDM workflow              | Model fitting, assessment, and predictions                                 |
||| **High-risk high-gain play the game of science**           ||
| 08 | DD.MM.YYYY | research gaps in SDM             |   You can use the time of this session to work on your student tutorials and ask questions                                      |
| 09 | DD.MM.YYYY | create your own experiment        |                         |
| 10  | DD.MM.YYYY |                 | Student tutorials presentations: Unbiased conditional inference forest (cforest), GLM mit Lasso penalty                                     |
| 11  | DD.MM.YYYY | SDM methods II              | Student tutorials presentations: Boosted Regression Trees                       |
| 12 | DD.MM.YYYY | SDM methods III               | Student tutorials presentations: XGboost, spatialMaxent                        |
| 13 | DD.MM.YYYY| Final Team Project ||
||| **Synthesis**                                ||
| 14 | DD.MM.YYYY | Wrap up                      | Get and give feedback from your peers and instructors, tell us how you self-assess your skills, and happy holidays |





# Deliverables

The course grading will be based on on your final team project.




# Preparation and prerequisites

Knowledge of R and of handling spatial data is beneficial. Initial experience with species distribution modeling is helpful, for example from our basic [species distribution modeling course](https://geomoer.github.io/moer-bsc-project-seminar-SDM/).
All software needed for this course is free and open source.

If you have no experience with R we highly recommend the base R course, 
which can be found [here](https://geomoer.github.io/moer-base-r/){:target="_blank"}.
{: .notice--success}


# Team

{% for author in site.data.authors %} {% include author-profile.html %}
{% endfor %}


<!--
[Go to course units]({{ site.baseurl }}{% link _pages/units.md %}){: .btn .btn--success .btn--large .align-center}
-->



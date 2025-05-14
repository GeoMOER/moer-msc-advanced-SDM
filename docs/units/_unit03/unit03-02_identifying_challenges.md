---
title: Ex | Identify the challenges
toc: true
published: true
header:
  image: '/assets/images/teaserimages/landscape.png'
  caption: '紅色死神 via [flickr.com](https://flic.kr/p/2p6ah3Q). [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/). Image cropped.'
---

In this exercise we want to explore the challenges that are associated with the evaluation of species distribution models. In the last unit you already have created a species distribution model and evaluated it using three evaluation metrics. Now we will slightly change the data and observe if there are changes to these metrics. Based on your workflow from unit 02 do the following three changes to your dataset:

1. Randomly sample a small amount of your test dataset e.g. only half of the test points and calculate the three metrics again.
1. When calculating the Boyce index set all values of your prediction raster larger than e.g 0.3, 0.4, 0.5 or 0.6 to  the value 1 and calculate the Boyce index again.
1. Calculate a second model with 20 000 backgrund points. Calculate all three metrics again.


What could you observe for each individual metric? Are there any issues or unexpected behavior? What are the broader implications of your observations?
{: .notice--info}



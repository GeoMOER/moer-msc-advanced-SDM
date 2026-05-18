---
title: "A | Assignment: 05"
published: true
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_cropped.png'
  caption: 'Generated with Google Gemini'
toc: true
---

Today, we learned that evaluation metrics calculated on presence-only data (like AUC or TSS) can deviate from actual model performance. In this assignment, we will try to find out how much current literature relies on evaluation metrics and how details on their calculation are reported.

{% capture Assignment-1-1 %}
### Task 1: Find a Case Study
Use Google Scholar, Web of Science, or your university library to find a peer-reviewed study published within the **last 2 years** that meets the following criteria:
1. It uses **Species Distribution Modeling (SDM)**.
2. It is a case study for one individual species (no review papers!).
3. You could use, for example, these filtering steps in [Google Scholar](https://scholar.google.de/scholar?as_ylo=2022&q=%22species+distribution%22++modeling+case+study&hl=de&as_sdt=0,5).

### Task 2: Evaluation Metrics
Read the **Methods** and **Results** sections of your chosen paper and extract the following information:
* **Evaluation Metrics:** Which evaluation metrics are used for model assessment in this study?
* **Model Performance:** What scores did the authors report? (e.g., AUC = 0.85, TSS = 0.70).
* **Data Type:** Did they use randomly sampled background points (PBG) or true presence-absence data? How was the data generated/sampled? Or is there no information given on the test data used for calculating metrics?
* **Assessment:** How do the authors of the study interpret the evaluation metrics/results?

Upload your assignment as a PDF to ILIAS. Do not forget to include the full title of your study as well as the DOI. 

{% endcapture %}

<div class="notice--success">
  {{ Assignment-1-1 | markdownify }}
</div>

This assignment will not be marked.
{: .notice--info}
---
title: EX | A short history of SDM
toc: true
published: true
header:
  image: '/assets/images/teaserimages/felder.png'
  caption: '[Marco Verch via ccnull.de](https://ccnull.de/foto/drohnenaufnahme-von-landwirtschaftlichen-feldern-mit-geometrischen-mustern/1105470). [CC-BY 2.0](https://creativecommons.org/licenses/by/2.0/de/). Image cropped.'
---

# The Methodological Evolution of SDM (1980–Present)

### Overview
Species Distribution Modeling (SDM) has evolved from simple climate "envelopes" to high-dimensional machine learning and process-based simulations. Understanding this history is critical for an advanced modeler to recognize why certain defaults (like MaxEnt settings or AUC metrics) exist today.

---

### Phase 1: Interactive Research Task
**Duration:** 60 Minutes

In this section, you are the researcher. You must identify the "Key Milestones" that shifted the paradigm of spatial ecology. Use academic databases (Google Scholar, Web of Science, or Scopus) to complete the chronology table below.

> **Instructions:** Find the **Year** and the **Primary Author/Software** associated with each breakthrough. In a functional environment, entering the correct data will unlock the "Technical Significance" blurb for each era.

| Milestone Description | Year | Lead Author / Software |
| :--- | :--- | :--- |
| **1. The Bioclimatic Envelope:** The first widely used automated package for climate-based range mapping. | `____` | `____________` |
| **2. Transition to Probabilistic Modeling:** The first major application of Generalized Linear Models (GLMs) to replace "Boolean" boxes. | `____` | `____________` |
| **3. The WorldClim Foundation:** The release of the first standardized, global high-resolution climate surfaces. | `____` | `____________` |
| **4. Maximum Entropy Modeling:** The introduction of a specific algorithm designed to handle "presence-only" data with high complexity. | `____` | `____________` |
| **5. The Ensemble Revolution:** The conceptual shift toward combining multiple algorithms (Consensus Modeling) via the BIOMOD framework. | `____` | `____________` |
| **6. The Discriminatory Power Critique:** The definitive paper highlighting the limitations of AUC as a "universal" evaluation metric. | `____` | `____________` |
| **7. Spatial Autocorrelation Correction:** A seminal work addressing why the "Independence of Observations" assumption is usually violated in SDM. | `____` | `____________` |
| **8. Machine Learning Dominance:** The introduction of Boosted Regression Trees (BRTs) as a robust alternative to regression. | `____` | `____________` |
| **9. Joint Species Distribution Models (jSDMs):** The move from single-species models to modeling entire communities and biotic interactions. | `____` | `____________` |
| **10. The Mechanistic Frontier:** The shift toward integrating physiological limits (energy/water balance) into correlative models. | `____` | `____________` |

---

### Phase 2: Technical Synthesis
*This section becomes accessible once the table is complete.*

#### The Three Great Shifts
1.  **From Space to Environment:** Early models treated geography as the primary driver; modern SDMs treat geography as a proxy for the $n$-dimensional niche.
2.  **From Inference to Prediction:** The 1990s focused on "why" a species is there (coefficients); the 2000s focused on "where" it will be (predictive accuracy).
3.  **The Rigor Turn (Post-2010):** A historical realization that high predictive scores (AUC) often hid massive sampling biases and spatial dependencies.

---

### Module 2 Resources
* **Primary Literature:** * *Guisan & Zimmermann (2000)* - "Predictive habitat distribution models in ecology."
    * *Elith et al. (2006)* - "Novel methods improve prediction of species’ distributions from occurrence data."
* **Software History:** * Review the documentation history of the `dismo` and `biomod2` R packages.

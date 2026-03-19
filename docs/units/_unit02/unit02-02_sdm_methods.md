---
title: EX | The Algorithmic Landscape
toc: true
published: true
header:
  image: '/assets/images/teaserimages/Gemini_Generated_Image_lake_cropped.png'
  caption: 'Generated with Google Gemini'
---

This module bridges the gap between the ecological theory we discussed in Part 1 and the computational power of the 20+ models available in our tutorial library. Before you begin clicking "Run," you must understand the mathematical architecture behind these tools.

<!--more-->


### Correlative vs. Mechanistic

In modern Biogeography, we categorize models based on how they define the relationship between an organism and its environment.

#### Mechanistic Models 
* **Logic:** Uses "Functional Traits." It models the biophysical constraints of the organism (e.g., metabolic rate, water loss, thermal limits).
* **Data:** Lab-derived physiological data (e.g., $T_{max}$, $T_{min}$).
* **Best For:** Predicting shifts into entirely new environments and understanding survival thresholds.
* **Risk:** Extremely data-intensive; requires detailed knowledge of the species' biology that often isn't available.


#### Correlative Models
* **Logic:** Uses "Occurrence-Environment" correlations. If we find a species at 20°C frequently, we assume 20°C is suitable.
* **Data:** GBIF points + GIS layers (WorldClim/CHELSA).
* **Best For:** Large-scale mapping, rapid assessment, and data-rich species.
* **Risk:** Can struggle with **extrapolation** into "No-Analog" future climates because the model doesn't understand *why* the species is there, only that it *is* there.


---

### Taxonomy of Machine Learning in SDM

Machine Learning (ML) is not a single tool, but a family of algorithms. In our tutorial library, you will find models grouped into three primary "Logics":

#### **A. The Regression Family (Smoothers)**
* **Example:** GAMs (Generalized Additive Models).
* **How they work:** They allow for non-linear, "wiggly" relationships. They are mathematically transparent and excellent for seeing how a specific variable (like rainfall) affects probability across its entire range.

#### **B. The Decision Tree Family (Partitioning)**
* **Examples:** Random Forest (RF), Boosted Regression Trees (BRT/XGBoost).
* **How they work:** They split the environmental data into a series of binary "if/then" questions. 
    * **Random Forest** averages many trees to reduce noise. 
    * **Boosting** builds trees sequentially, with each new tree trying to fix the errors of the previous one. 
* **Strength:** These handle **complex interactions** (e.g., Temperature matters *only if* Humidity is low) better than almost any other method.

#### **C. The Maximum Entropy Family (Constraints)**
* **Example:** MaxEnt.
* **How it works:** It finds the probability distribution that is most spread out (maximum entropy) given the known environmental constraints of the presence points. It is specifically designed for **presence-only** data.


### Exercise
On the next page you will find many student tutorials on the different algorithmns used in SDM. 
1.  **The Hyperparameters:** What settings (e.g., Tree Depth, Learning Rate) did you change from the default?
2.  **The Response Curves:** Does the biological response make sense (e.g., a bell curve for temperature)?
3.  **The Evaluation:** Did you use TSS, Boyce Index, or AUC?


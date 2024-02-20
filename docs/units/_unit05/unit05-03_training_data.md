---
title: "SDM workflow I - Training, validation and test data"
header:
  image: '/assets/images/unit05/butterfly.png'
  caption: '[Internet Archive Book Images via flickr.com](https://www.flickr.com/photos/internetarchivebookimages/page7) [public domain](https://creativecommons.org/publicdomain/zero/1.0/){:target="_blank"}'
toc: true
---

The data of the species occurrence is referred to as training data, usually machine learning models are not trained with all data but only with a subset of data. For this purpose, the dataset must be split into several datasets.
Data splitting is an essential step in machine learning model development to assess model performance. The dataset is typically divided into three subsets: training data, validation data, and test data. The training data is used to train the model, where it learns patterns and relationships between the data. The validation data is used to tune the model's hyperparameters and evaluate its performance during the training process. It helps in selecting the best-performing model and preventing overfitting. Finally, the test data is kept separate and serves as an unbiased evaluation of the final model's performance on unseen data. It provides an estimation of how well the model will perform in real-world scenarios.

![](https://assets-global.website-files.com/5d7b77b063a9066d83e1209c/61568656a13218cdde7f6166_training-data-validation-test.png)

For model validation one of the most popular methods is cross-validation. Cross-validation is a technique that goes beyond simple data splitting and offers a more robust evaluation of machine learning models. Instead of having a single validation set, cross-validation involves partitioning the dataset into multiple subsets or "folds". The model is trained and evaluated multiple times, each time using a different fold as the validation set and the remaining folds as the training set. This process helps in obtaining a more reliable estimation of the model's performance by reducing the impact of data variability. Cross-validation provides valuable insights into the model's stability, consistency, and generalization across different subsets of the data. It is particularly useful when the dataset is limited, ensuring that the model's performance is not overly dependent on a specific data split.





{% include video id="fSytzGwwBVw" provider="youtube" %}


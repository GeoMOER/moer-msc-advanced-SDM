---
title: "Example: R Markdown with html output"
header:
  image: '/assets/images/teaserimages/bats.png'
  caption: '[Environmental Informatics Marburg](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
toc: true
toc_label: In this example
---

This page shows how a compiled R markdown file looks like (in fact, all code examples in this course were compiled with R markdown).

## This is a header

This is an R Markdown document. Markdown is a simple formatting syntax for creating HTML, PDF, and MS Word documents. 
For more details on using R Markdown see [rmarkdown.rstudio.com](http://rmarkdown.rstudio.com){:target="_blank"}.

When you click the **Knit** button in RStudio (only available for .Rmd files), a document will be generated, 
which includes both content as well as the output of any embedded R code chunks *within* the document.
You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```


## This is another header

You can also embed plots, for example:

![]({{ site.baseurl }}/assets/images/air_temperature.jpg)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot (see below).


## Markdown source
The above content of this page is the result from an R markdown file, which looks like that.


``````yaml
---
title: "Example: R Markdown with html output"
author: "Thomas Nauss, Dirk Zeuss"
date: "15 April 2021"
output: 
  html_document: 
    keep_md: yes
---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(fig.path='{{ site.baseurl }}/assets/images/')
```

## This is a header

This is an R Markdown document. Markdown is a simple formatting syntax for creating HTML, PDF, and MS Word documents. 
For more details on using R Markdown see [rmarkdown.rstudio.com](http://rmarkdown.rstudio.com){:target="_blank"}.

When you click the **Knit** button in RStudio, a document will be generated which includes both content as well as the output of any embedded R code chunks *within* the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

## This is another header

You can also embed plots, for example:

![]({{ site.baseurl }}/assets/images/air_temperature.jpg)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot (see below).

``````


## More fancy themes, please

If you want to individually style your markdown output, 
check out this spotlight on how to use [CSS in R Markdown](https://geomoer.github.io/moer-base-r/unit99/sl03_css.html){:target="_blank"}.



## Comments?
You can leave comments under this issue if you have questions or comments about the content on this page. Please copy the corresponding line into your comment to make it easier to answer the question. 



<script src="https://utteranc.es/client.js"
        repo="GeoMOER/moer-bsc-project-seminar-SDM"
        issue-term="unit01-03_Rmd_html"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>

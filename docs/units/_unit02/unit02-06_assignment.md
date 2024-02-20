---
title: "Assignment: Input and Output of Data"
toc: true
toc_label: In this worksheet
header:
  image: '/assets/images/teaserimages/RStudio.png'
  caption: '[RStudio](https://www.rstudio.com/){:target="_blank"}'
---

This assignment introduces you to data input and output with R and will strengthen your skills in work directory management.
<!--more-->

After completion you should be able to read in .csv files into R, access the contained data, and write out R objects as files to your local computer. 
You will further have reinforced your skills for running commands within R scripts, for compiling documents with R markdown, and for using Git and GitHub.



## Things you need for this assignment

  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system.
  * [The Data input and output tutorial](https://geomoer.github.io/moer-base-r/unit06/unit06-01_Intro.html){:target="_blank"} for this course.
  * An input .csv file, which can be found in ILIAS(Data/dummydata.csv).


## Data input and output assignment

1. Work yourself through the data input and output tutorial, which you can find [here](https://geomoer.github.io/moer-base-r/unit06/unit06-01_Intro.html){:target="_blank"}.
1. Download the .csv file and save it into your local "data" folder.


Please write an R script as an Rmd file with html output for the following tasks:

1. Read in the data contained in this .csv file into R as an R data.frame object in the R workspace.
1. What are the data types of each column?
1. Save the column entitled "error" as a vector object in the R workspace.
1. Remove all rows with values larger than 1 in the "error" column and save the result as a new R object.
1. Write out this cleaned object to your local "output" folder as a new .csv file. 



Save your Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. 
Make sure that the created html file is also part of your GitHub repository and also include the text of each task prior to your solutions.


This assignment will NOT be marked. 
Note, however, that you will be hopelessly lost in the subsequent sessions if you have neither control over your work environment nor data input and output.
{: .notice--info}


<!--
1. Remove all entries marked with "unacceptable" in the "quality" columns and save the result as a new R object.
Use the function `subset()` for this task. 
Have a look at the help page of this function (type `?subset`) to get familiar with its syntax.
-->



## Comments?
You can leave comments under this issue if you have questions or comments about the content on this page. Please copy the corresponding line into your comment to make it easier to answer the question. 



<script src="https://utteranc.es/client.js"
        repo="GeoMOER/moer-bsc-project-seminar-SDM"
        issue-term="unit02-06_assignment"
        theme="github-light"
        crossorigin="anonymous"
        async>
</script>

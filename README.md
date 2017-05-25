---
title: "Readme"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

###Introduction

This repository is related to Getting and Cleaning Data Course Project from Coursera.

"The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md."

The data used comes from this survey:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


###Reshaped datasets
In order to reproduce the tidy datasets, you will have to run the script "run_analysis.R".

The script will: 
-load the original data if not yet available
-merge the training and test data
-merge subject, activity and measure
-reshape data
-save final files: Tidydata1.csv and Tidydata2.csv








##Overview

These data were taken from the Coursera website, which sourced them from the UC Irvine machine learning website
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files included are this readme, CODEBOOK.md - a description of the variables, and run_analysis.R - the R script used for ETL.


##How the script works
This script was written by Brad Kenny for the Coursera Getting and Cleaning Data class.
Outside of Base R,The reshape2 library was used for transformation.

* Reading in the files of interest
* The training and test sets are merged via a row bind
* Additional columns (subject and activity type) are merged with the data
* Activities are given names via a SQL-esque type join
* The data are then transformed so that for every subject and activity, the variable mean is listed 

##Data Names
The data types are seperated out by the coordinate axes X,Y,Z, whether they are measured by the 
phone accelerometer(Acc) or gyroscope (Gyro), body(Body) or gravity(Gravity) signals.
Most variables are measuring acceleration, unless they contain "Jerk" or "Mag". "Jerk" is a measurement of the jerk (time derivative of acceleration).  "Mag" is a measurement of the Euclidean magnitude.

For further information, please view the original dataset.

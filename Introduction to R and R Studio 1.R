



##If first time using ggplot2 or R studio install the ggplot package using this command

install.packages("ggplot2")

##At the start of each work session you need to load the package using this command
library(ggplot2)

##We're going to use a dataset we can load from the ggplot package to get started

demographics <- midwest

summary(demographics)

head(demographics)

##To view all the population totals 
demographics$poptotal 

## To create a new column

demographics$popchild <- 0

demographics$popchild <- demographics$poptotal - demographics$popadults

## Now we've added our extra column we needed, we should save this as a CSV for later
## set working directory to where you want to save your work today
setwd("/.../....")

##Save data as a csv file
write.csv(demographics, file="midwestDemographics.csv", row.names = FALSE)

##Load a csv - leaving this here for later because normally this is what you'll be doing to load in data from a lab

demographicsCSV <- read.csv('midwestDemographics.csv',header=TRUE)
  
ggplot(data=demographicsCSV, aes(x=county, y=popchild))+
         geom_bar(stat="identity")

## Too much data for one graph! Let's plot by state instead


ggplot(data=demographicsCSV, aes(x=state, y=popchild))+
  geom_bar(stat="identity")

##There's too much data to show on one graph, so let's plot by state instead

ggplot(data=demographicsCSV, aes(x=state, y=popchild))+
  geom_bar(stat="identity")



  
  
##15th Jan 2025 GGplot2 coding community
##By Chloe Randall

##Cover basic ggplot layering, multi-panel plots, colours and labeling

##I recommend running this tutorial line by line
##This can be done by holding ctrl+enter

##If first time using ggplot2 or R studio install the ggplot package using this command
##You only need to run this command once
install.packages("ggplot2")

##At the start of each work session you need to load the package using this command
library(ggplot2)

##We will using the dataset mpg as an example dataset
## mpg is a fuel economy dataset from 1999 and 2008 for 38 popular models of cars
data <-mpg
str(data)
#Use to show dimension of data, helpful as it tells you the number of rows and columns in your data
dim(data)

#getwd() 
setwd("/Users/Work/PhD/Coding_comm/")

##Loading data into R
##Save data as a dataset
write.table(data, file = "mpg.dat", sep = "\t",
            row.names = FALSE, col.names = TRUE) # this creates a table with the data we called previously and tells R that we have a column name row

##Save data as a csv file
write.csv(data, file="mpg.csv", row.names = FALSE)

## Here are two different ways in which you might read data into R
##Read data using read.table
data<- read.table(file = "mpg.data", sep = "\t", header = TRUE) 
##Read data using read.csv
data<- read.csv(file = "mpg.csv", header = TRUE)

##If you want further teaching on R syntax, let us know and further tutorials can be planned



##Ggplot is a layered plot format where you build on the plot with lines of code
##Initially you start the plot by calling ggplot and then providing the mapping information of the plot
ggplot(data = data, aes(x=hwy, y=cty)) +
##You then add how you want to plot the infomation
  geom_jitter()

##ggplot function basics
##geom_density = Histogram
##geom_boxplot = Boxplot
##geom_jitter = Stripchart
##geom_violin = Violin
##geom_point = Scatter 
##geom_bar = Bar and pie
##geom_tile = Heatmaps

help("ggplot")
##This link has useful layout information we will be covering today as well as downloadable cheatsheets containing every possible ggplot
#https://rstudio.github.io/cheatsheets/html/data-visualization.html

##Once you have a basic plot you can then add further information using the + to add new lines of code, which adds new layers to the plot
##Or add more detailed instructions for each added line inside the ()

##Help command is an easy way to check what the command needs as input or is optional to include
help(geom_jitter)
##Includes possible aesthetic information 

##You can also add additional inputs into the mapping (aes) to include additional information
ggplot(data = data, aes(x=hwy, y=cty, shape = factor(cyl))) +
  ##You then add how you want to plot the information, alpha changes the transparency
  geom_jitter(alpha=0.3, size=3, colour="blue")

##When starting a ggplot include all plotting information first then apply layering
##This includes adding multiple plotting techniques
ggplot(data = data, aes(x=hwy, y=cty, shape = factor(cyl))) +
  geom_jitter(alpha=0.3, size=3, colour="blue") +
  geom_smooth(colour="yellow")

ggplot(data = data, aes(x=class, y=cty)) +
  geom_jitter() +
  geom_boxplot(aes(fill = class), alpha=0.5)

##Multi-panel plots
##facet_wrap allows for a column or row input to divide information into seperate plots
ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(alpha=0.4) +
  facet_wrap(~manufacturer)

ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(alpha=0.4) +
  facet_grid(manufacturer~cyl)

##You can also limit the inputs by creating subsets of the data
data.small <- subset(data, manufacturer %in% c("ford", "land rover", "toyota", "honda"))
##Note changed data input
ggplot(data = data.small, aes(x=hwy, y=cty)) +
  geom_jitter(alpha=0.4) +
  facet_wrap(~manufacturer)

##Colours
##Adding colours to a plot can be done manually or using colour palettes
##Manually 
ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(aes(colour = drv)) +
  scale_colour_manual(values = c("red", "green", "yellow"))
##Colour palette
##Possible palettes RColorBrewer
require(RColorBrewer)
display.brewer.all()

ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(aes(colour = drv)) +
  scale_colour_brewer(palette = "Dark2")
##RColorBrewer is useful for a limitied colour pallete with distinct colours

##Viridis colour palette are continus colour ranges which apply well to continous and discrete data sets
install.packages("viridis")
library(viridis)
##Click on link to see viridis colour scales
#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(aes(colour = drv)) +
  scale_colour_viridis(discrete=TRUE, option = "D")
##using option allows to select a different viridis colour palette from the standard (A-H)

##Another colour pallete option is colouring based on scientific journal
install.packages("ggsci")
library(ggsci)
#Help gives link to information about palettes available. 
help(ggsci)
#edit the scale_color command
ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(aes(colour = drv)) +
  scale_color_bmj()

##Labeling
##Now we can make a plot and colour it we can now start labeling
##Most of these additional prettying can be done multiple ways such as individually using ggtitle or labs which contains all labelling
ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(aes(colour = drv)) +
  scale_colour_viridis(discrete=TRUE, option = "A") +
  labs(x= "X", y="Y") + 
  ggtitle("Title")

##Theme
##Complete theme can be used to change the look of the background 
ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(aes(colour = drv)) +
  scale_colour_viridis(discrete=TRUE, option = "A") +
  labs(x= "X", y="Y") + 
  ggtitle("Title") +
  theme_bw() 

#Theme can be used to change the non-data components of plots
help(theme)
##The help includes everything you can edit and the parameters
ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(aes(colour = drv)) +
  scale_colour_viridis(discrete=TRUE, option = "A") +
  labs(x= "X", y="Y") + 
  ggtitle("Title") +
  theme_bw() +
  theme(axis.text.x = element_text(size=10),
        axis.text.y=element_text(size=10),
        axis.title=element_text(size=15),
        legend.title = element_blank(),
        legend.text = element_text(size = 10))
##R coding tip - I find it easier to understand the inputs when I order the plot on different lines

##Saving plots
##Once you are happy with you plot you can then save the plot either through exporting above the plot view or you can use ggsave
##For using ggsave you need to create your plot as a variable
plot_1 <- ggplot(data = data, aes(x=hwy, y=cty)) +
  geom_jitter(aes(colour = drv)) +
  scale_colour_viridis(discrete=TRUE, option = "A") +
  labs(x= "X", y="Y") + 
  ggtitle("Title") +
  theme_bw() +
  theme(axis.text.x = element_text(size=10),
        axis.text.y=element_text(size=10),
        axis.title=element_text(size=15),
        legend.title = element_blank(),
        legend.text = element_text(size = 10))
##When saving the plot you can change your working directory using setwd or give the path for the file to be saved in ggsave
#getwd()
#setwd("../PhD/Coding_comm/")
##Make sure to label your filename with the correct device 
ggsave(filename = "coding_com_plot.png", plot = plot_1, device="png", path = "/Users/Work/PhD/Coding_comm/")


##Exercise##

##Using the scripts above and the links attached in the script have a go at producing a bar plot
##(multiple options on how to perform)



######################################################################################################## #
######                                                                                               ### #
######                                 Curso Ciencia de datos en R                                   ### #
######              Escuela de Doctorado, Universidad de Alcalá, Mayo-Junio 2021                     ### #
######                                 Profesora Sara Villén Pérez                                   ### #
######                                                                                               ### #
######                               2) DATA VISUALIZATION IN R                                      ### #                                                                                       #####
######                                   *** with answers ***                                        ### #
######################################################################################################## #

# Recommended reading:
# ggplot2 reference: https://ggplot2.tidyverse.org/reference/
# Chang, W. (2021). R graphics cookbook: practical recipes for visualizing data. "O'Reilly Media, Inc.".(2nd edition)
#     https://r-graphics.org/
# R colors http://research.stowers???institute.org/efg/R/Color/Chart
# ggplotgui: to play and copy the code: http://shiny.gmw.rug.nl/ggplotgui/

##################################### #
#### 0 ### WORKSPACE PREPARATION #### 
##################################### #
# Tidy working space
rm(list=ls())
# Set working directory (yourself!)
setwd("C:/.../2_DATA_VISUALIZATION")

# call packages
library(ggplot2)           # ggplot2
library(gcookbook)         # Datasets we are going to use
library(RColorBrewer)      # Color palettes 
library(ggrepel)           # ggplot extension: ggrepel
library(gganimate)         # ggplot extension: gganimate
library(ggthemes)          # ggplot extension: ggthemes
library(sf)                # spatial data
library(ggspatial)         # visualization of spatial data
library(maps)              # spatial databases
library(mapdata)           # spatial databases
library(rnaturalearth)     # spatial databases
library(rnaturalearthdata) # spatial databases
library(plyr)              # Others (not relevant here):
library(maps)         
library(scales)       
library(DT)           
library(gapminder)    
library(readr)
library(dplyr)
library(tibble)
library(lubridate)
library(ggThemeAssist)
library(gifski)




#******************************************** *
########### # 
#### BLOCK 1  -  INTRODUCTION TO GGPLOT    ####   
########### # 
#******************************************** *

########################################### # 
#### 1 ### INTRODUCTION TO GGPLOT LOGIC  #### 
########################################### # 

########### #
#### 1.1 ## DATA STRUCTURE: comparison with R graphics #### 
########################### #
# example data
simpledat

### USING BASE GRAPHICS:
######################## #
# Bar graph grouped by Bs
barplot(simpledat, beside=TRUE)

# Bar graph grouped by As 
t(simpledat)  
barplot(t(simpledat), beside=TRUE)

# Not nice: in order to change the graph we need to restructure the data

### HOW WOULD IT BE WITH GGPLOT2?
################################# #
# For ggplot data structure is always the same: LONG FORMAT
simpledat_long
# Long format:
#     - Each line represents an observation
#     - Elements are grouped by variables, not by their position in the matrix

# Bar graph grouped by Bs:
ggplot(simpledat_long, aes(x=Aval, y=value, fill=Bval)) +
  geom_bar(stat="identity", position="dodge")
# Observe:
# x=Aval sets A categories to be discriminated along x-axis
# y=value sets y-axis (bar height) to be defined by value variable
# fill=Bval sets colour bar to be defined by group B 
# geom_bar() asks for a bar graph
# geom_bar() arguments are not important now

# $$$ Exercise: considering the above, make the graph grouped by As:
# $$$ ANSWER:



########### #
#### 1.2 ## GRAPH TYPE: comparison with R base graphics #### 
####################### #
# example data
simpledat

### USING BASE GRAPHICS: 
######################## #
# Bar graph grouped by Bs:
barplot(simpledat, beside=TRUE)

# LINE graph grouped by Bs:
plot(simpledat[1,], type="l")
lines(simpledat[2,], type="l", col="blue")
# Not nice:
#   Need to use a totally different function (lack of structured logic)
#   y-axis limits are defined for black line (so blue line is outside the graph area)
#   x-axis is interpreted as continuous and not categorical

### HOW WOULD IT BE WITH GGPLOT2?
################################## #
# Plot components are combined in layers, using +
# Plots are built by gradually adding components

# Bar graph grouped by Bs:
ggplot(simpledat_long, aes(x=Aval, y=value, fill=Bval)) +
  geom_bar(stat="identity", position="dodge")

# Line graph grouped by Bs:
ggplot(simpledat_long, aes(x=Aval, y=value, colour=Bval, group=Bval)) +
  geom_line()

# Observations:
#   We changed geom_bar() by geom_line()
#   We used colour and group to colour lines
#   y-axis limits are automatically adjusted to both lines because they are drawn simultaneously
#   x-axis is understood as categorical
#   A legend is automatically generated

############################################################################### #
#### 2 ### BUILDING A SIMPLE PLOT IN GGPLOT: ggplot(data, aes()) + geom_() #### 
############################################################################### #
# List of possible layers in ggplot: http://ggplot2.tidyverse.org/reference/

########### #
#### 2.1 ## data #### 
##################### #
# data.frame, long format
# remember: gather(){tidyr}
# example
dat <- data.frame(xval=1:4, yval=c(3,5,6,9), group=c("A","B","A","B"))
dat

########### #
#### 2.2 ## ggplot() function #### 
################################## #
ggplot(dat, aes(x=xval, y=yval))
# Observation:
# there are no points, no bars, no lines..!!!
# ... because you need to define how to visualize your data (geom_())

# $$$ Exercise: Observe the axes. Are they related to xval and yval?
# $$$ ANSWER: 

# $$$ Exercise: create a new graph with xval in y-axis and yval in x-axis
# and observe the axes.
# $$$ ANSWER:


###########  #
#### 2.3 ## ggplot() + geom_() #### 
################################### #
# let's include geom_() function to indicate how to represent data
# For a scatterplot, we use geom_point() 
ggplot(dat, aes(x=xval, y=yval)) + geom_point()

# $$$ Exercise: draw a line crossing the data points (tip: geom_line())
# $$$ ANSWER:


# $$$ Exercise: create a graph with lines and points:
# $$$ ANSWER:


########### #
#### 2.4 ## aes() ####
###################### #
# Now let's identify points from A and B groups with different colours:
ggplot(dat, aes(x=xval, y=yval, colour=group)) + geom_point()
# Same result:
ggplot(dat, aes(x=xval, y=yval)) + geom_point(aes(colour=group))

# $$$ Exercise: draw a different line for each group (A e B)
# $$$ ANSWER:


# $$$ Exercise: include points in the last graph, without differentiating 
# group color (i.e., lines colored by group, black points)
# $$$ ANSWER:



# $$$ Exercise: now color both lines and points by group
# (tip: there are two ways to do that)
# $$$ ANSWER:

 

########### #
#### 2.5 ## aesthetics mapping vs. setting ####
############################################### #
# aes() is a function to define "aesthetics mapping": 
# how data properties are translated into graph aesthetics
# (for instance, how group A/B defines point colour)
ggplot(dat, aes(x=xval, y=yval)) + geom_point(aes(colour=group))

# But graph aesthetics can also be defined independently from data properties
# This is "aesthetics setting"
# (for instance, point color to be violet)

# $$$ Exercise: Modify the graph above to color all points in blue
# (tip: colour="blue")
# $$$ ANSWER:


#   GOT IT!!
#   1)  inside aes(): for mapping data characteristics into visual features
#   2)  outside aes(): for setting visual features independent of data 
#   3)  aes() in ggplot() function is inherited in subsequent functions,
#       but it can be overwrited using aes() in specific functions

############ #
#### 2.6. ## aes: which arguments are valid for each function? ####
################################################################### #
# $$$ Exercise: which arguments are valid for geom_point()? 
# (Tip: look for Aesthetics section in function help: ?geom_point)
# $$$ ANSWER:



# $$$ Exercise: Choose one of these to identify 
# the "group" variable in the following graph.
# Try at least alpha, shape, size and pay attention to warning messages
dat
ggplot(dat, aes(x=xval, y=yval)) + geom_point()
# $$$ ANSWER:



########### #
#### 2.7 ## Important recommendations to add layers #### 
######################################################## #

## Where to locate the "+" ?
############################# #
# In order to ease code lecture, each function (layer) is usually located 
# in a different line. So, where to locate the "+"?

# $$$ Exercise: try the two options and answer the question above
# Option a:
ggplot(dat, aes(x=xval, y=yval)) 
+ geom_point()
# Option b:
ggplot(dat, aes(x=xval, y=yval)) +
  geom_point()
# $$$ ANSWER: 


## Store the graph in an object
################################ #
# In order to generate different versions of the graph
p <- ggplot(dat, aes(x=xval, y=yval)) + geom_point()
p
l <- p + geom_line()
l
# Or even:
b <- ggplot(dat, aes(x=xval, y=yval)) 
p <- b + geom_point()
l <- b + geom_line()
pl <- b + geom_point() + geom_line()
p
l
pl


#*****************************************
############## #
#### BLOCK 2  -  GEOMETRIES: geom_()  #### 
############## #
#*****************************************

#***************************************************************************************
# BLOCK 2.1.  - BASIC GRAPHS
#***************************************************************************************
# * 3-Scatterplot: geom_point()
# * 4-Line graphs: geom_line()
# * 5-Area graphs: geom_area()
# * 6-Barplot    : geom_bar()
#***************************************************************************************

########################################### #  
####  3 ### SCATTERPLOTS: geom_point() ####    
########################################### #

############ #
#### 3.1. ## Basic scatterplot #### 
################################### #
# x and y are usually continuous variables
# Example:
head(heightweight)
str(heightweight)

# $$$ Exercise: Fill the spaces to make a basic scatterplot using the heightweight database,
# to represent the relationship between "ageYear" and "heightIn". heightIn is the response variable (in y-axis).
# ggplot(___________, aes(x=_______, y=_________)) + geom_point()
# $$$ ANSWER


############ #
#### 3.2. ## Grouped scatterplot #### 
##################################### #
# A categorical variable will define point aesthetics

# $$$ Exercise: differentiate male and female points:
# a) using different colours (tip: colour)
# $$$ ANSWER:


# b) using different point shapes (tip: shape)
# $$$ ANSWER:


# c)* using both different colours and shapes
# $$$ ANSWER:


# d)* using different point sizes (tip: size)(pay attention to warning!) 
# $$$ ANSWER:



############ #
#### 3.3. ## Continuous-mapped scatterplot #### 
############################################### #
# A continuous variable will define point aesthetics

# $$$ Exercise: Include the variable "weightLb" in the following graph:
ggplot(heightweight, aes(x=ageYear, y=heightIn)) +  geom_point()
# a) using colours
# $$$ ANSWER:


# b)* using point sizes (tip: use alpha=0.2 in geom_point to facilitate visualization with transparency)
# $$$ ANSWER:



# $$$ Exercise: Now represent "weightLb" with different point sizes and 
# "sex" with different colours
# $$$ ANSWER:



# OBSERVATION: perception accuracy is higher for coordinates (x,y) than for 
# colours or sizes. Choose variables for each aesthetic considering that!

# $$$ Exercise*: represent "weightLb" with different point sizes and 
# "sex" with different shapes
# $$$ ANSWER:



# OBSERVATION: is not nice to map size and shape simultaneously,
# because it is difficult to compare the size of different shapes
# (actually, the size of different shapes is different)

############ #
#### 3.4. ## Scatterplots: solutions for point superposition #### 
################################################################# #

## Medium superposition
######################## #
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(size=5)

# Solution 1 - point transparency: alpha
# $$$ Exercise: modify the value of alpha (from 0 to 1)
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(alpha=0.8, size=5)
# $$$ ANSWER:



# Solution 2 - point size: size
# $$$ Exercise: modify the value of size
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(size=5)
# $$$ ANSWER:



# Solution 3 - point shape: shape
# $$$ Exercise: modify the value of shape
# Tip: shape values to perceive superposition: 0-14
# in my opinion, the best are: 0-6, 8
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(shape=1, size=5)
# $$$ ANSWER:



## Large superposition
####################### #
sa <- ggplot(diamonds, aes(x=carat, y=price)) 
sa + geom_point()

# Solution 1 - point transparency: alpha
# $$$ Exercise: implement this solution using transparency at 90% and 99% 
# $$$ ANSWER:



# Solution 2 - plot "point density" in a raster
# $$$ Exercise: plot point density in the price-carat plot
# tip: stat_bin2d(). It functions like a geom_(), so no need of geom_point()
# by default stat_bin2d() divides the space in 30x30=900 squares
# $$$ ANSWER:


# $$$ Exercise*: choose the number of quadrants in which is divided each axis
# using the argument "bins"
# $$$ ANSWER:


## superposition within a categorical variable
############################################### #
# Example data
head(ChickWeight)
str(ChickWeight)
# Observation: time is defined as continuous, but it is actually categorical

sc <- ggplot(ChickWeight, aes(x=factor(Time), y=weight))
sc + geom_point()

# Solution 1: point jittering (random slight changes in position)
sc + geom_point(position=position_jitter(0.2))
sc + geom_jitter(width = 0.2)

# $$$ Exercise: run the plot above different times.
# Does it change? why?
# $$$ ANSWER: 

# $$$ Exercise: modify the values of width and height in position_jitter()
sc + geom_point(position=position_jitter(width=0.2, height=0))
# $$$ ANSWER: 


# $$$ Exercise: in which of the following plots may be advisable
# to use width>0 and height>0?
ggplot(ChickWeight, aes(x=Time, y=weight)) + 
  geom_point(position=position_jitter(width=0.2, height=0))
ggplot(ChickWeight, aes(x=weight, y=Time)) + 
  geom_point(position=position_jitter(width=0, height=0.2))
# $$$ ANSWER:


# Solution 2: don't make a scatterplot ;)
# Point variation can be synthesized in other ways
# e.g., a box-plot grouped by a categorical variable
# $$$ Exercise*: use "geom_boxplot()" to represent weight at different times
# Tip: use factor(Time) or group=Time to specify that you wish to group data into Time categories
# $$$ ANSWER:



############ #
#### 3.5. ## Scatterplots with marginal rugs: geom_rug() #### 
############################################################# #
# to see data distribution across each axis

# Example:
str(faithful)
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  geom_point() + 
  geom_rug()
# Observation: rugs in y-axis are superposed

# $$$ Exercise: jitter y-axis rugs
# $$$ ANSWER:



# $$$ Exercise*: jitter both axis rugs
# $$$ ANSWER:



############ #
#### 3.6. ## Scatterplot with adjusted regression line: stat_smooth() #### 
########################################################################## #
str(heightweight)
sr <- ggplot(heightweight, aes(x=ageYear, y=heightIn))
sr + geom_point()

# $$$ Exercise: represent the points and the adjusted line
# Tip: stat_smooth() or geom_smooth()
# $$$ ANSWER: 


# Observation: by default it uses "loess" method, that combines
# locally-adjusted polynomials
# Observation 2: by default it defines a confidence interval of 95%

# $$$ Exercise: search in R help which are the arguments of stat_smooth()
# to modify adjustment method and confidence level.
# Make a new graph adjusting a linear model (lm) with a 99% confidence interval.
# $$$ ANSWER: 



# $$$ Exercise: find how to hide confidence interval
# $$$ ANSWER: 



# $$$ Exercise*: colour the line in red, and CI in pink
# $$$ ANSWER: 


# $$$ Exercise: group points by sex and adjust a line for each sex
# $$$ ANSWER: two options:




# $$$ Exercise*: imagine how would you represent a line adjusted with a different model than those
# offered in stat_smooth() options (i.e, how would you do it manually)
# $$$ ANSWER: 



# Observation: stat_smooth() serves to draw an adjusted line using most common methods


############ #
#### 3.7. ## Scatterplots aesthetics #### 
######################################### #

## Aesthetics SETTING in geom_point(): shape, size, colour, fill
##################################### #
# $$$ Exercise: try to change values of shape, size, colour, fill. 
# Tip 1: you can define point shapes with numbers
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(shape=68, size=3, colour= "red", fill="pink")
# tip 2: you can define point shapes by any keyboard symbol inside ""
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(shape="A", size=3, colour= "red", fill="pink")
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(shape="?", size=3, colour= "red", fill="pink")
# tip 3: you can define point shapes with shortcuts in an extended numeric keyboard, using "" 
# Alt+number. Example: Alt+3 gives a heart ???
# See a list of possibilities in: https://typefacts.com/en/articles/keyboard-shortcuts
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(shape="", size=3, colour= "red")
# tip 4: among usual shapes, fill only works for point shapes 21-25
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point(shape=22, size=3, colour= "red", fill="pink")
# tip 5: see some shape options in this plot:
d=data.frame(p=c(0:25,32:127))
ggplot() +
  scale_y_continuous(name="") +
  scale_x_continuous(name="") +
  scale_shape_identity() +
  geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red") +
  geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)
# Observe:
# shapes= 1-14 only have a line (-> use "colour")
# shapes 15-20 are solid (-> use "colour")
# shapes 21-25 have line and filling (use "colour" and "fill", respectively)
# above 25, symbols


## Scatterplot with automatically-labeled points 
################################################## #
# Example
countr <- subset(countries, Year==2009 & healthexp>2000)
head(countr)
str(countr)

sp <- ggplot(countr, aes(x=healthexp, y=infmortality)) 
sp + geom_point() +
  geom_text(aes(label=Name))
# Observation: label superposition! :(

### Unsatisfactory solutions:
# 1- Manual labeling using annotate()
#    (not affordable for many points!)
# 2- Adjust all label positions at the same time 
#    using vjust and hjust
      # $$$ Exercise: change vjust and hjust to avoid superposition
      # tip: 0.5 are the values by default
      sp + geom_point() +
        geom_text(aes(label=Name), vjust=0.5, hjust=1)
# 3- Select only some labels to plot (create a new variable with NAs in those to hide)

### Nice solution: ggrepel
# ggrepel is an extension of ggplot2 (i.e., it is another package)
# see: http://www.ggplot2-exts.org/gallery/
sp + geom_point() +
  geom_text_repel(aes(label=Name), segment.color = "red")


######################################## #
#### 4 ### LINE GRAPHS: geom_line() ####   
######################################## #

############ #
#### 4.1. ## Basic Line Graph #### 
################################## #

## x, y: continuous variables
############################## #
# Data
BOD
str(BOD)

# $$$ Exercise: transform the following scatterplot in a line plot
ggplot(BOD, aes(x=Time, y=demand)) + geom_point()
# $$$ ANSWER:


## y: continuous variable; x: categorical 
########################################### #
# Time will now be a factor (categorical):
BOD$TimeFact <- factor(BOD$Time)
str(BOD)
# $$$ Exercise: try and read the error:
ggplot(BOD, aes(x=TimeFact, y=demand)) + geom_line()

# $$$ Exercise: now try this way:
ggplot(BOD, aes(x=TimeFact, y=demand, group=1)) + geom_line()
# Observation: when x variable is a factor, 
# we need to use aes(group=1) for ggplot() to understand that 
# points belong to a single group and must be joined by a single line
# In fact it can be group="anything". It is just to indicate that all 
# points pertain to the same group


############ #
#### 4.2. ## Multiple Line Graph: multiple lines, one per group #### 
#################################################################### #

## x, y: continuous variables
############################## #
# Data
tg <- ddply(ToothGrowth, c("supp", "dose"), summarise, length=mean(len))
tg
str(tg)

ggplot(tg, aes(x=dose, y=length)) + geom_line() + geom_point()
# Observation: there are different y-values for single x-values.
# That suggests that we have grouped data.

# $$$ Exercise: Transform the following graph to represent two lines, 
# one for OJ and one for VC groups
# Tip: they can be of different colour
ggplot(tg, aes(x=dose, y=length)) + geom_line()
# $$$ ANSWER:



# $$$ Exercise*: Now differentiate them by linetype
# (publishing in colours is expensive!)
# Tip: linetype
# $$$ ANSWER:


# $$$ Exercise*: differentiate the two groups by point shape
# Tip: you can enlarge points to facilitate shape discrimination
# $$$ ANSWER:



# $$$ Exercise: differentiate the two groups by point colour
# Tip: fill for shapes 21-25, colour for others
# Tip2: you can enlarge points to facilitate colour discrimination
ggplot(tg, aes(x=dose, y=length, fill=supp)) + geom_line() +
  geom_point(size=4, shape=21)
ggplot(tg, aes(x=dose, y=length, fill=supp, colour=supp)) + geom_line() +
  geom_point(size=4, shape=21)


## 1 continuous and 1 categorical
################################### #
# As we saw above, in graph lines with categorical variables we need to specify 
# the argument "group" in aes() (group=1 if all belong to the same group as above)
ggplot(tg, aes(x=factor(dose), y=length, group=1)) + geom_line()

# If we wish to make one line per group, we need to specify the grouping factor in group: 
ggplot(tg, aes(x=factor(dose), y=length, group=supp)) + 
  geom_line()

# If we want to differentiate them also by a aesthetic (e.g., colour),
# we need to specify both arguments (e.g., group and colour)
ggplot(tg, aes(x=factor(dose), y=length, group=supp, colour=supp)) + 
  geom_line()

# $$$ Data for exercises
uspopage2 <- uspopage
uspopage2$Year_fact <- factor(uspopage2$Year)
str(uspopage2)

# $$$ Exercise: represent the variation of Thousands across Year, for each AgeGroup
# Tip: Year is continuous
# $$$ ANSWER:



# $$$ Exercise: represent the variation of Thousands across Year_fact, for each AgeGroup
# Tip: Year_fact is categorical 
# $$$ ANSWER:




############ #
#### 4.3. ## Confidence interval #### 
##################################### #
# Data
clim <- subset(climate, Source == "Berkeley",
               select=c("Year", "Anomaly10y", "Unc10y"))
str(clim)

## CI as an area: geom_ribbon()
################################ #
# $$$ Exercise: complete the code to make a LineGraph with an area confidence interval
# considering that:
# for each year, inf CI limit is defined by: Anomaly10y-Unc10y
# for each year, sup CI limit is defined by: Anomaly10y+Unc10y
# ggplot(clim, aes(x=Year, y=Anomaly10y)) +
#   geom_ribbon(aes(ymin=_____, ymax=_____), alpha=0.2, fill="blue") +
#   geom_line()
# $$$ ANSWER:




## CI as two lines
################### #
# $$$ Exercise: try to create a LineGraph with CI represented by lines, 
# considering that:
# for each year, inf CI limit is defined by: Anomaly10y-Unc10y
# for each year, sup CI limit is defined by: Anomaly10y+Unc10y
# Tip: differentiate main and CI lines by colour or linetype (e.g., colour="red", linetype="dotted")
# $$$ ANSWER:




# Observation: we can plot different variables in the y-axis using different geoms!

############ #
#### 4.4. ## Line Graphs Aesthetics #### 
######################################## #

## Axes limits: ylim(), xlim(), expand_limits()
############### #
# $$$ Exercise: observe how the following codes change the axes
ggplot(BOD, aes(x=Time, y=demand)) + geom_line()
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() + 
  ylim(0, 25) + xlim(-10,20)
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() + 
  expand_limits(y=0, x=c(-10,20))

# $$$ Exercise: change the limits of x-axis to vary 
# from 0 to the maximum value of Time, using xlim()
# Tip: max of Time is max(BOD$Time)
# $$$ ANSWER:


# $$$ Exercise: expand x-axis limits to start in 0, using expand_limits()
# $$$ ANSWER:
 

# $$$ Exercise*: expand x-axis limits from 0 to 10, using expand_limits()
# $$$ ANSWER:



## logarithmic axes: scale_y_log10(), scale_x_log10()
##################################################### #
# $$$ Exercise: given the title of this section, imagine how to transform 
# y-axis to log 10:
ggplot(worldpop, aes(x=Year, y=Population)) + geom_line() + geom_point() 
# $$$ ANSWER:



## Avoid superposition of lines or points: position=position_dodge()
##################################################################### #
# $$$ Exercise: modify the value in position_dodge() to avoid superposition in lines and points
# Tip: start trying values between 0.1 and 0.5
# ggplot(tg, aes(x=dose, y=length, shape=supp)) +
#   geom_line(position=position_dodge(0)) + 
#   geom_point(position=position_dodge(0), size=4)
ggplot(tg, aes(x=dose, y=length, shape=supp)) +
  geom_line(position=position_dodge(0.4)) + 
  geom_point(position=position_dodge(0.4), size=4)

## Aesthetics SETTING in geom_line(): linetype, size, colour
##################################### #
# $$$ Exercise: modify the values of linetype, size, colour. 
# Tip: You can define colours either by code number or by name
# Tip 2: colour possibilities (by code and name):
# http://research.stowers.org/mcm/efg/R/Color/Chart/ColorChart.pdf
# Tip3: Text for linetype: "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"
ggplot(BOD, aes(x=Time, y=demand)) +
  geom_line(linetype="dotdash", size=2, colour="coral1")

# $$$ Exercise*: create a new linetype pattern
# Tip4: you can define a linetype pattern with paired numbers: 
# the first defines the length of the segment and the second the length of space
ggplot(BOD, aes(x=Time, y=demand)) +
  geom_line(linetype="1199", size=2, colour="coral1")
ggplot(BOD, aes(x=Time, y=demand)) +
  geom_line(linetype="24", size=2, colour="coral1")

## Lines before points
####################### #
# $$$ Exercise: observe differences in code and graphs:
# Optimal
ggplot(tg, aes(x=dose, y=length, colour=supp)) +
  geom_line() +
  geom_point(shape=22, size=7, fill="white")
# Suboptimal
ggplot(tg, aes(x=dose, y=length, colour=supp)) +
  geom_point(shape=22, size=7, fill="white") +
  geom_line() 

## Areas before lines
###################### #
# $$$ Exercise: observe differences in code and graphs:
# Optimal
ggplot(clim, aes(x=Year, y=Anomaly10y)) +
  geom_ribbon(aes(ymin=Anomaly10y-Unc10y, ymax=Anomaly10y+Unc10y), fill="lightblue") +
  geom_line()
# Suboptimal
ggplot(clim, aes(x=Year, y=Anomaly10y)) +
  geom_line() +
  geom_ribbon(aes(ymin=Anomaly10y-Unc10y, ymax=Anomaly10y+Unc10y), fill="lightblue")

######################################## #
#### 5 ### AREA GRAPHS: geom_area() ####     
######################################## #

############ #
#### 5.1. ## Basic Area Graph #### 
################################## #
# Data
sunspotyear <- data.frame(
  Year = as.numeric(time(sunspot.year)),
  Sunspots = as.numeric(sunspot.year))
str(sunspotyear)

# $$$ Exercise: Imagine how to represent sunspots per year, using an area graph.
# Tip: geom_area() is the function for area graph
# $$$ ANSWER:



############ #
#### 5.2. ## Multiple Area Graph: one area per group #### 
######################################################### #

## Stacked: default
########### #
# Do you remember this graph?:
ggplot(tg, aes(x=dose, y=length, colour=supp)) + geom_line()

# $$$ Exercise: Transform the graph in two superpositioned areas
# Tip: remember that "colour" is used to colour lines, and "fill" to colour areas
# $$$ ANSWER:


# $$$ Exercise: represent how EEUU population size has varied across time
# for each age group, using stacked areas 
# Data:
head(uspopage)
str(uspopage)
# $$$ ANSWER:



## Proportional Stacked: proportion of each group: geom_area(position="fill")
################################################## #
# Data
head(uspopage)

# $$$ Exercise: specify position="fill" as an argument of geom_area() 
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) + geom_area()
# $$$ ANSWER:



## Non-Stacked: geom_area(position="identity")
################ #
ggplot(tg, aes(x=dose, y=length, fill=supp)) + geom_area(position="identity")

# $$$ Exercise: represent how EEUU population size has varied across time
# for each age group, using non-stacked areas 
# Data:
head(uspopage)
str(uspopage)
# $$$ ANSWER:



############ #
#### 5.4. ## Area Graphs aesthetics #### 
######################################## #

## Aesthetics SETTING in geom_area: colour, fill, alpha
################################### #

### Area transparency: alpha
# $$$ Exercise: try to change the value of alpha argument from 0 to 1
# ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) +
#   geom_area(position="identity", alpha=____)
# $$$ ANSWER:



### Lines to highlight area perimeter: colour
# $$$ Exercise: draw a black line around the areas in the following graphs 
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area(alpha=0.4)
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area(position="identity", alpha=0.2)
# $$$ ANSWER:



# $$$ Exercise: colour each line of the same colour than its area 
# $$$ ANSWER:



# $$$ Exercise*: think another way to draw a black line above each area
# Tip: think in building a graph in layers! you can use different functions
# Tip2: you will need the argument position="stack" in the new layer (the area layer is stacked by default)
# $$$ ANSWER:



### Colour, fill, alpha 
# $$$ Exercise: change values of arguments colour, fill, alpha
ggplot(sunspotyear, aes(x=Year, y=Sunspots)) +
  geom_area(colour="red", fill="darkorchid1", alpha=0.5)


################################################### #
#### 6 ### BARPLOTS: geom_bar(stat="identity") ####   
################################################### #

########### #
#### 6.1 ## Basic Barplot #### 
############################## #

## Categorical variable in x-axis
################################## #
# Data
pg_mean

# $$$ Exercise: Create a barplot with one bar per "group", of height "weight".
# ggplot(_____, aes(x=_____, y=_____)) + geom_bar(stat="identity")
# $$$ ANSWER:


# Observation: we use stat="identity" to represent values of y variable.
# Otherwise, by default, geom_bar() makes a frequency plot (default: stat="count")
# and we do not need to define y:
ggplot(pg_mean, aes(x=group)) + geom_bar()
ggplot(pg_mean, aes(x=group)) + geom_bar(stat="count")

## Continuous variable in x-axis
################################## #
# Data
head(BOD)
str(BOD)
# $$$ Exercise: Represent demand at different times
# $$$ ANSWER:


# Observation: all possible values between the minimum and maximum value in x-axis 
# are represented, including time=6 for which there is no demand information

# $$$ Exercise: Represent only values in x-axis for which there is y information
# Tip: transform the x variable in factor using factor()
# $$$ ANSWER:



############ #
#### 6.2. ## Multiple barplot: group bars considering a second variable #### 
############################## #
## Grouped Barplot: stacked bars: default
################################# #
# Data
cabbage_exp
str(cabbage_exp)

# $$$ Exercise: Represent Weight in different dates
# Tip: you aim to represent variable values in y-axis, so you need to use stat="identity"
# $$$ ANSWER:



# $$$ Exercise: Now you want to identify which part of weight corresponds to each Cultivar group
# Tip: You can colour bars using "fill" argument
# $$$ ANSWER:


# Observation: bars are stacked (one on top of the other)

## Grouped barplot: bars side to side: geom_bar(position="dodge")
###################################### #
# $$$ Exercise: For each date, you want two bars side to side: one for 
# each cultivar group
# Tip: same structure than for stacked barplot, but using the argument position="dodge"
# $$$ ANSWER:



# $$$ Exercise*: now differentiate bars by the colour of their peripherical lines
# $$$ ANSWER:



## Grouped Barplot: superimposed bars: geom_bar(position="identity")
###################################### #
# Using geom_bar(): stat="identity", position="identity"
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity", position="identity", alpha=0.4)

############ #
#### 6.3. ## Barplot aesthetics #### 
#################################### #

## Horizontal barplot: coord_flip()
###################### #
# For horizontal bars, we need to shift axis coordinates 
# using coord_flip() as a new layer

# $$$ Exercise: transform the following graph in an horizontal barplot
ggplot(cabbage_exp, aes(x=Date, y=Weight)) +
  geom_bar(stat="identity") 
# $$$ ANSWER:



# Coord_flip() can be used with other geoms:
# $$$ Exercise*: shift axis of the following line graph:
ggplot(dat, aes(x=xval, y=yval)) + geom_line(aes(colour=group))
# $$$ ANSWER:


## Reorder bar position: x=reorder()
######################## #
# Basic graph:
ggplot(cabbage_exp, aes(x=Date, y=Weight)) +
  geom_bar(stat="identity")
# Bars reordered by weight (lighter to heavier)
ggplot(cabbage_exp, aes(x=reorder(Date, Weight), y=Weight)) +
  geom_bar(stat="identity")
# Bars reordered by weight (heavier to lighter)
ggplot(cabbage_exp, aes(x=reorder(Date, -Weight), y=Weight)) +
  geom_bar(stat="identity")

# $$$ Exercise: Represent change in states, ordering bars from larger to lower change
# Tip: use variable Abb instead of state for a better visualization
# Data:
upc <- subset(uspopchange, rank(Change)>40)
upc
ggplot(upc, aes(x=Abb, y=Change)) + 
  geom_bar(stat="identity")
# $$$ ANSWER:



# $$$ Exercise: now identify with different colours states from South and West
# $$$ ANSWER:



## Control bar width in geom_bar()
################################## #
# $$$ Exercise: modify bar width in the following graph using 
# the argument width
# Tip: width can vary from 0 to 1 with no bar superposition. By default, width=0.9
ggplot(upc, aes(x=Abb, y=Change, fill=Region)) + 
  geom_bar(stat="identity")
# $$$ ANSWER:



## Control bar spacing in grouped barplots (geom_bar())
######################################################## #
# $$$ Exercise: modify bar width and spacing in the graph below
# modifying width() and position=position_dodge(): 
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
  geom_bar(stat="identity", width=0.9, position=position_dodge(0.9))
# $$$ ANSWER:



## Aesthetics SETTING in geom_bar()
#################################### #
# $$$ Exercise: set a unique nice colour for all bars
# ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity")
# $$$ ANSWER:



# $$$ Exercise: now define the colour of the line surrounding bars
# $$$ ANSWER:



# $$$ Exercise*: Now make this line "dashed" (Tip: linetype)
# $$$ ANSWER:



## Aesthetics MAPPING in geom_bar()
#################################### #
# We have already seen many.. but let's do another one!
# Data:
csub <- subset(climate, Source=="Berkeley" & Year >= 1900)
head(csub)
View(csub)
# $$$ Exercise: you want to colour positive and negative values in different colours
ggplot(csub, aes(x=Year, y=Anomaly10y)) +
  geom_bar(stat="identity")
# Tip: create a logical variable to identify positive and negative values and then use it 
# $$$ ANSWER:






#***************************************************************************************
# BLOCK 2.2.  - DISTRIBUTION GRAPHS: frequency and density graphs
#***************************************************************************************
# * 7- Histogram         : geom_histogram(), geom_bar()   [FREQUENCY]
# * 8- Frequency polygon : geom_freqpoly()                [FREQUENCY]
# * 9- Density curve     : geom_density()                 [DENSITY]

# * 10- Boxplot          : geom_boxplot()                 [FREQUENCY]
# * 11- Violin plot      : geom_violin()                  [DENSITY]

# * 12- 2D Frequency map : stat_bin2d()                   [FREQUENCY]
# * 13- 2D Density map   : stat_density2d()               [DENSITY]
#***************************************************************************************

# FREQUENCY graph: associates a frequency to each value of a variable (OBSERVED)
# DENSITY graph  : associates a probability to each value of a variable (PREDICTED)

# A density graph computes and draws kernel density estimate.
# Kernel density estimate: https://en.wikipedia.org/wiki/Kernel_density_estimation

#***************************************************************************************
# * 7- Histogram         : geom_histogram(), geom_bar()   [FREQUENCY]
# * 8- Frequency polygon : geom_freqpoly()                [FREQUENCY]
# * 9- Density curve     : geom_density()                 [DENSITY]
#***************************************************************************************
################################################################################# #  
#### 7 ### HISTOGRAM: geom_bar(), geom_bar(stat="bin") and geom_histogram()  ####   
################################################################################# #  

########### #
#### 7.1 ## Basic histogram #### 
################################ #
# Data
diamonds
str(diamonds)

## Categorical variable in x-axis: geom_bar()
################################## #
# Each line in the dataframe is a case. The aim is to represent the number of cases
# (i.e., the frequency) in each level of a categorical variable (e.g., "cut" variable) 
ggplot(diamonds, aes(x=cut)) + geom_bar()

# Observation 1: we are not specifying "y", because "y" will be the frequency of cases in x-levels
# (see y axis title: "count")
# Observation 2: we are using geom_bar() without specifying stat, because default is stat="count"
# (see below:)
ggplot(diamonds, aes(x=cut)) + geom_bar()
ggplot(diamonds, aes(x=cut)) + geom_bar(stat="count")

# $$$ Exercise: Create another frequency barplot of another categorical variable in diamond database
# $$$ ANSWER:



## Continuous variable in x-axis: geom_bar(), geom_bar(stat="bin") and geom_histogram()
################################# #
# $$$ Exercise: Create an histogram of a continuous variable in diamond database using geom_bar()
# $$$ ANSWER:



# Observation: geom_bar() creates one bar per x-value

# $$$ Exercise*: confere that default is geom_bar(stat="count") in these graphs
# $$$ ANSWER:



# $$$ Exercise: Transform your graph using geom_bar(stat="bin")
# $$$ ANSWER:


# Observation: stat="bin" groups values of a continuous variable in x-axis
# (instead of making one bar per x-value)

# $$$ Exercise: Repeat the graph using geom_histogram() instead of geom_bar()
# $$$ ANSWER:


# Observation 1: geom_histogram is analogous to geom_bar(stat="bin")
# Observation 2: In geom_histogram(), x is always a continuous variable
# Observation 3: geom_histogram() is more flexible to define bar number and width than geom_bar (see below..)

# $$$ Exercise*: Represent the frequency of values in waiting variable using histogram()
str(faithful)
# $$$ ANSWER:



########### #
#### 7.2 ## Multiple histogram: group bars considering a second variable #### 
############################### #

## Superimposed bars: geom_histogram(position="identity")
##################### #
str(heightweight)
ggplot(heightweight, aes(x=heightIn)) +   
  geom_histogram(position="identity", alpha=0.4)
ggplot(heightweight, aes(x=heightIn, fill=sex)) +   
  geom_histogram(position="identity", alpha=0.4)

# $$$ Exercise: represent diamonds prize for different cuts, 
# using superimposed bars (one layer per cut type)
# How many levels has the "cut" factor? is it easy to see the distribution of each level?
# str(diamonds)
# $$$ ANSWER:



# 5 levels, high sobreposition, difficult to see

########### #
#### 7.3 ## Histogram aesthetics #### 
##################################### #

## Control bar number in geom_histogram()
########################################## #
# $$$ Exercise: Modify the bins parameter below
# ggplot(diamonds, aes(x=carat)) + geom_histogram(bins = ___)
# $$$ ANSWER:



## Control bar width in geom_histogram()
######################################## #
# $$$ Exercise: Modify the binwidth parameter below
# ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth = ___)
# $$$ ANSWER:




#################################################### #   
#### 8 ### FREQUENCY POLYGONS: geom_freqpoly()  ####   
#################################################### #
# A frequency polygon shows the same information than an histogram (frequency of each value), 
# but using a line to join each frequency value

########### #
#### 8.1 ## Basic frequency polygon #### 
######################################## #

# $$$ Exercise: imagine how to complete the following graph to make a frequency polygon
ggplot(faithful, aes(x=waiting))
# $$$ ANSWER:



# $$$ Exercise: Use the argument "bins" to define the precision (as in histogram)
# $$$ ANSWER:



########### #
#### 8.2 ## Multiple frequency polygon ####
########################################### #

# $$$ Exercise: Do you remember this plot? - Transform it to a frequency polygon graph
ggplot(diamonds, aes(x=price, fill=cut)) + 
  geom_histogram(position="identity", alpha=0.3)
# $$$ ANSWER:



# $$$ Exercise: represent the frequency of heightIn values for each sex, using a polygon
str(heightweight)
# $$$ ANSWER:



########### #
#### 8.3 ## Frequency polygon aesthetics ####
############################################# #

## Aesthetics SETTING
ggplot(faithful, aes(x=waiting)) + 
  geom_freqpoly(bins=60, colour= "blue", linetype=3)


############################################################################# #
#### 9 ### DENSITY CURVE: geom_density() or geom_line(stat="density")    ####   
############################################################################# #

############ #
#### 9.1. ## Basic density curve ####
##################################### #
# geom_density()
ggplot(faithful, aes(x=waiting)) + 
  geom_density()

# geom_line(stat="density")
ggplot(faithful, aes(x=waiting)) + 
  geom_line(stat="density")

############ #
#### 9.2. ## Scaled density curve ####
###################################### #
# geom_density() scaled to proportional scale (range=0-1)
ggplot(faithful, aes(x=waiting)) + 
  geom_density(aes(y=..scaled..))

############ #
#### 9.3. ## Comparison of observed and estimated curves ####
############################################################# #
# $$$ Exercise*: Try to superimpose observed and estimated distributions of "waiting" variable
# in "faithful" database.
# You will probably have trouble :)
# Colour each distribution with a different colour to understand the problem.
# $$$ ANSWER:



# Observation: geom_density() represents probabilities, so the area below geom_density() sums 1. 
# As a consequence, y-axis values are very small (much smaller than observed values),
# so that if you plot observed and estimated distributions together you will not see variation in the density curve.

# $$$ Exercise*: Try it again.
# Tip: rescale y-axis of the frequency plot to the scale of y-axis in the estimated plot
# For that purpose, define aes(y=stat(density)) in the frequency plot.
# $$$ ANSWER:


 
# Observation: stat(density) or ..density.. is a "computed variable" or a "calculated aesthetic" 
# of geom_histogram() and geom_density(). 
# It is a new variable created by the geom_histogram() and geom_density() and dependent on original data. 
# See "Computed variables" in ?geom_density and ?geom_histogram.
# See also: https://ggplot2.tidyverse.org/reference/stat.html
# Both are density estimates scaled to integrated 1. One is continuous and the other by bins.
# In this example, the plot is using that of geom_histogram()
# This is the way more used to superimpose, but there are other options...

# $$$ Exercise*: Now rescale y-axis of the density plot to the scale of counts
# Look at geom_histogram() help and try to understand why the plot is slightly different than the one above.
# $$$ ANSWER:



# Observation: count in geom_density() is density * number of points,
# while count in geom_histogram() is number of points.

# $$$ Exercise**: Now re-scale both y-axis to a maximum of 1
# Look at geom_histogram() and geom_density() helps
# $$$ ANSWER:



# $$$ Exercise*: I said stat(density) is equivalent to ..density..
# Confer it
# $$$ ANSWER:

 

# $$$ Exercise*: Repeat it using the other frequency plot 
# (if you used histogram, now use freqpoly)
# $$$ ANSWER:




############ #
#### 9.4. ## Multiple density curves ####
######################################### #

## Superimposed density curves: default
######################################## #
# Data:
str(heightweight)

# $$$ Exercise: represent the density curve of heightIn for each sex
# $$$ ANSWER:



# $$$ Exercise*: Do you remember this histogram?:
ggplot(heightweight, aes(x=heightIn, fill=sex)) + 
  geom_histogram(position="identity", alpha=0.4)
# Now superimpose the histogram with density curves for each sex
# $$$ ANSWER:




## Stacked density curves: geom_density(position="stack")
########################################################## #
ggplot(heightweight, aes(x=heightIn, fill=sex)) + 
  geom_density(alpha=0.4)

# $$$ Exercise: Create a stacked version of the plot above, using the argument position="stack"
# $$$ ANSWER:



# $$$ Exercise: Now create a proportional stacked version, using the argument position="fill"
# $$$ ANSWER:



############ #
#### 9.5. ## Density curves aesthetics ####
########################################### #

## Adjustment level
#################### #
# The estimate can be more or less adjusted to data

# $$$ Exercise: Modify the value of adjust argument (adjust=1 by defult)
# in the following plots
ggplot(faithful, aes(x=waiting)) +
  geom_line(stat="density", adjust=0.1) 
ggplot(faithful, aes(x=waiting)) +
  geom_density(adjust=0.2) 

# $$$ Exercise*: Modify the adjust argument in the density curve to find the best adjustment
# to the frequency polygon
ggplot(faithful, aes(x=waiting)) + 
  geom_freqpoly(aes(y=..density..)) +
  geom_density(colour="red", adjust=0.7)
# $$$ ANSWER:



## Aesthetics setting: fill, colour, alpha
###################### #

# $$$ Exercise: use fill, colour and alpha to modify the following graph as required:
ggplot(faithful, aes(x=waiting)) +
  geom_density() 
# Blue transparent area and blue line above
# $$$ ANSWER:

 

# *Only blue transparent area
# $$$ ANSWER:



## x-axis limits 
################# #
# $$$ Exercise: expand x-axis limits to see the whole density curve
# Tip: xlim()
# $$$ ANSWER:




#***************************************************************************************
# * 10- Boxplot          : geom_boxplot()                 [FREQUENCY]
# * 11- Violin plot      : geom_violin()                  [DENSITY]
#***************************************************************************************
######################################## #
#### 10 ### BOXPLOT: geom_boxplot() ####
######################################## #

############# #
#### 10.1. ## Multiple Boxplot ####
################################### #
# Distribution of a continuous variable, 
# in groups defined by intervals of a second variable
# or in groups defined by the levels of a categorical variable
str(heightweight)
ggplot(heightweight, aes(x=sex, y=ageYear)) +
  geom_boxplot()

# To remember: Elements of a boxplot (from center to outside):
# * LINE: Median (percentile 50)
# * BOX: Interquartile range (IQR) (percentiles 25 and 75)
# * WHISKERS: from IQR to largest/smallest values or to 1.5*IQR
# * POINTS: outliers (beyond 1.5*IQR)

# To understand boxplots...
# https://en.wikipedia.org/wiki/Box_plot
# https://towardsdatascience.com/understanding-boxplots-5e2df7bcbd51
# https://medium.com/dayem-siddiqui/understanding-and-interpreting-box-plots-d07aab9d1b6c

# Krzywinski, M., & Altman, N. (2014). Visualizing samples with box plots: use box plots to illustrate the spread and differences of samples. Nature Methods, 11(2), 119-121.
# https://www.nature.com/articles/nmeth.2813.pdf?origin=ppub


# $$$ Exercise: represent diamonds price at cut classes using a boxplot
str(diamonds)
# $$$ ANSWER:



############ #
#### 10.2.## One-group boxplot ####
################################### #
ggplot(heightweight, aes(x=1, y=ageYear)) +
  geom_boxplot()
# observation: geom_boxplot() needs x-axis to be defined.
# if we are not interested in x-axis, we can define any value 
# (for instance x=1), and then hide x-axis labels
ggplot(heightweight, aes(x=1,y=ageYear)) +
  geom_boxplot() + 
  scale_x_continuous(breaks=NULL) +
  theme(axis.title.x = element_blank())

############ #
#### 10.3.## Boxplot + mean ####
################################ #
# $$$ Exercise: include a point representing the mean in the following boxplot
# Tip: stat_summary(fun.y="mean", geom="point") 
ggplot(diamonds, aes(x=cut, y=price)) +
  geom_boxplot() 
# $$$ ANSWER:



# $$$ Exercise*: confer that boxplot is actually representing the median
# $$$ ANSWER:




############ #
#### 10.4.## Boxplot aesthetics ####
#################################### #

## Emphasize the median: notch=TRUE
######################## #
# Notches are useful in offering a rough guide to significance of difference of medians; 
# if the notches of two boxes do not overlap, this offers evidence of a statistically significant difference between the medians. 
# The width of the notches is proportional to the interquartile range (IQR) of the sample and inversely proportional to the square root of the size of the sample.
# https://en.wikipedia.org/wiki/Box_plot

ggplot(heightweight, aes(x=sex, y=ageYear)) +
  geom_boxplot(notch=T)

## Box width: width
############# #
ggplot(heightweight, aes(x=sex, y=ageYear)) +
  geom_boxplot(width=0.2)

## Without outliers: outlier.colour=NA
#################### #
ggplot(diamonds, aes(x=cut, y=price)) +
  geom_boxplot()
ggplot(diamonds, aes(x=cut, y=price)) +
  geom_boxplot(outlier.colour=NA)
ggplot(diamonds, aes(x=cut, y=price)) +
  geom_boxplot(outlier.colour="grey70")   # ... or outliers in a lighter colour...

## Aesthetics setting
###################### #
ggplot(heightweight, aes(x=sex, y=ageYear)) +
  geom_boxplot(notch=T, colour="blue", fill="violet", linetype=4)


########################################### #
#### 11 ### VIOLIN PLOT: geom_violin() ####
########################################### #

############# #
#### 11.1. ## Basic violin plot ####
#################################### #
# Estimate distributions 
# Think of it as 2 mirror density curves
# Useful to compare multiple data distributions (easy to see)

ggplot(heightweight, aes(x=sex, y=ageYear)) +
  geom_violin(colour="brown", fill="orange")
ggplot(heightweight, aes(y=ageYear,x=1)) +
  geom_violin(colour="brown", fill="orange")

# $$$ Exercise: represent diamonds price at cut classes using a violin plot
str(diamonds)
# $$$ ANSWER:




############ #
#### 11.2.## Violin + boxplot ####
################################## #

# $$$ Exercise: superimpose the estimated and observed distributions 
# (including the average)
# Tip 1: adjust boxplot width (think on the boxplot as the chords of the violin!)
# Tip 2: you may want to omit boxplot outliers
# Tip 3: you may want to colour the box of boxplot in black
# Tip 4: you need to think in layer order!
# $$$ ANSWER:




############ #
#### 11.3.## Violin aesthetics ####
################################### #

## Limits: trim
########## #
# $$$ Exercise: use trim=FALSE in geom_violin(). 
# Search in help what is trim doing and what is its default.
ggplot(heightweight, aes(x=sex, y=ageYear)) +
  geom_violin(colour="brown", fill="orange")
# $$$ ANSWER:


# If TRUE (default), trim the tails of the violins to the range of the data. 
# If FALSE, don't trim the tails.

## Scale 
########## #
# $$$ Exercise: search in help what the argument "scale" does and
# try different values in the following plot
ggplot(diamonds, aes(x=cut, y=price)) +
  geom_violin(colour="purple", fill="lightblue")
# $$$ ANSWER:





## Adjust 
########## #
# $$$ Exercise: modify the argument adjust in the following plot and guess what it does:
ggplot(heightweight, aes(x=sex, y=ageYear)) +
  geom_violin(colour="brown", fill="orange", adjust=0.9)
# $$$ ANSWER:





#***************************************************************************************
# * 12- 2D Frequency map : stat_bin2d()                   [FREQUENCY]
# * 13- 2D Density map   : stat_density2d()               [DENSITY]
#***************************************************************************************
######################################################### #
#### 12 ### 2-DIMENSIONS FREQUENCY MAP: stat_bin2d() ####
######################################################### #
# Equivalent to an histogram representing two variables at a time

############# #
#### 12.1. ## Basic 2D frequency map ####
######################################### #
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  stat_bin2d()
# Observation: the colour represents "bar height"

## Two continuous variables
############################ #
# $$$ Exercise: represent the frequency map of diamonds carat and price
str(diamonds)
# $$$ ANSWER:


# Observation: do you remember? stat_bin2d() was an alternative for 
# high point superposition in a scatterplot

## One continuous and one categorical variable
############################################### #
# $$$ Exercise*: represent the frequency map of diamonds color and price 
# $$$ ANSWER:



## Two categorical variables
############################## #
# $$$ Exercise: represent the frequency map of diamonds clarity and colour 
# $$$ ANSWER:



############# #
#### 12.2. ## 2D frequency map aesthetics ####
############################################## #
# $$$ Exercise: change bins argument
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  stat_bin2d(bins=40)

# $$$ Exercise: does it make sense to modify the bins argument in a plot of
# two categorical variables?
# $$$ ANSWER: 


########################################################### #
#### 13 ### 2-DIMENSIONS DENSITY MAP: stat_density2d() ####
########################################################### #
# estimated values (density function) across two predictor variables

############# #
#### 13.1. ## Basic 2D density map ####
####################################### #

## Option 1: Level curves
########################### #
# Do you see any pattern in this point cloud?
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  geom_point()

# What is the probability of a new point to fall in the graph space?
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  geom_point() + 
  stat_density2d()
# Observation: you can see the them as level curves in a topographic map:
# the "altitude" depends on point density and defines probability of a new point to fall there 

## Option 2: raster map
######################### #
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  stat_density2d(aes(fill=..density..), geom="raster", contour=FALSE)
# Observation: the space between the two variables is divided in cells, 
# and point density (or the probability of a new point to fall in the cell) 
# is defined by colour

# $$$ Exercise: modify the graph above for point density to define transparency
# instead of colour
# $$$ ANSWER:



############# #
#### 13.2. ## Frequency map + density map ####
############################################## #
# $$$ Exercise*: Find a nice way to superimpose frequency and density maps 
# in the following graph:
ggplot(faithful, aes(x=eruptions, y=waiting))
# $$$ ANSWER: (one option)

 

############# #
#### 13.3. ## 2D density map aesthetics ####
############################################ #

## Colour level curves by level (i.e, by "mountain altitude")
############################################################## #
# $$$ Exercise*: Colour level curves by level in the following graph
# Tip: level of level curves is a new variable estimated by stat_density2d,
# that can be called as   ..level..   or as   stat(level)
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  stat_density2d()
# $$$ ANSWER:



## Level curves size (thicker to see colour)
############################################# #
# $$$ Exercise*: increase size argument for a better visualization of their colour
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  stat_density2d(aes(colour=..level..), size=0.5)
# $$$ ANSWER:



## Adjust
########## #
# Remember: density functions imply a level of adjustment to data
# $$$ Exercise: modify the argument h=c(,) to control adjustment to x-axis 
# and y-axis, respectively
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  stat_density2d(aes(fill=..density..), 
                 geom="raster", contour=FALSE, h=c(1,1))
# $$$ ANSWER:


# Observation: larger numbers mean a lower adjustment
# Observation 2: the effect depends on variables' scale



#***************************************************************************************
# BLOCK 2.3.  - GEOREFERENCED GRAPHS: MAPS
#***************************************************************************************
# * 14- Georeferenced graphs: Maps

########################################################### #
#### 14 ### GEOREFERENCED GRAPHS: MAPS                   ####
########################################################### #

############# #
#### 14.1. ## Spatial data in dataframe: geom_polygon(), geom_point(), geom_path() ####
####################################################################################### #
# data.frame or Spatial*DataFrame

# Example data:
world <- map_data("world")
world
str(world)

## Plot polygons
################# #
# geom_polygon() drawn lines between points and "closes them up" 
# (i.e. draws a line from the last point back to the first point)
ggplot() + 
  geom_polygon(data = world, aes(x = long, y = lat, group = group)) + 
  coord_quickmap()

# $$$ Exercise: modify the world map to define country borders in red and
# the area of countries in lightblue.
# $$$ ANSWER:



# $$$ Exercise: modify the world map to define country borders in black and
# the area of each country in a different colour.
# $$$ ANSWER:




# $$$ Exercise: modify the world map to define country borders in black and
# the area of each country in a different colour, but now a really different colour.
# Tip 1: Your grouping variable needs to be categorical. You can modify it before meking the plot.
# Tip 2: You will have that many categories that it is better not to plot the legend 
#        (use theme(legend.position = "none"))
# $$$ ANSWER:




## Plot points
################# #
# $$$ Exercise: Plot world cities in black. Database: world.cities
# $$$ ANSWER:




# $$$ Exercise: Now plot world cities in red over a black polygon of countries.
# $$$ ANSWER:




# $$$ Exercise: Finally, plot world cities over a black polygon of countries, and colour
# each city depending on the country to which it belongs.
# Tip: theme(legend.position = "none")
# $$$ ANSWER:





## Plot lines
################# #
rivers <- map_data("rivers")
ggplot() + 
  geom_polygon(data = map_data("world"), aes(x = long, y = lat, group = group)) + 
  geom_path(data = rivers, aes(x = long, y = lat, group = group), colour="lightblue") + 
  coord_quickmap()


## Plot Raster
################# #
library(raster)
# Example data from worldclim
tmin <- getData("worldclim",var='tmin', res=10, lon=5, lat=45)
# Transform it to data.frame
tmindf <- as.data.frame(tmin, xy=T)

# $$$ Exercise: Plot the minimum temperature of March across the world.
# Tip: use geom_raster()
# Tip2: look at the structure of the database to guess where is March
# $$$ ANSWER:




## Map projection, Aspect ratio and Extent: coord_quickmap(), coord_map()
########################################################################## #
### Aspect ratio:
# coord_quickmap() or coord_map() sets the relationship between one unit in the y
# direction and one unit in the x direction so that the aspect ratio is ok.
# Thus, it is recommended to use them always.

### Extent: coord_quickmap(), coord_map()
ggplot() + 
  geom_polygon(data = map_data("world"), aes(x = long, y = lat, group = group)) + 
  coord_quickmap(xlim = c(-10, 40),  ylim = c(36, 70))

# $$$ Exercise: Zoom in the world map to focus on Spain.
# $$$ ANSWER:



### Map projection: coord_map()
# See list of possibilities in ?mapproject
ggplot() +
  borders("world", fill= "grey") +
  coord_map("ortho", orientation=c(61, 90, 0)) 

# $$$ Exercise: visualize the globe from the South Pole
# $$$ ANSWER:

 


## Use available layers
######################## #
## Available maps from {maps} and {mapdata}: outlines of continents, countries, states, etc.
# See lists in:
help(package = "maps")
help(package = "mapdata")
# The maps package comes with a plotting function, but we prefer ggplot ;)

# Transform spatial data into data frame using the map_data() function in ggplot2:
map_data("world")         # Low (mid) resolution World Map {maps}
map_data("lakes")         # World lakes database {maps}
map_data("worldHires")    # World map {mapdata}
map_data("rivers")        # World Rivers Map Database {mapdata}
world.cities              # World cities {maps}
map_data("world.cities")  # Points are already a dataframe!!! (so don't need transformation)

## A faster (but less flexible) way to use {maps} layers: borders() 
ggplot() +
  borders("world") +
  coord_quickmap()

ggplot() +
  borders("world") +
  borders("lakes", colour = "blue") +
  coord_quickmap()

ggplot() +
  borders("world") +
  borders("rivers", colour = "blue")+
  coord_quickmap()



############# #
#### 14.2. ## Spatial data in sf format: ggspatial() ####
######################################################### #
# Spatial manipulation in R is moving from package sp to new package sf
# sf: simple feature objects
# ggspatial allows the visualization of sf objects in ggplot

load_longlake_data() # Example data

## Plot any sf object: layer_spatial()
####################################### #

## Vectorial: Points
ggplot() +
  layer_spatial(data = longlake_buildingsdf) 

## Vectorial: Polygons
ggplot() +
  layer_spatial(data = longlake_waterdf)

## Vectorial: Lines
ggplot() +
  layer_spatial(data = longlake_roadsdf)

## Raster: RasterLayer
ggplot() +
  layer_spatial(data = longlake_depth_raster)

## Raster: RasterBrick
ggplot() +
  layer_spatial(data = longlake_osm)
ggplot() +
  layer_spatial(data = longlake_osm[[1]])


# $$$ Exercise: Plot the minimum temperature of March across the world.
tmin <- getData("worldclim",var='tmin', res=10)
# $$$ ANSWER:

 

# $$$ Exercise: Plot a raster, a point layer, a line layer and a polygon
# layer together.
# Tip: in order to include the raster layer, you need to think on the order of layers 
# and the filling (or not) of polygons.
# $$$ ANSWER:

 

# $$$ Exercise: Color the following sampling points based on the depth of the lake.
ggplot() +
  layer_spatial(data = longlake_waterdf, fill="lightblue") +
  layer_spatial(longlake_depthdf)
# $$$ ANSWER:



## Use available layers
######################## #

## 1) RNaturalEarth {rnaturalearth} & {rnaturalearthdata}
# Available data:
# https://www.naturalearthdata.com/features/
help(package = "rnaturalearth")
help(package = "rnaturalearthdata")

world <- ne_countries(scale = "medium", returnclass = "sf")
ggplot() +
  layer_spatial(data = world)

## 2) Open street maps {rosm}, already included in {ggspatial}
rosm::osm.types() # Available maps

ggplot() +
  annotation_map_tile(type = "osm") +
  layer_spatial(data = longlake_waterdf)

ggplot() +
  annotation_map_tile(type = "hillshade") +
  layer_spatial(data = longlake_waterdf)

## 3) Maps from Google Earth or Open Street Maps:  {ggmap} 
# {ggmap} simplifies the process of downloading these base maps 
# From 2018 you need to register online.

## CRS and extent: coord_sf()
############################## #
ggplot() +
  layer_spatial(data = world)

# Coordinate Reference System (CRS): crs
# CRS is automatically defined by the CRS of the first layer added to the plot,
# so that all layers are aligned.
# It can also be modified using coord_sf(crs= )
ggplot() +
  layer_spatial(data = world)+
  coord_sf(crs = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs ")

# Extent: xlim, ylim
ggplot() +
  layer_spatial(data = world)+
  coord_sf(xlim = c(-102.15, -74.12), ylim = c(7.65, 33.97))

## North arrow and scalebar
############################ #
ggplot() +
  layer_spatial(data = longlake_osm) +
  annotation_scale() +
  annotation_north_arrow()

# $$$ Exercise: Change the position of the arrow and the scalebar
# using the argument location.
# Tip: "tl"= top left, "tr"= top right, "bl"= bottom left, "br"= bottom right
# $$$ ANSWER:



# $$$ Exercise: Change the style of the scalebar.
# Tip: look at help
# $$$ ANSWER:





#**************************************
############## #
#### BLOCK 3  -  OPTIONAL LAYERS: facet_(), stat_(), scale_(), coord_(), labs(), annotate(), theme(), and more  ####
############## #
#**************************************

################################################### #
#### 15 ### FACETS: facet_grid(), facet_wrap() #### 
################################################### #
# Rules for multiple plots
# divide a grouped plot, to get one plot per group
# data:
data(mpg)
mpg
str(mpg)
p <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
p
# Grouped plot by drv variable:
ggplot(mpg, aes(x=displ, y=hwy, color=drv)) + geom_point()
# Grouped plot by cyl variable:
ggplot(mpg, aes(x=displ, y=hwy, color=factor(cyl))) + geom_point()

############# #
#### 15.1. ## Facets in lines or columns ####
############################################# #

## Vertical facets: one variable, graphs in lines: facet_grid(x~.)
#################### #
p + facet_grid(drv ~ .)

## Horizontal facets: one variable, graphs in columns: facet_grid(.~x)
###################### #
p + facet_grid(. ~ cyl)

############# #
#### 15.2. ## Facets in a grid ####
################################### #

## Facets in a grid with 2 variables: facet_grid(x~z)
##################################### #
# One variable defines lines and the other defines columns
p + facet_grid(year ~ class)
p + facet_grid(drv ~ cyl)

## Facets in a grid with 1 variable: facet_wrap( ~z)
#################################### #
p + facet_wrap( ~ class)
p + facet_wrap( ~ trans)
p + facet_wrap( ~ class)

# You can define number of lines or columns:
p + facet_wrap( ~ class, nrow=2)
p + facet_wrap( ~ class, ncol=2)


############# #
#### 15.3. ## Facets with flexible axes: scales="free_x", scales="free_y", scales="free" ####
######################################## #
p <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
p
p + facet_grid(drv ~ cyl) 

# Free y-axis
p + facet_grid(drv ~ cyl, scales="free_y")
# Free x-axis
p + facet_grid(drv ~ cyl, scales="free_x")
# Free y- and x-axis
p + facet_grid(drv ~ cyl, scales="free")

# $$$ Exercise: Make another plot using mpg database and including facets.
# $$$ ANSWER:




############################### #
#### 16 ### STATS: stat_() ####
############################### #
# Data statistics to be represented

############# #
#### 16.1. ## Functions without data: stat_function() ####
########################################################## #

## Plot standard functions 
########################### #
dat <- data.frame(ex = c(-5, 5))  # example (ex) just to specify range
dat

# Gaussian: dnorm
ggplot(dat, aes(x=ex)) + 
  stat_function(fun = dnorm)
ggplot(dat, aes(c(-5,5))) + 
  stat_function(fun = dnorm)

# Logaritmic: log
ggplot(dat, aes(x=ex)) +
  stat_function(fun = log)

# Exponential: exp
ggplot(dat, aes(x=ex)) +
  stat_function(fun = exp)

# Sine and Cosine: sin, cos
ggplot(dat, aes(x=ex)) +
  stat_function(fun = sin, colour = "red") +
  stat_function(fun = cos, colour = "blue")

## Define function parameters (args =   )
########################################## #
# $$$ Exercise: modify mean and sd of the following gaussian function
ggplot(dat, aes(x=ex)) +
  stat_function(fun = dnorm, args = list(mean = 0, sd = 1))
# $$$ ANSWER:



## Custom functions
#################### #
ggplot(dat, aes(x=ex)) +
  stat_function(fun = function(x, alpha, beta) {alpha + beta*x + 2*x^2} , args=list(alpha=2, beta=3))  # just an example

## Compare the function with simulated data
############################################ #
df <- data.frame(ex = rnorm(100)) # random data following a Gaussian distribution
ggplot(df, aes(x=ex)) + 
  geom_histogram()
ggplot(df, aes(x=ex)) + 
  stat_function(fun = dnorm, colour = "red")

# $$$ Exercise: compare the stat_function(dnorm) with the density curve of ex 
# (i.e., plot them together)
# $$$ ANSWER:




############# #
#### 16.2. ## stat_summary() ####
################################# #
# Do you remember?
ggplot(diamonds, aes(x=cut, y=price)) +
  geom_boxplot() +
  stat_summary(fun.y="median", geom="point", colour="red") +
  stat_summary(fun.y="mean", geom="point", colour="blue")

# We could also define a function for min and max values:
ggplot(diamonds, aes(x=cut, y=price)) +
  stat_summary(fun.y = mean, fun.ymin = min, fun.ymax = max) 
# Mean +- se
ggplot(diamonds, aes(x=cut, y=price)) +
  stat_summary() # default: geom = "pointrange"; i.e., mean_se()


############# #
#### 16.3. ## Others we have already used ####
############################################## #
# Stat smooth: adjusted line, with confidence interval
ggplot(heightweight, aes(x=ageYear, y=heightIn)) + 
  geom_point() + 
  stat_smooth()
# stat_bin2d(): frequency for two variables
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  stat_bin2d()
# stat_density2d(): density for two variables
ggplot(faithful, aes(x=eruptions, y=waiting)) + 
  stat_density2d()


################################# #
#### 17 ### SCALES: scale_() ####
################################# #
# Mapping rules in relation to scale
# See Aesthetic specification vignette in: vignette("ggplot2-specs")

############# #
#### 17.1 ### COLOUR PALETTES:  scale_fill_(), scale_colour_() ####
############################## #
## Note: all the following functions work either with fill or colour!

############# #
## 17.1.1. ## Predefined palettes for discrete variables 
######################################################### #
d <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) + geom_area()

## Default palettes
##################### #
# Default colour scales for categorical variables. 
# It maps each level to an evenly spaced hue on the colour wheel. 
# It does not generate colour-blind safe palettes.

# 3 ways to get default palettes (first three with same results):
d
d + scale_fill_discrete()
d + scale_fill_hue()       
d + scale_fill_brewer()

## ColorBrewer palette (http://colorbrewer.org.)
####################### #
# Default
d + scale_fill_brewer()

# Available ColorBrewer Palettes:
# library(RColorBrewer)
display.brewer.all()

# ColorBrewer Palettes are called by name:
d + scale_fill_brewer(palette="Oranges")
d + scale_fill_brewer(palette="Paired")
d + scale_fill_brewer(palette="Spectral")
d + scale_fill_brewer(palette="YlOrRd")

## Colour-blind palettes
######################### #
# Color blind for discrete variables
d + scale_fill_viridis_d()

## Grey palette
################ #
d + scale_fill_grey()

## Reverse palette direction and/or use a specific range of it
################################################################ #
d + scale_fill_grey()
# $$$ Exercise: Modify the arguments "start" and "end" from 0 to 1
# $$$ ANSWER:




############# #
## 17.1.2. ## Predefined palettes for continuous variables 
########################################################### #
c <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb)) +
  geom_point(size=3)
c

## Default Palettes
##################### #
c
c + scale_colour_continuous()
c + scale_colour_gradient()
c + scale_color_continuous_tableau()
c + scale_color_gradient_tableau()

## Specified Palettes
###################### #
c + scale_color_continuous_tableau("Red-Gold")
c + scale_color_continuous_tableau("Blue-Teal")
c + scale_color_continuous_tableau("Gray Warm")
c + scale_color_gradient_tableau("Green")

## Colour-blind palettes
######################### #
# Color blid for continuous variables
c + scale_colour_viridis_c()

############# #
## 17.1.3. ## Create palettes for discrete variables manually
############################################################## #
dm <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) + geom_point()
dm

## 1 - Look at the number of levels and their order
length(levels(heightweight$sex))
levels(heightweight$sex)

## 2 - Define the palette following levels order...:
 # a) Using colour names
 dm + scale_colour_manual(values=c("green", "yellow"))

 # b) Using RGB codes
 dm + scale_colour_manual(values=c("#CC6666", "#7777DD"))

## 2 - ... or define the colour for each factor level
 dm + scale_colour_manual(values=c(m="violet", f="red"))

## Colour Chart
################# #
# See ColourChart (colour names and codes) in:
# https://rstudio-pubs-static.s3.amazonaws.com/3486_79191ad32cf74955b4502b8530aad627.html

## Colour adobe
################ #
# https://color.adobe.com/
 
## My color space
################## #
# Search for nice colour combinations:
# https://mycolor.space/   # Discrete palettes

## Manual colour-blind palettes 
################################## #
cb_palette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442",
                "#0072B2", "#D55E00", "#CC79A7")
cb_palette2 <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00",
                 "#CC79A7")

d + scale_fill_manual(values=cb_palette)
d + scale_fill_manual(values=cb_palette2)


############# #
## 17.1.4. ## Create palettes for continuous variables manually
################################################################ #
# Gradient with 2 colours
c + scale_colour_gradient(low="black", high="white")

# Gradiente with 3 colours: one intermediate and two extreme
c + scale_colour_gradient2(low="red", mid="white", high="blue",
                           midpoint=100)

# Gradient with n colours, equitatively spaciated
c + scale_colour_gradientn(colours = c("darkred", "orange", "yellow", "white"))

# Gradient with n colours, defining break points
c + scale_colour_gradientn(colours = c("darkred", "orange", "yellow", "white"),
                           breaks=c(50,70,90,110))

## Colour Chart
################# #
# See ColourChart (colour names and codes) in:
# https://rstudio-pubs-static.s3.amazonaws.com/3486_79191ad32cf74955b4502b8530aad627.html

## Colour adobe
################ #
# https://color.adobe.com/

## My color space
################## #
# Search for nice colour combinations:
# https://mycolor.space/gradient  # 2-colour gradients
# https://mycolor.space/gradient3 # 3-colour gradient


# $$$ Exercise: create yourself! - you can use either the colour chart 
# or "my color space" to choose colours
# $$$ ANSWER:




############# #
## 17.1.5. ## Change colour lightness, chroma, hues, saturation
################################################################ #

## Color lightness: 0 to 100 (default: l = 65)
################### #
p <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) + geom_area()
p
# $$$ Exercise: change lightness parameter
p + scale_fill_hue(l=65)
# $$$ ANSWER:


## Colour chroma (default: c = 100) (max depends on hue and luminance)
################# #
# $$$ Exercise: change chroma parameter
p + scale_fill_discrete(c=100)
# $$$ ANSWER:


## Hues range: 0 to 360 (default: h = c(0,360))
############## #
# $$$ Exercise: change hues range
p + scale_fill_discrete(h=c(0,360))
# $$$ ANSWER:


## Reduce colour saturation: muted("")
############################ #
# library(scales)
c
c + scale_colour_gradient2(low="red", mid="white", high="blue",
                           midpoint=110)
c + scale_colour_gradient2(low=muted("red"), mid="white", high=muted("blue"),
                           midpoint=110)


############# #
#### 17.2 ### PALETES FOR OTHER AES:  scale_alpha_(), scale_linetype_(), scale_shape() ####
##################################### #

############# #
## 17.2.1. ## Transparency scales: scale_alpha_()
################################## #
ct <- ggplot(heightweight, aes(x=ageYear, y=heightIn, alpha=weightLb)) +
  geom_point(size=3)
ct
## Alpha range
############### #
ct + scale_alpha(range = c(0.5, 1))

############# #
## 17.2.2. ## Linetype scales: scale_linetype_()
############################## #
dl <- ggplot(uspopage, aes(x=Year, y=Thousands, linetype=AgeGroup)) + 
  geom_line()

# line types available in R software are : 
# "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash".

dl + scale_linetype_manual(values=c("11","22","33","44","55","66","77","88"))

############# #
## 17.2.3. ## Shape scales: scale_shape()
########################### #
dms <- ggplot(heightweight, aes(x=ageYear, y=heightIn, shape=sex)) + geom_point()
dms

dms + scale_shape_manual(values = c(25,1))


############# #
## 17.2.4. ## Size scales: scale_size(), scale_radius(), scale_size_area() 
########################### #

# Continuous
cmss <- ggplot(mpg, aes(displ, hwy, size = hwy)) +
  geom_point()

cmss + scale_size(range = c(0, 10))    # defines size as area
cmss + scale_radius(range = c(0, 10))  # defines size as radius
cmss + scale_size_area(max_size=10)    # defines size as area, ensuring that value 0 = area 0

# Discrete
dmss <- ggplot(heightweight, aes(x=ageYear, y=heightIn, size=sex)) + geom_point(shape=1)
dmss

dmss + scale_size_manual(values=c(4, 2))  # defines size as area


############# #
#### 17.3 ### MANIPULATE AXES using scale_() and other analogous functions ####
############################## #
p <- ggplot(PlantGrowth, aes(x=group, y=weight)) + geom_boxplot()
p
############# #
## 17.3.1. ## Axes limits: xlim(), ylim(), scale_y_continuous(), 
########################## # scale_x_continuous(), expand_limits()
p + scale_y_continuous(limits=c(0,10))
p + ylim(0, 10)
p + expand_limits(y=0:10)

############# #
## 17.3.2. ## Axes direction 
############################# #

## Reverse continuous axes direction: scale_x_reverse(),scale_y_reverse()
##################################### #
p + scale_y_reverse()

## Reverse categorical axes direction: scale_x_discrete(limits=rev(levels()))
##################################### #
p
p + scale_x_discrete(limits=rev(levels(PlantGrowth$group)))

## Define categorical axes direction manually: scale_x_discrete(limits=)
############################################## #
p
p + scale_x_discrete(limits=c("trt1","trt2","ctrl"))

############# #
## 17.3.3. ## Categorical axes levels: scale_x_discrete(limits=), 
###################################### # scale_y_discrete(limits=)
p
p + scale_x_discrete(limits=c("ctrl","trt1"))

############# #
## 17.3.4. ## Axes scale transformation: scale_x_continuous(trans=), 
###################################### # scale_y_continuous(trans=)
p
p + scale_y_continuous(trans = "log")
p + scale_y_continuous(trans = "log10")
p + scale_y_continuous(trans = "exp")
p + scale_y_log10() # we already saw this one

############# #
## 17.3.5. ## Axes breaks: scale_y_continuous(),
########################## # scale_x_continuous()
sp <- ggplot(marathon, aes(x=Half,y=Full)) + geom_point()

## Define breaks
################# #
sp
sp + scale_y_continuous(breaks=seq(0, 420, 30)) +  # from 0 to 420, every 30
     scale_x_continuous(breaks=seq(0, 420, 30))

sp + scale_y_continuous(breaks=c(150,200,250,300)) 

## Eliminate breaks
#################### #
sp
sp + scale_y_continuous(breaks=NULL)+
     scale_x_continuous(breaks=NULL)

############# #
## 17.3.6. ## Tickmarks 
######################## #

## Tickmarks position: scale_y_continuous(breaks=),
###################### # scale_x_continuous(breaks=)
p + scale_y_continuous(breaks=c(4, 4.25, 4.5, 5, 6, 8))

## Tickmarks labels: scale_y_continuous(labels=),
#################### # scale_x_continuous(labels=)
hwp <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) +
  geom_point()
hwp
hwp + scale_y_continuous(breaks=c(50, 56, 60, 66, 72),
                         labels=c("Tiny", "Really\nshort", "Short",
                                  "Medium", "Tallish"))
############# #
## 17.3.7. ## Axes labels: scale_y_continuous(name=), 
########################## # scale_x_continuous(name=)
hwp + scale_y_continuous(name = "Height (inches)")

hwp + xlab("Age in years") + 
      ylab("Height in inches")



####################################### #
#### 18 ### COORDINATES: coord_()  ####
####################################### #
# Graph space

############# #
#### 18.1. ## Flip axes x/y: coord_flip() ####
############################ #
p
p + coord_flip()

############# #
#### 18.2. ## Circular graphs: coord_polar() ####
############################## #
# $$$ Exercise: Transform the following histogram into a circular graph
cir <- ggplot(wind, aes(x=DirCat, fill=SpeedCat)) +
          geom_histogram(binwidth=15) +
          scale_x_continuous(limits=c(0,360))
# $$$ ANSWER:


### See also ggplot extension: ggradar https://github.com/ricardo-bion/ggradar


############# #
#### 18.3. ## x/y axes in the same scale: coord_fixed() ####
######################################### #
sp
sp + coord_fixed()


########################################################### #
#### 19 ### TITLES AND LABS: ggtitle(), labs(), *lab() ####
########################################################### #
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) + 
  geom_point()

p + ggtitle("Plot title here", subtitle = "Subtitle here") +
    xlab("x-axis title") +
    ylab("y-axis title") +
    labs(tag="B", 
         caption="Figure 1. Here you can insert a note or figure caption.", 
         colour = "Legend title") +  
    scale_colour_discrete(name= "Legend title",
                          labels=c("Group 1", "Group 2"))
  
## Observation: In this case, the variable in the legend was specified by colour.
## You will need to specify the aes used for the legend variable (either in labs() or
## in scale_())

# $$$ Exercise: define plot title and subtitle, 
# axis titles, legend title , tag and figure caption in the following plot
# Tip: please use only one legend. Use the argument guide=FALSE in the right place to do that.
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb, size=weightLb)) +
  geom_point(shape=24)
# $$$ ANSWER:







# Another way to omit one legend
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb, fill=weightLb)) +
  geom_point(size=3, shape=24) +
  ggtitle("Plot title here", subtitle = "Subtitle here") +
  xlab("x-axis title") +
  ylab("y-axis title") +
  labs(tag="B", 
       caption="Figure 1. Here you can insert a note or figure caption.", 
       colour = "Legend title", 
       fill = "Legend title") 


########################################################################################################################################## #
#### 20 ### ANNOTATIONS: annotate(), geom_text(), geom_*line(), geom_errorbar(), geom_crossbar(), geom_linerange(), geom_pointrange() ####
########################################################################################################################################## #
# Insert text, shapes... into the graph 

############# #
#### 20.1. ## Text annotations ####
################################### #

## Individual annotations: annotate("text")
########################## #
p <- ggplot(faithful, aes(x=eruptions, y=waiting)) + geom_point()

p + annotate(geom="text", x=3, y=48, label="Group 1",
             family="serif", fontface="italic", colour="darkred", size=8) +
  annotate(geom="text", x=4.5, y=66, label="Group 2",
           family="serif", fontface="bold", colour="green", size=5)

## Annottate all data (just to remember): geom_text() or better, geom_text_repel()
###################### #
# data
countr <- subset(countries, Year==2009 & healthexp>2000)
head(countr)
str(countr)

sp <- ggplot(countr, aes(x=healthexp, y=infmortality)) 

sp + geom_point() +
  geom_text_repel(aes(label=Name))

## Annotate each facet: geom_text()
####################### #
p <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point() + facet_grid(. ~ drv)
p
# Create a dataframe with annotations
f_labels <- data.frame(drv = c("4", "f", "r"), label = c("4wd", "Front", "Rear"))
f_labels

# Annotate them with same colour
p + geom_text(data=f_labels, aes(label=label), x=4, y=40, color="red")

# Annotate them with colour depending on facet variable
p + geom_text(data=f_labels, aes(label=label, color=label), x=4, y=40)

############# #
#### 20.2. ## Mathematical annotation: annotate("text", parse=T) ####
###################################### #
# parse=TRUE: the labels will be parsed into expressions and displayed as described in ?plotmath
?plotmath
p <- ggplot(data.frame(x=c(-3,3)), aes(x=x)) + stat_function(fun = dnorm)
p
p + annotate("text", x=2, y=0.3, parse=TRUE,
             label="frac(1, sqrt(2 * pi)) * e ^ {-x^2 / 2}")

# $$$ Exercise: Annotate another expression following syntax in ?plotmath
# $$$ ANSWER:



############# #
#### 20.3. ## Lines: ####
######################### #
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) + geom_point()
p
## Horizontal and vertical lines: geom_hline(), geom_vline()
################################# #
p + geom_hline(yintercept=60) + 
    geom_vline(xintercept=14)

## Diagonal lines: geom_abline()
################## #
p + geom_abline(intercept=37.4, slope=1.75)

# $$$ Exercise: Draw a line 1:1 in the following plot
ggplot(heightweight, aes(x=heightIn, y=heightIn, colour=sex)) + geom_point()
# $$$ ANSWER:



## Lines related to data statistics
#################################### #
hw_means <- ddply(heightweight, "sex", summarise, heightIn=mean(heightIn))
hw_means

p + geom_hline(data=hw_means, 
               aes(yintercept=heightIn, colour=sex), 
               linetype="dashed", size=1)

## Segments and arrows: annotate("segment")
####################### #
p <- ggplot(subset(climate, Source=="Berkeley"), aes(x=Year, y=Anomaly10y)) +
  geom_line()
p + annotate("segment", x=1950, xend=1980, y=-.25, yend=-.25, colour="red")

p + annotate("segment", x=mean(climate$Year), xend=max(climate$Year), y=-.25, yend=-.25, colour="red")

p + annotate("segment", x=1850, xend=1820, y=-.8, yend=-0.95, 
             arrow=arrow(), colour="blue", size=2)

# $$$ Exercise: Highlight the peak in 1940 using a red arrow
# $$$ ANSWER:




############# #
#### 20.4. ## Rectangles: annotate("rect") ####
########################## #

p + annotate("rect", xmin=1950, xmax=1980, ymin=-1, ymax=1, 
             alpha=.1, fill="blue")

# $$$ Exercise: Highlight the 19th century in green
# $$$ ANSWER:



############# #
#### 20.5. ## Error bars: geom_errorbar() ####
########################## #
ce <- subset(cabbage_exp, Cultivar == "c39")
ce

## In a barplot
################ #
ggplot(ce, aes(x=Date, y=Weight)) +
  geom_bar(stat="identity") +
  geom_errorbar(aes(ymin=Weight-se, ymax=Weight+se), width=.3)

## In a line graph
################### #
ggplot(ce, aes(x=Date, y=Weight)) +
  geom_line(aes(group=1)) +
  geom_point(size=4) +
  geom_errorbar(aes(ymin=Weight-se, ymax=Weight+se), width=.2)

## Alone
######### #
# $$$ Exercise: Try the following geom_()'s alone (in the following graph, without other geoms)
# geom_crossbar(), geom_linerange(), geom_pointrange()
ggplot(ce, aes(x=Date, y=Weight))
# $$$ ANSWER:






############################### #
#### 21 ### THEME: theme() ####
############################### #
# Graph appearance not related to data

############# #
#### 21.1. ## Complete themes (predefined) ####
############################################### #
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
p

############# #
## 21.1.1. ## Basic 
###################### #
# https://ggplot2.tidyverse.org/reference/ggtheme.html

# Grey (default)
p + theme_grey()

# Black and white
p + theme_bw()

# Light
p + theme_light()

# Dark
p + theme_dark()

# Minimal
p + theme_minimal()

# Classic
p + theme_classic()

# Void
p + theme_void()

# ...

############# #
## 21.1.2. ## ggthemes: Extra Themes, Scales and Geoms for 'ggplot2'
####################### #
#https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/

# Wall Street Journal theme:
p + theme_wsj()  

# Theme with nothing other than a background color
p + theme_solid(fill = "white")

# Highcharts JS theme 
p + theme_hc()

# theme based on the Economist 
p + theme_economist() 


############# #
#### 21.2. ## Modify elements in Theme ####
########################################### #
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=sex)) + 
  geom_point()
z <- ggplot(wind, aes(x=DirCat, fill=SpeedCat)) +   geom_histogram(binwidth=15) +
  coord_polar() + scale_x_continuous(limits=c(0,360))

## Observation: in the following examples, pay attention to the use of 
## element_line(), element_text(), element_rect()...

## Graph area
############## #
p + theme(
  panel.grid.major = element_line(colour="red"),
  panel.grid.minor = element_line(colour="red", linetype="dashed", size=0.2),
  panel.background = element_rect(fill="lightblue"),
  panel.border = element_rect(colour="blue", fill=NA, size=2))

## Text
######## #
p + 
  ggtitle("Here plot title") +
  theme(
    axis.title.x = element_text(colour="blue", size=16),
    axis.text.x = element_text(colour="purple"),
    axis.title.y = element_text(colour="green", size=14, angle = 90),
    axis.text.y = element_text(colour="orange"),
    plot.title = element_text(colour="red", size=20, face="bold", family="serif"))

## Legend
########## #
z + theme(
  legend.background = element_rect(fill="grey90", colour="red", size=1),
  legend.title = element_text(colour="blue", face="bold", size=14),
  legend.text = element_text(colour="red"),
  legend.key = element_rect(colour="blue", size=0.25),
  legend.position="bottom") # right, left, top, bottom, none

## Facets
########## #
f <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point() + facet_grid(.~class) 
f
f + theme(strip.background = element_rect(fill="pink"),
          strip.text.x = element_text(size=8, angle=-10, face="bold", colour="red"))

## Delete elements: element_blank() or NA
################### #
### Using element_blank()
hwp
hwp + theme(axis.title.x=element_blank())
hwp
hwp + theme(panel.grid.minor = element_blank())
hwp
hwp + theme(panel.background = element_blank())

### Using NA
hwp
hwp + theme(axis.title.x=element_text(colour=NA))
hwp
hwp + theme(panel.grid.minor = element_line(colour=NA))
hwp
hwp + theme(panel.background = element_rect(fill=NA))

## Delete legends of specific scales: guide=FALSE
##################################### #
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb, size=weightLb)) +
  geom_point(shape=24)
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb, size=weightLb)) +
  geom_point(shape=24) +
  scale_size_continuous(guide=FALSE)

## Delete legend title of specific scales: name=NULL
########################################## #
ggplot(heightweight, aes(x=ageYear, y=heightIn, fill=weightLb)) +
  geom_point(shape=24)
ggplot(heightweight, aes(x=ageYear, y=heightIn, fill=weightLb)) +
  geom_point(shape=24) +
  scale_fill_continuous(name=NULL) 


############# #
#### 21.3. ## Tips to make life easier using Theme ####
####################################################### #

## Graphical interface for editing ggplot2 theme elements
########################################################## #
library(ggThemeAssist)
# Procedure:
# 1. Select lines of your plot
# 2. Go to Addins (upper bar) >> ggplot Theme Assistant
# 3. Define your preferences in the interface
# 4. Click Done and see your new code in your script

# $$$ Exercise: modify the theme of the following plot using the Theme Assistant
ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb, fill=weightLb)) +
  geom_point(size=3, shape=24) +
  scale_colour_continuous(name=NULL) +  
  scale_fill_continuous(guide=FALSE)
# $$$ ANSWER:



## Keep themes in objects to use them in different graphs
########################################################## #
t <- theme(plot.subtitle = element_text(vjust = 1), 
           plot.caption = element_text(vjust = 1), 
           panel.background = element_rect(linetype = "dashed"), 
           plot.background = element_rect(fill = "antiquewhite"))

p <- ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb, fill=weightLb)) +
  geom_point(size=3, shape=24) +
  scale_colour_continuous(name=NULL) +  
  scale_fill_continuous(guide=FALSE)
p
p+t

## Define your own default theme: theme_set()
################################# #
# so that it is used by default unless you specify another
theme_set(theme_bw())
p


#*******************************************************
############# #
#### BLOCK 4: SAVE FIGURES AND MORE                 ####
############# #
#*******************************************************

############################## #
#### 22 ### SAVE FIGURES  ####
############################## #
# Now it is important:
setwd("C:/.../3_DATA_VISUALIZATION")

############# #
#### 22.1. ## dev.off() ####
############################ #

### pdf 
######### #
# Observation: size in inches
# Use /2.54 to transform to cm.

pdf("linda1.pdf", width=10/2.54, height=20/2.54)

ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb)) +
  geom_point(size=3) +
  scale_colour_gradientn(colours = c("darkred", "orange", "yellow", "white"))

dev.off()

### tiff / jpg / png 
##################### #
# Observation: size in pixels
# res>=300 recommended
tiff("linda2.tiff", width=400, height=400, res=300)

ggplot(heightweight, aes(x=ageYear, y=heightIn, colour=weightLb)) +
  geom_point(size=4) +
  scale_colour_gradientn(colours = c("darkred", "orange", "yellow", "white"))

dev.off()


############# #
#### 22.2. ## ggsave() ####
########################### #
# Save the last figure runned in ggplot
# dpi>=300 recommended
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) + geom_area()
ggsave("linda3.pdf", width=8, height=8, unit="cm", dpi=300)
ggsave("linda3.tiff", width=8, height=8, unit="cm", dpi=300)
ggsave("linda3.jpg", width=8, height=8, unit="cm", dpi=300)
ggsave("linda3.png", width=8, height=8, unit="cm", dpi=300)


############# #
#### 22.3. ## save_plot() ####
########################### #
# Save a plot object
plot <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) + geom_area()
save_plot("linda5.png", plot, base_asp = 1, base_height = 10)




################################## #
#### 23 ### GGPLOT EXTENSIONS ####
################################## #
# https://exts.ggplot2.tidyverse.org/gallery/
# Examples: ggreppel, ggthemes, gganimate




#*******************************************************
############## #
#### BLOCK 5: ANIMATED GRAPHS: {gganimate}          ####
############## #
#*******************************************************

################################################ #
#### 24 ### INTRODUCTION TO ANIMATED GRAPHS ####
################################################ #

############# #
#### 24.1. ## gganimate versions ####
##################################### #

# Attention: gganimate has an old version (v.1.1., developed by David Robinson) 
# and a new one (developed by Thomas Lin Pedersen), with COMPLETELY DIFFERENT SYNTAXES.
# The old one is more simple and there is a lot of information on internet about it.
# The new one is more flexible and based on ggplot logic, but it is so new that 
# there is still few information about it.

## TUTORIALS FOR OLD VERSION
# https://www.rdocumentation.org/packages/gganimate/versions/0.1.1
# https://blog.revolutionanalytics.com/2017/05/tweenr.html
# https://www.masterdataanalysis.com/r/creating-animations-ggplot2-plots/
# https://d4tagirl.com/2017/05/how-to-plot-animated-maps-with-gganimate

## TUTORIALS FOR NEW VERSION
# https://gganimate.com/
# https://gganimate.com/articles/gganimate.html
# https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/
# https://anderfernandez.com/blog/como-crear-animaciones-en-r-con-gganimate/
# https://d4tagirl.com/2017/05/how-to-plot-animated-maps-with-gganimate
# https://www.youtube.com/watch?v=21ZWDrTukEs # between 27:27 and 43:44


############# #
#### 24.2. ## other animated graphs: ggplotly()  ####
##################################################### #
# https://www.brucemeng.ca/post/animations-in-r/   # plotly vs gganimate
# https://plot.ly/ggplot2/animations/              # intro to plotly
# https://moderndata.plot.ly/learning-from-and-improving-upon-ggplotly-conversions/   # problems of plotly

# interactive and animated graphics: Shiny




################################################### #
#### 25 ### GRAMMAR OF {gganimate} (NEW VERSION) ####
################################################### #

# The NEW VERSION extends the grammar of graphics as implemented by ggplot2 
# to include the description of animation. 
# It does this by providing a range of new grammar classes that can be 
# added to the plot object in order to customize how it should change with time.

# 1. transition_*() defines how the data should be spread out and how it relates to itself across time.
# The key to do animations is to look at data from a time perspective; and transition_*() defines how  
# data changes with time (layers can be static or animated as they can be split out or repeated across facets)
# Examples:
# animate transition between two states
# animations with a time variable
# animations between no clear states
# examples: transition_states(), transition_time(), transition_events()

# 2. view_*() defines how the positional scales should change along the animation.
# defines panning and zooming along the animation
# will modify x- and y- limits of the coordinate system

# 3. shadow_*() defines how data from other points in time should be presented in the given point in time.
# defines how data from past or future frames should be displayed 
# e.g., adding tracks or streaks

# 4. enter_*()/exit_*() defines how new data should appear and how old data should disappear during 
# the course of the animation.

# 5. ease_aes() defines how different aesthetics should be eased during transitions.
# how aesthetics should be interpolated between the values defined in the layer data


############# #
#### 25.1. ## transition_*() ####
################################# #
# Example data 1: flowers
View(iris)

# Example data 2: RLadies (https://rladies.org/)
rladies <- read_csv(url('https://raw.githubusercontent.com/d4tagirl/R-Ladies-growth-maps/master/rladies.csv')) 
View(rladies)

# Example data 3: airquality
View(airquality)

# Example data 4: Gapminder (life expectancy vs. gross domestic product)
# Observe repeated measures design:
View(gapminder)


# Static plots
flower <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length, colour=Species)) + 
  geom_point()
flower

map <- 
  ggplot(data = rladies, aes(x = lon, y = lat, size = followers)) +
  borders("world", colour = "gray85", fill = "gray80") +
  geom_point(colour = "purple", alpha = 0.5) +
  scale_size_continuous(name = "Followers",
                        breaks = c(250, 500, 750, 1000)) +
  coord_quickmap()+
  theme_map()
map

air <- ggplot(airquality, aes(Day, Temp, group = Month, color = factor(Month))) +
  geom_line() +
  scale_color_viridis_d() +
  labs(x = "Day of Month", y = "Temperature") +
  theme(legend.position = "top")
air

gm <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, size=pop, color=continent)) +
  geom_point() +
  scale_x_log10()
gm


## 1 # transition_states() ####
############################# #
# Changes between the defined states and pauses at each state
flower_states <- flower + transition_states(states = Species,      # variable for movement
                                            transition_length = 1, # relative time of transition
                                            state_length = 2)      # relative time of pause
flower_states                                           


map_states <- map +
  transition_states(states = created_at,   # variable for movement
                    transition_length = 1, # relative time of transition
                    state_length = 2)      # relative time of pause

map_states


## 2 # transition_time() ####
########################### #
# The transition length between the states is set to correspond 
# to the actual time difference between them.
# Intermediary values are calculated (thus, points move from one state to another
# It needs a continuous or date-time variable (integer, numeric, POSIXct, Date, difftime, orhms)
map_time <- map +
  transition_time(time = created_at) # variable for movement
map_time

gm_time <- gm + transition_time(year)
gm_time


## 3 # transition_reveal() ####
############################# #
# Data gradually appears, based on a given time dimension.
# In contrast to e.g. transition_time(), transition_reveal() calculates 
# intermediary values at exact positions instead of coercing raw values into the closest frame.
# (thus, points stay at their position the time necessary until the next state)
# It needs a continuous or date-time variable (integer, numeric, POSIXct, Date, difftime, orhms)
air_reveal <- air + transition_reveal(Day)
air_reveal

air_reveal <- air + 
  geom_point() +
  transition_reveal(Day)
air_reveal


## 4 #  transition_manual() ####
############################## #
# The number of frames in the animation will be decided by 
# the number of levels in the frame variable
flower_manual <- flower +
  transition_manual(Species)   # variable for movement 
flower_manual

map_manual <- map +
  transition_manual(created_at)   # variable for movement 
map_manual

## 5 #  transition_layer() ####
############################## #
## 6 #  transition_filter() ####
############################## #
## 7 #  transition_events() ####
############################## #
## 8 #  transition_components() ####
############################## #


# $$$ Exercise: visualize the evolution of the life expectancy and gdp per capita 
# of countries in gapminder, animating the points across year.
# Use transition_states()
# $$$ ANSWER:




### Add a title
#################
# Each transition_*() has specific variable to indicate labels:  
View(data.frame(Function = c("transition_components",	
                             "transition_events",	
                             "transition_filter",	
                             "transition_layer",	
                             "transition_manual",	
                             "transition_reveal",	
                             "transition_states",	
                             "transition_time"),
                Lab_variable = c("frame_time",
                                 "frame_time",
                                 "previous_filter, closest_filter, next_filter",
                                 "previous_layer, closest_layer, next_layer, nlayers",
                                 "previous_frame, current_frame, next_frame",
                                 "frame_along",
                                 "previous_state, closest_state, next_state",
                                 "frame_time")))


# $$$ Exercise: using transition_states() and the flower data, 
# indicate the Species of each state in the plot title.
# Tip: labs(title = "Flowers of the species: {closest_state}")
# $$$ ANSWER:



# $$$ Exercise*: using transition_states() and the gapminder data, 
# now indicate the year of each state in the plot title.
# Tip: labs(title = "year:{closest_state}")
# $$$ ANSWER:




# $$$ Exercise*: using transition_reveal() and the airquality data, 
# indicate the Day of each state in the plot title.
# Tip: search in help of transition_reveal() how to label Day
# $$$ ANSWER:




# $$$ Exercise*: using transition_time() and the gapminder data, 
# indicate the year of each state in the plot title.
# Tip: search in help of transition_time how to label year
# $$$ ANSWER:





############# #
#### 25.2. ## view_*() ####
######################### #
# Possibilities:
# view_follow(), view_static(), view_step(), view_zoom()
# See help 

gm_time_view <- gm_time + view_follow()
gm_time_view

gm_time_view2 <- gm_time + view_follow(fixed_y = TRUE)


# $$$ Exercise: using transition_reveal() and the airquality data, 
# adjust the zoom of the graph to the data at each time.
# Tip: view_follow()
# $$$ ANSWER:




############# #
#### 25.3. ## enter_*() and exit_*() ####
######################################### #
# To be used when data appear and disappear. 
# See ?enter_exit for options

# Example:
flower_states_title_enterexit <- 
  flower_states_title +
  enter_fade() +   # fade will simply set the alpha value to zero making the elements fade in/out during the transition.
  exit_shrink()    # shrink will set the elements to zero size making them gradually shrink out of existence. 

flower_states_title_enterexit

# Example:
gm2 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10() + 
  transition_states(continent,
                    transition_length = 1,
                    state_length = 2) +
  labs(title = "{closest_state}")
gm2
gm2_enter_exit <- gm2 +
  enter_grow() +
  exit_fade() 
gm2_enter_exit


# $$$ Exercise: Look at help and select an enter_*() and an exit_*() function
# to add to one of the graphs above.
# $$$ ANSWER:




############# #
#### 25.4. ## shadow_*() ####
############################# #
# Leave the shadow of the point behind it...

# $$$ Exercise: include shadow_wake(0.15, wrap=FALSE)
# in the gapminder example using transition_time()
# $$$ ANSWER:




# $$$ Exercise*: Now use shadow_mark() to leave a mark at point positions
# $$$ ANSWER:




############# #
#### 25.5. ## ease_aes() ####
############################# #
# ease_aes("linear") is the default
# Other possibilities:
#   ease_aes("elastic-in")
#   ease_aes("exponential-in-out")

# See all possibilities in ?ease_aes


# $$$ Exercise: explore the effect of including ease_aes()
# in the gapminder example using transition_time().
# $$$ ANSWER:





############################################## #
#### 26. ## RENDER (save) animated graphs ####
############################################## #
setwd()
# to save the last animation created in GIF (similar to ggsave())
anim_save(filename = "gapminder_animation.gif")
anim_save(filename = "airquality_animation.gif")

# we can previously modify some issues about the animation:
# Low-quality (Trial versions)
animate(air_reveal_view, 
        nframes = 50,    # Number of frames (100 by default)
        fps = 3,         # frames per second (10 by default)
        width = 500,     # Plot width
        height = 500,    # Plot height
        res = 96)        # resolution

# High-quality (Final versions)
animate(air_reveal_view, 
        nframes = 200,    # Number of frames (100 by default)
        fps = 20,         # frames per second (10 by default)
        width = 1000,     # Plot width
        height = 1000,    # Plot height
        res = 300)        # resolution



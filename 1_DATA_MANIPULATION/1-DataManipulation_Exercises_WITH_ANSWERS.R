######################################################################################################## #
######                                                                                               ### #
######                                 Curso Ciencia de datos en R                                   ### #
######              Escuela de Doctorado, Universidad de Alcalá, Mayo-Junio 2021                     ### #
######                                 Profesora Sara Villén Pérez                                   ### #
######                                                                                               ### #
######                                 1) DATA MANIPULATION IN R                                     ### #
######                              ***  EXERCISES WITH ANSWERS   ***                                ### #                                                                                         #####
######                                                                                               ### #
######################################################################################################## #

############################# #
### 0 ### EXAMPLE DATASETS ####
############################# #

### 0.1. Load, have a look and understand the variables of any dataset available in R (different from mtcars and Orange)
library(datasets)
data()
data(CO2)
View(CO2)
?CO2

#################################### #
### 1 ### DATA TYPE AND STRUCTURE ####
#################################### #

### 1.1 ### DATA TYPE
###################### #

### 1.1.1. Which are the three main data types in R? Create an example of each and conferre its class.
class(2345)      # numeric
class("Brasil!") # character
class(1>234)     # logical


### 1.2 ### DATA STRUCTURE
########################### #

### 1.2.1. Create a data object of ONE dimension, whose elements are all the SAME type
### How do you call this object?
c(23, 34, 41)  # vector

### 1.2.2. Create an EMPTY vector of length 5 whose elements are all of type character
vector(mode = "character", length = 5)

### 1.2.3. Create a vector whose elements can only take FIXED values (i.e., categorical)
### How do you call this object?
factor(c(23, 34, 41)) # factor

### 1.2.4. Create a vector whose elements can only take fixed values, and define their ORDER
### How do you call this object?
ordered(c("medium", "small", "large"), levels = c("small", "medium", "large")) # ordered factor

### 1.2.5. Create a data object of ONE dimension, whose elements are of DIFFERENT type, structure and length
### How do you call this object?
list(A=1, B=matrix(1:6,2,3), C=factor(c("a","b","c"))) # list

### 1.2.6. Create a data object of TWO dimensions, whose elements are all the SAME type
### How do you call this object?
matrix(letters[1:10],5,2) # matrix

### 1.2.7. Create a data object of TWO dimensions, whose elements are of DIFFERENT type
### How do you call this object?
data.frame(CHAR = letters[1:10],
           NUME = 1:10,
           LOGI = logical(length = 10))   # data frame

### 1.2.8. Create a data object of THREE dimensions, whose elements are all the SAME type
### How do you call this object?
array("a", c(2,3,4))  # array

### 1.2.9. Create a data object of FIVE dimensions, whose elements are all the SAME type
array("a", c(1,6,4,3,2))  

### 1.2.10. Create a data object of FOUR dimensions, whose elements are all the SAME type
### Do it simple, and predict its structure before running it.
array("a", c(1,2,3,2))
# ,,1,1
# ,,2,1
# ,,3,1
# ,,1,2
# ,,2,2
# ,,3,2

### 1.2.11. Write the name of three types of raster objects and three types of vector objects
# RasterLayer, RasterStack, RasterBrick
# SpatialPoints, SpatialLines, SpatialPolygons

### 1.2.12. Create a RasterLayer, with 2 lines and 2 columns, and values 1:4. No need of Coordinate Reference System.
### Then, plot it.
library(raster)
r <- raster(ncol = 2, nrow = 2)
values(r) <- 1:4
plot(r)

### 1.2.13. Create a RasterStack with two times your RasterLayer, and plot it.
s <- stack(r,r)
plot(s)

### 1.2.14. Create a RasterBrick with two times your RasterLayer, and plot it.
b <- brick(r,r)
plot(b)

### 1.2.15. Create a SpatialPoints with five points, and plot it.
library(sp)
sp <- SpatialPoints(coords = matrix(c(10,20,30,40,50,0,10,0,10,0),5,2))
plot(sp)


### 1.3 ### TEST DATA TYPE AND STRUCTURE
######################################### #

### 1.3.1. Guess the type AND structure of the following data and test if you are right
5
"Goiania"
1==2

is.numeric(5)
is.vector(5)
is.character("Goiania")
is.vector("Goiania")
is.logical(1==2)
is.vector(1==2)


### 1.4 ### COERCE DATA TYPE AND STRUCTURE
########################################### #

### 1.4.2. Coerce the following data as suggested
#c("friday","monday","tuesday")  # to factor
#c("friday","monday","tuesday")  # to ordered factor, where the order is as in a week
#c("friday","monday","tuesday")  # to list with 3 elements
#matrix(1,3,4)                   # to data frame
#matrix(1,3,4)                   # to array
#data.frame(a=1:3,b=4:6,c=7:9)   # to matrix

as.factor(c("friday","monday","tuesday"))            
ordered(c("friday","monday","tuesday"), levels = c("monday","tuesday","friday"))              
as.list(c("friday","monday","tuesday"))
as.data.frame(matrix(1,3,4))       
as.array(matrix(1,3,4))
as.matrix(data.frame(a=1:3,b=4:6,c=7:9))

############################# #
### 2 ### DATA EXPLORATION ####
############################# #

### 2.1. Open any database available in R and explore it:
### Have a look to it as a whole, to its first rows and to its last rows
View(CO2)
head(CO2)
tail(CO2)
### Look for attributes
attributes(CO2)
### Report its structure and type of data
str(CO2)
class(CO2)
### If there is any factor, report its levels
levels(CO2$Plant)
levels(CO2$Type)
levels(CO2$Treatment)
### Report its dimensions (number of rows and columns)
dim(CO2)
ncol(CO2)
nrow(CO2)
### Report the name of its variables and its cases
colnames(CO2)
rownames(CO2)
### Report descriptive statistics of each variable
summary(CO2)
### Explore it visually
plot(CO2$Treatment, CO2$uptake)
plot(CO2$Type, CO2$uptake)
plot(CO2$conc, CO2$uptake)
plot(CO2$Plant, CO2$uptake)
hist(CO2$uptake)
hist(CO2$conc)

### 2.2. Consider the following vector and explore it:
# v <-  c(4,3,2,4,2,1,4,2,2,3,4,3,3,2,2)
### Count the number of elements
length(v)

### Report the unique values
unique(v)

### Count the times that each value appears through the vector
table(v)

### Report which positions have duplicated values (that have appeared earlier in the vector) 
which(duplicated(v))

### Report the positions of the first time that values in "a" appear in the vector
### a <- c(4,2)
match(a,v)

### 2.3. Count the number of characteres in the following string
### "liudhksh@b!cvksj h?.douvyhu"
nchar("liudhksh@b!cvksj h?.douvyhu")


############################ #
### 3 ### DATA SUBSETTING ####
############################ #
View(CO2)

### 3.1. Select the first 7 rows of CO2 database using two alternative strategies
CO2[1:7,]
dplyr::slice(CO2,1:7)

### 3.2. Select the 2nd and 4th columns of CO2 database using two alternative strategies
CO2[,c(2,4)]
dplyr::select(CO2,c(2,4))

### 3.3. Select the "Plant" and "uptake" columns of CO2 database using two alternative strategies
CO2[,c("Plant","uptake")]
dplyr::select(CO2,Plant,uptake)

### 3.4. Select the "Plant" and "uptake" columns and lines 1 to 42
### from CO2 database
CO2[1:42,c("Plant","uptake")]

### 3.5. Select the "Plant" and "uptake" columns and lines of Type "Quebec"
### from CO2 database
CO2[CO2$Type == "Quebec",c("Plant","uptake")]

### 3.6. Select all lines except those from plant Qc1
CO2[CO2$Plant != "Qc1",]

### 3.7. Select all lines with uptake from 30 to 40, both values included, using three alternative strategies
CO2[CO2$uptake >= 30 & CO2$uptake <=40,]
dplyr::filter(CO2, uptake >= 30 & uptake <=40)
subset(CO2, CO2$uptake >= 30 & CO2$uptake <=40)


######################### #
### 4 ### DATA EDITING ####
######################### #
CO22 <- CO2

### 4.1. Rename variable "conc" in CO22 database
colnames(CO22)[4] <- "concentration"

### 4.2. Rename rownames in CO22 database, using numbers from 101 to 184
rownames(CO22) <- 101:184

### 4.3. Rename the levels of Threatment factor as "chill" and "nonchill"
levels(CO22$Treatment) <- c("chill","nonchill")

### 4.4. Create a new variable in which "uptake" is recoded to two levels: 
### "LowUptake" and "HighUptake" (< and > than 25)
CO22$uptakecat <- cut(CO22$uptake, 
                           breaks = c(-Inf,25,+Inf),
                           labels = c("LowUptake","HighUptake"))

### 4.5. Create a new variable to be the square root (sqrt()) of uptake. 
### Use two alternative ways to do it.
CO22$uptakesqrt <- sqrt(CO22$uptake)
CO22 <- mutate(CO22, uptakesqrt2 = sqrt(uptake))

### 4.6. You have lost concentration and uptake data from plant Qn2 in CO22 database,
### so introduce NAs in these cells.
CO22[CO22$Plant == "Qn2", 4:5] <- NA

### 4.7. Obtain the CO22 database excluding cases with NA. 
### You have learnt two ways to do that.
CO22[complete.cases(CO22),]
na.omit(CO22)

### 4.8. Calculate the mean of uptake in CO22
mean(CO22$uptake, na.rm = T)

### 4.9. Create a new attribute in CO22 to explain that Qn2 data was lost
attributes(CO22)
attr(CO22, "QN2 NA") <- "Data from plant Qn2 was lost"

################################ #
### 5 ### DATA REORGANIZATION ####
################################ #

### 5.1. Write CO2$uptake values in normal and reverse order
CO2$uptake
rev(CO2$uptake)

### 5.2. Reorganize the CO2 database so that variables fit in rows and 
### cases in columns
View(t(CO2))

### 5.3. Order the CO2$conc vector in descending order
sort(CO2$conc, decreasing = T)

### 5.4. Order the CO2 database by conc in descending order
    # Option 1 (order{base})
    CO2[order(CO2$conc, decreasing = T),]
    # Option 2 (arrange{dplyr})
    library(dplyr)
    arrange(CO2,desc(conc))

### 5.5. Order the CO2 database by Plant and conc inside plant, 
    # plant in alphabetical order (default) and conc in descending order
library(dplyr)
arrange(CO2,Plant,desc(conc))

### 5.6. Randomize the order of rows in CO2 database 
CO2[sample(1:nrow(CO2)),]

### 5.7. Change column order in CO2 database, to be:
### "Type","Treatment","Plant","conc","uptake"
CO2[,c("Type","Treatment","Plant","conc","uptake")]

### 5.8. Bind columns "Plant" and "uptake" from CO2 database
cbind(CO2$Plant,CO2$uptake)

### 5.9. Bind rows 1,8,15 from CO2 database
rbind(CO2[1,],CO2[8,],CO2[15,])

### 5.10. Add a new column called NAs and filled of NA,
### and then delete it 
CO2$NAs <- NA
CO2$NAs <- NULL

### 5.11. Delete Plant and Type columns from CO2 database, 
### save them separatedly, and then paste them to CO2 again in their position
data(CO2)
PlantType <- CO2[,c("Plant","Type")]
PlantType
CO2[,c("Plant","Type")] <- NULL
CO2
CO2 <- cbind(PlantType,CO2)
CO2

### 5.12. Incorporate the NewVar in New database to CO2 database,
### matching the observations by columns "Plant" and "P",
### and keep all lines in CO2
### New <- data.frame(P=unique(CO2[1:30,"Plant"]), NewVar=runif(5))
merge(x=CO2,y=New,by.x="Plant",by.y="P",all.x=T)

### 5.13. Incorporate the NewVar in New database to CO2 database,
### but keep only those lines that have complete information
### New <- data.frame(P=unique(CO2[1:30,"Plant"]), NewVar=runif(5))
merge(x=CO2,y=New,by.x="Plant",by.y="P",all=F)


################################ #
### 6 ### TIDY | RESHAPE DATA ####
################################ #
View(CO2)
library(tidyr)
### 6.1. Reorganize the CO2 database to wide format,
### in which there is one row per Plant and no information is loss
View(spread(CO2,key = "conc",value = "uptake"))

### 6.2. Reorganize the uptake variable in CO2 database
### in one column per plant
View(spread(CO2,key = "Plant",value = "uptake"))

### 6.3. Save your result in exercise 6.2 and reorganize it
### back to one column for Plant id and one for uptake values
wideCO2 <- spread(CO2,key = "Plant",value = "uptake")
gather(wideCO2,
       colnames(wideCO2)[4:15],
       key = "Plant",
       value = "uptake")

### 6.4. Combine the information of Type and Treatment into one column
CO2$TypTre <- paste(CO2$Type,CO2$Treatment)
View(CO2)
CO2.b <- unite(CO2,Type,Treatment)
View(CO2.b)

### 6.5. Separate this column again
CO2 <- separate(CO2, col=TypTre, into=c("Typ","Tre"))
View(CO2)


####################################### #
### 7 ### AGGREGATE AND ANALYZE DATA ####
####################################### #
trees

### 7.1. Calculate the sum of each variable in trees database, using three different approaches
colSums(trees)
dplyr::summarise(trees,sum(Girth),sum(Height),sum(Volume))
apply(trees,2,sum)


### 7.2. Calculate the mean of each row in trees database, using two different approaches
rowMeans(trees)
apply(trees,1,mean)

### 7.3. Calculate the minimum of each row in trees database
apply(trees,1,min)

### 7.4. Calculate the number of distinct values in the variable Height of trees database
dplyr::summarise(trees,n_distinct(Height))

### 7.5. Calculate the mean of uptake in CO2 database for each plant, using two different approaches
dplyr::summarise(group_by(CO2, Plant), mean(uptake)) 
tapply(CO2$uptake, INDEX = CO2$Plant, mean)

# LESS USED:

### 7.6. Calculate the sum of each variable in trees database,
### and retrieve the result as a list
lapply(trees,sum)

### 7.7. Save the list from the last exercise and calculate
### the square root (sqrt) of each element
treeslist <- lapply(trees,sum)
lapply(treeslist,sqrt)

### 7.8. Do the same than in 7.4. but retrieve the result as
### a vector
sapply(treeslist,sqrt)

### 7.9. Calculate the mean of all elements of the list and sublists
#list(1:2,2:3,list(4:5,list(5:6)))
rapply(list(1:2,2:3,list(4:5,list(5:6))), mean)

### 7.10. Calculate the mean of all elements of the list and sublists,
### disregarding character elements
#list(1:2,2:3,list(4:5,list(5:6)),"hello")
rapply(list(1:2,2:3,list(4:5,list(5:6)),"hello"), mean, class=c("integer"))

### 7.11. Calculate the mean of all elements of the list and sublists,
### disregarding character elements, 
### and retrieving the result as a list with the same structure than the original
#list(1:2,2:3,list(4:5,list(5:6)),"hello")
rapply(list(1:2,2:3,list(4:5,list(5:6)),"hello"), mean, class=c("integer"), how = "list")

### 7.12. Apply the funtion function(x,y,z){x^y+z} to the following vectors:
### x = c(1,1,2,2,4,4,6,6,8,8,10,10)
### y = c(2,4)
### z = 1
mapply(function(x,y,z){x^y+z},
       x = c(1,1,2,2,4,4,6,6,8,8,10,10),
       y = c(2,4),
       z = 1)


############################################## #
### 8 ### CONCATENATE OPERATIONS: PIPES %>% ####
############################################## #

### 8.1. Calculate the mean of uptake in CO2 database for each plant, using pipes.
### Compare it with exercise 7.5.
CO2 %>%
    group_by(Plant) %>%
        dplyr::summarise(mean(uptake)) 

### 8.2. In CO2 database: keep only Quebec records, eliminate records with concentration = 1000,
#### and then calculate the mean of uptake for each plant.
CO2 %>%
    filter(conc!=1000,Type=="Quebec") %>%
    group_by(Treatment,Plant) %>%
    dplyr::summarise(mean(uptake)) 

### 8.3. In CO2 database: now calculate the sum of uptake for all plants at concentrations 95, 175 and 250,
### indicating the mean values for each Type, Treatment and concentration.
CO2 %>%
    filter(conc==c(95,175,250)) %>%
    group_by(Type,Treatment,conc) %>%
    dplyr::summarise(sum(uptake)) 

### 8.4. In airquality database: first select Wind,Temp,Month&Day variables, 
### then keep only those samples taken the first 5 days of the month,
### and finally transform the database in a vertical format so that Wind and Temp
### values are in a single column 
airquality %>%                                
    dplyr::select(Wind,Temp,Month,Day) %>%
    filter(Day <=5) %>%
    gather(c(Wind,Temp),  
           key="Variable_name",         
           value = "Values") 

### 8.5. On the variable Temp from the airquality database: make the square root of it,
### then keep only two decimal positions and finally organize the values of the vector
### in ascendant order
airquality$Temp %>%                           
    sqrt() %>%
    round(2) %>%
    sort()


####################################### #
### 9 ### SPECIFIC DATA MANIPULATION ####
####################################### #

### 9.1 ### FACTORS {forcats}
############################### #

### 9.1.1 Tell which is the frequency of each state of conservation in mammals (msleep database)
fct_count(msleep$conservation)

### 9.1.2 Reorder the categories of conservation variable in msleep database
### from more to less frequent 
fct_infreq(factor(msleep$conservation))

### 9.1.3. Reorder the genus of mammals in msleep database
### based on the minimum time awake
fct_reorder(msleep$genus, msleep$awake, .fun=min)


### 9.2 ### CHARACTER STRINGS {stringr}
####################################### #
library(stringr)  # part of "tidyverse" ecosystem of packages

### 9.2.1. In the following string: 
caminante <- "Caminante no hay camino, se hace camino al andar. Antonio Machado"
# detect whether there is character "k"
str_detect(caminante, "k")   
# detect whether there is character "a" not followed by "n"
str_detect(caminante, "a(?!n)") 
# detect whether there is punctuation characters
str_detect(caminante, "[:punct:]")
# detect where are all "an" characters located
str_locate_all(caminante, "an")
# count number of "a" characters
str_count(caminante, "a")

### 9.2.2. Write the following strings: 
# Caminante no hay camino, se hace camino al andar. Antonio Machado
writeLines("Caminante no hay camino, se hace camino al andar. Antonio Machado")
# Caminante no hay camino, 
# se hace camino al andar. 
# Antonio Machado
writeLines("Caminante no hay camino, \nse hace camino al andar. \nAntonio Machado")  
# "Caminante no hay camino, se hace camino al andar." 
# Antonio Machado
writeLines("\"Caminante no hay camino, se hace camino al andar.\" \nAntonio Machado")  


### 9.3 ### DATES AND TIMES {lubridate} 
######################################## #
### 9.3.1. Write the date and time: 1970-01-01 00:01:00 UTC
as_datetime(60)
### 9.3.2. Write the date: 1971-01-01
as_date(365)
### 9.3.3. Write the time: 01:00:00 
hms::as.hms(3600)
### 9.3.4. Check the current Universal Coordinated Time (UTC)
now("UTC")
### 9.3.5. Coerce the following string to date class: "October 8th,  1985"
mdy("October 8th,  1985")
### 9.3.6. Get the minutes from the following string: "2016-04-02 07:32:10"
minute("2016-04-02 07:32:10")
### 9.3.7. Discover in which week of the year you were born
week("2018-10-08")
### 9.3.8. Round the following date-time to nearest day: "2019-03-08 10:32:45"
round_date(as_datetime("2019-03-08 10:32:45"), unit = "day")
### 9.3.9. Report the interval of time you will be inmersed in this course
interval(ymd_hms("2019-02-18 10:00:00",tz="US/Eastern"), ymd_hms("2019-02-25 14:00:00",tz="US/Eastern"))


############################################## #
### 10 ### DATA IMPORTATION AND EXPORTATION ####
############################################## #

### 10.1. Export the following dataframe in .txt and then import it with a different name
# Orange
library(readr) 
# export
write_delim(Orange,"C:/Users/Sara Villen/Desktop/orangetxt.txt", delim = "\t")
# import
orangetxt <- read.delim("C:/Users/Sara Villen/Desktop/orangetxt.txt")

### 10.2. Choose 5 objects of your global environment and export them to an .RData file,
# and then import them back with a different name
save(Orange,volcano, file = "C:/Users/Sara Villen/Desktop/OravolRData.RData")
OravolfromRData <- load("C:/Users/Sara Villen/Desktop/OravolRData.RData")

### 10.3. Save your entire workspace to an RData file
save.image(file = "C:/Users/Sara Villen/Desktop/my_workspace.RData")



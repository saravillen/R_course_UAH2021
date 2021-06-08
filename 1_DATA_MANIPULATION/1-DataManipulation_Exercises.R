######################################################################################################## #
######                                                                                               ### #
######                                 Curso Ciencia de datos en R                                   ### #
######              Escuela de Doctorado, Universidad de Alcalá, Mayo-Junio 2021                     ### #
######                                 Profesora Sara Villén Pérez                                   ### #
######                                                                                               ### #
######                                 1) DATA MANIPULATION IN R                                     ### #
######                                     ***  EXERCISES  ***                                       ### #                                                                                         #####
######                                                                                               ### #
######################################################################################################## #

############################# #
### 0 ### EXAMPLE DATASETS ####
############################# #

### 0.1. Load, have a look and understand the variables of any dataset available in R (different from mtcars and Orange)




#################################### #
### 1 ### DATA TYPE AND STRUCTURE ####
#################################### #

### 1.1 ### DATA TYPE
###################### #

### 1.1.1. Which are the three main data types in R? Create an example of each and conferre its class.



### 1.2 ### DATA STRUCTURE
########################### #

### 1.2.1. Create a data object of ONE dimension, whose elements are all the SAME type
### How do you call this object?


### 1.2.2. Create an EMPTY vector of length 5 whose elements are all of type character


### 1.2.3. Create a vector whose elements can only take FIXED values (i.e., categorical)
### How do you call this object?


### 1.2.4. Create a vector whose elements can only take fixed values, and define their ORDER
### How do you call this object?


### 1.2.5. Create a data object of ONE dimension, whose elements are of DIFFERENT type, structure and length
### How do you call this object?


### 1.2.6. Create a data object of TWO dimensions, whose elements are all the SAME type
### How do you call this object?


### 1.2.7. Create a data object of TWO dimensions, whose elements are of DIFFERENT type
### How do you call this object?


### 1.2.8. Create a data object of THREE dimensions, whose elements are all the SAME type
### How do you call this object?


### 1.2.9. Create a data object of FIVE dimensions, whose elements are all the SAME type
  

### 1.2.10. Create a data object of FOUR dimensions, whose elements are all the SAME type
### Do it simple, and predict its structure before running it.


### 1.2.11. Write the name of three types of raster objects and three types of vector objects


### 1.2.12. Create a RasterLayer, with 2 lines and 2 columns, and values 1:4. No need of Coordinate Reference System.
### Then, plot it.


### 1.2.13. Create a RasterStack with two times your RasterLayer, and plot it.


### 1.2.14. Create a RasterBrick with two times your RasterLayer, and plot it.


### 1.2.15. Create a SpatialPoints with five points, and plot it.



### 1.3 ### TEST DATA TYPE AND STRUCTURE
######################################### #

### 1.3.1. Guess the type AND structure of the following data and test if you are right
# 5
# "Goiania"
# 1==2


### 1.4 ### COERCE DATA TYPE AND STRUCTURE
########################################### #

### 1.4.2. Coerce the following data as suggested
#c("friday","monday","tuesday")  # to factor
#c("friday","monday","tuesday")  # to ordered factor, where the order is as in a week
#c("friday","monday","tuesday")  # to list with 3 elements
#matrix(1,3,4)                   # to data frame
#matrix(1,3,4)                   # to array
#data.frame(a=1:3,b=4:6,c=7:9)   # to matrix


############################# #
### 2 ### DATA EXPLORATION ####
############################# #

### 2.1. Open any database available in R and explore it:
### Have a look to it as a whole, to its first rows and to its last rows

### Look for attributes

### Report its structure and type of data

### If there is any factor, report its levels

### Report its dimensions (number of rows and columns)

### Report the name of its variables and its cases

### Report descriptive statistics of each variable

### Explore it visually


### 2.2. Consider the following vector and explore it:
# v <-  c(4,3,2,4,2,1,4,2,2,3,4,3,3,2,2)
### Count the number of elements

### Report the unique values

### Count the times that each value appears through the vector

### Report which positions have duplicated values (that have appeared earlier in the vector) 

### Report the positions of the first time that values in "a" appear in the vector
### a <- c(4,2)


### 2.3. Count the number of characteres in the following string
### "liudhksh@b!cvksj h?.douvyhu"


############################ #
### 3 ### DATA SUBSETTING ####
############################ #
View(CO2)

### 3.1. Select the first 7 rows of CO2 database using two alternative strategies


### 3.2. Select the 2nd and 4th columns of CO2 database using two alternative strategies


### 3.3. Select the "Plant" and "uptake" columns of CO2 database using two alternative strategies


### 3.4. Select the "Plant" and "uptake" columns and lines 1 to 42 from CO2 database


### 3.5. Select the "Plant" and "uptake" columns and lines of Type "Quebec" from CO2 database


### 3.6. Select all lines except those from plant Qc1


### 3.7. Select all lines with uptake from 30 to 40, both values included, using three alternative strategies



######################### #
### 4 ### DATA EDITING ####
######################### #
CO22 <- CO2

### 4.1. Rename variable "conc" in CO22 database


### 4.2. Rename rownames in CO22 database, using numbers from 101 to 184


### 4.3. Rename the levels of Threatment factor as "chill" and "nonchill"


### 4.4. Create a new variable in which "uptake" is recoded to two levels: 
### "LowUptake" and "HighUptake" (< and > than 25)


### 4.5. Create a new variable to be the square root (sqrt()) of uptake. 
### Use two alternative ways to do it.


### 4.6. You have lost concentration and uptake data from plant Qn2 in CO22 database,
### so introduce NAs in these cells.


### 4.7. Obtain the CO22 database excluding cases with NA. 
### You have learnt two ways to do that.


### 4.8. Calculate the mean of uptake in CO22


### 4.9. Create a new attribute in CO22 to explain that Qn2 data was lost


################################ #
### 5 ### DATA REORGANIZATION ####
################################ #

### 5.1. Write CO2$uptake values in normal and reverse order


### 5.2. Reorganize the CO2 database so that variables fit in rows and 
### cases in columns


### 5.3. Order the CO2$conc vector in descending order


### 5.4. Order the CO2 database by conc in descending order


### 5.5. Order the CO2 database by Plant and conc inside plant, 
### plant in alphabetical order (default) and conc in descending order


### 5.6. Randomize the order of rows in CO2 database 


### 5.7. Change column order in CO2 database, to be:
### "Type","Treatment","Plant","conc","uptake"


### 5.8. Bind columns "Plant" and "uptake" from CO2 database


### 5.9. Bind rows 1,8,15 from CO2 database


### 5.10. Add a new column called NAs and filled of NA,
### and then delete it 


### 5.11. Delete Plant and Type columns from CO2 database, 
### save them separatedly, and then paste them to CO2 again in their position


### 5.12. Incorporate the NewVar in New database to CO2 database,
### matching the observations by columns "Plant" and "P",
### and keep all lines in CO2
### New <- data.frame(P=unique(CO2[1:30,"Plant"]), NewVar=runif(5))


### 5.13. Incorporate the NewVar in New database to CO2 database,
### but keep only those lines that have complete information
### New <- data.frame(P=unique(CO2[1:30,"Plant"]), NewVar=runif(5))



################################ #
### 6 ### TIDY | RESHAPE DATA ####
################################ #
View(CO2)
library(tidyr)
### 6.1. Reorganize the CO2 database to wide format,
### in which there is one row per Plant and no information is loss


### 6.2. Reorganize the uptake variable in CO2 database
### in one column per plant


### 6.3. Save your result in exercise 6.2 and reorganize it
### back to one column for Plant id and one for uptake values


### 6.4. Combine the information of Type and Treatment into one column


### 6.5. Separate this column again



####################################### #
### 7 ### AGGREGATE AND ANALYZE DATA ####
####################################### #
trees

### 7.1. Calculate the sum of each variable in trees database, using three different approaches


### 7.2. Calculate the mean of each row in trees database, using two different approaches


### 7.3. Calculate the minimum of each row in trees database


### 7.4. Calculate the number of distinct values in the variable Height of trees database


### 7.5. Calculate the mean of uptake in CO2 database for each plant, using two different approaches


# LESS USED:

### 7.6. Calculate the sum of each variable in trees database,
### and retrieve the result as a list


### 7.7. Save the list from the last exercise and calculate
### the square root (sqrt) of each element


### 7.8. Do the same than in 7.4. but retrieve the result as
### a vector


### 7.9. Calculate the mean of all elements of the list and sublists
#list(1:2,2:3,list(4:5,list(5:6)))


### 7.10. Calculate the mean of all elements of the list and sublists,
### disregarding character elements
#list(1:2,2:3,list(4:5,list(5:6)),"hello")


### 7.11. Calculate the mean of all elements of the list and sublists,
### disregarding character elements, 
### and retrieving the result as a list with the same structure than the original
#list(1:2,2:3,list(4:5,list(5:6)),"hello")


### 7.12. Apply the funtion function(x,y,z){x^y+z} to the following vectors:
### x = c(1,1,2,2,4,4,6,6,8,8,10,10)
### y = c(2,4)
### z = 1



############################################## #
### 8 ### CONCATENATE OPERATIONS: PIPES %>% ####
############################################## #

### 8.1. Calculate the mean of uptake in CO2 database for each plant, using pipes.
### Compare it with exercise 7.5.


### 8.2. In CO2 database: keep only Quebec records, eliminate records with concentration = 1000,
#### and then calculate the mean of uptake for each plant.


### 8.3. In CO2 database: now calculate the sum of uptake for all plants at concentrations 95, 175 and 250,
### indicating the mean values for each Type, Treatment and concentration.


### 8.4. In airquality database: first select Wind,Temp,Month&Day variables, 
### then keep only those samples taken the first 5 days of the month,
### and finally transform the database in a vertical format so that Wind and Temp
### values are in a single column 
 

### 8.5. On the variable Temp from the airquality database: make the square root of it,
### then keep only two decimal positions and finally organize the values of the vector
### in ascendant order



####################################### #
### 9 ### SPECIFIC DATA MANIPULATION ####
####################################### #

### 9.1 ### FACTORS {forcats}
############################### #

### 9.1.1 Tell which is the frequency of each state of conservation in mammals (msleep database)


### 9.1.2 Reorder the categories of conservation variable in msleep database
### from more to less frequent 


### 9.1.3. Reorder the genus of mammals in msleep database
### based on the minimum time awake



### 9.2 ### CHARACTER STRINGS {stringr}
####################################### #
library(stringr)  # part of "tidyverse" ecosystem of packages

### 9.2.1. In the following string: 
caminante <- "Caminante no hay camino, se hace camino al andar. Antonio Machado"
# detect whether there is character "k"

# detect whether there is character "a" not followed by "n"
 
# detect whether there is punctuation characters

# detect where are all "an" characters located

# count number of "a" characters


### 9.2.2. Write the following strings: 
# Caminante no hay camino, se hace camino al andar. Antonio Machado

# Caminante no hay camino, 
# se hace camino al andar. 
# Antonio Machado
  
# "Caminante no hay camino, se hace camino al andar." 
# Antonio Machado
  


### 9.3 ### DATES AND TIMES {lubridate} 
######################################## #
### 9.3.1. Write the date and time: 1970-01-01 00:01:00 UTC


### 9.3.2. Write the date: 1971-01-01


### 9.3.3. Write the time: 01:00:00 


### 9.3.4. Check the current Universal Coordinated Time (UTC)


### 9.3.5. Coerce the following string to date class: "October 8th,  1985"


### 9.3.6. Get the minutes from the following string: "2016-04-02 07:32:10"


### 9.3.7. Discover in which week of the year you were born


### 9.3.8. Round the following date-time to nearest day: "2019-03-08 10:32:45"


### 9.3.9. Report the interval of time you will be inmersed in this course



############################################## #
### 10 ### DATA IMPORTATION AND EXPORTATION ####
############################################## #

### 10.1. Export the following dataframe in .txt and then import it with a different name
# Orange


### 10.2. Choose 5 objects of your global environment and export them to an .RData file,
# and then import them back with a different name


### 10.3. Save your entire workspace to an RData file




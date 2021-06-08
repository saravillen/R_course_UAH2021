######################################################################################################## #
######                                                                                               ### #
######                                 Curso Ciencia de datos en R                                   ### #
######              Escuela de Doctorado, Universidad de Alcalá, Mayo-Junio 2021                     ### #
######                                 Profesora Sara Villén Pérez                                   ### #
######                                                                                               ### #
######                        0) BASIC INTRODUCTION TO USE AND LOGIC OF R                            ### #                                                                                         #####
######                                                                                               ### #
######################################################################################################## #

## Recommended reading
# W. N. Venables, D. M. Smith and the R Core Team (2021) An Introduction to R. Notes on R: A Programming Environment for Data Analysis and Graphics. Version 4.1.0 (2021-05-18)
# Online: https://cran.r-project.org/doc/manuals/r-release/R-intro.pdf
# Zuur, A., Ieno, E. N., & Meesters, E. (2009) A Beginner's Guide to R. Springer Science & Business Media.

######################## #
### 1 ### WHAT IT IS? ####
######################## #
# R: language and software
# R Development Core Team: develops and distributes R under GNU General Public License

# RStudio: editor.
# Script, Console, Global Environment, History, Plots, Help, Code outline

#################### #
### 2 ### STRUCTURE: objects, functions, arguments, packages ####
#################### #
# OBJECTS: 
########## #
# To keep information (variables, data, functions, results)...

# Objects are named
a <- 4
a
# Objects can be manipulated using arithmetic operators 
c <- a*2
c
# Objects can be manipulated using functions
sqrt(a)

# Object examples:
v <- c(100:109)                               # numeric vector
v 
l <- c(letters[1:10])                         # character vector
l
d <- data.frame(var1=1:10,var2=4:5,var3=1:2)  # data frame 
d
m <- matrix(1:8,4,2)                          # matrix
m

# Objects have attributes

# Objects are of a specific class
class(a)
class(l)
class(d)
class(m)

# Objects can be coerced to a different class
class(l)
lf <- as.factor(l)
class(lf)

# FUNCTIONS: 
############ #
# Used to manipulate objects
# Always followed by parenthesis
sqrt(a)
plot(a,c)

# ARGUMENTS (and values):
######################### #
# Functions have arguments whose values can be modified. 
# Example: "x", "y" and "cex" are arguments, 
# and "a", "c" and "4" their values:
plot(x=a, y=c, cex=4)

# For most common or compulsory arguments, 
# it is not needed to specify the argument if we put the 
# values in the correct order:
plot(a, c, cex=4)

# Functions can have default arguments
# Example: for plot(), the default is cex=1:
plot(a,c)
plot(x=a, y=c, cex=1)
plot(x=a, y=c, cex=4)

# Some functions do not need to define arguments
# (may not have arguments to define or 
# have a default for all of them)
getwd()

### PACKAGES
############# #
# Functions are organized/compiled in packages (or libraries)
# Packages are stored in your hard disc
# The R "base" package is installed together with R, and
# includes basic functions to read and manipulate data

# To use a function from a package (another from Rbase) it is necessary to:
# 1- Install the package (only once)
install.packages("ggplot2")
# 2- Load the package (every time we open R)
library(ggplot2)

# To know which packages are installed
installed.packages()

# To know whether a specific package is installed
!is.element('vegan', installed.packages()[,1])

################### #
### 3 ### SYNTAX ####
################### #
# In R there are different ways to say the same thing!
# See R Syntax Comparison Cheat sheet

# Main syntax options:
# Dollar sign syntax
mean(mtcars$mpg)
# Formula syntax
library("mosaic")    
mean(~mpg, data=mtcars)
# Tidyverse syntax (pipes)
library("dplyr")
mtcars %>% summarize(mean(mpg))


################# #
### 4 ### HELP ####
################# #
## 4.1. ## Internet forums - Stack Overflow. Google it!

## 4.2. ## help() and ?
# documentation pages for R functions, data sets, and other objects
?hist            
help(hist)
help("hist")
# Equivalent shortcut: mark the word and press F1

help("==")                 # For functions or operators with special characters, only help()  
help(rlm, package="MASS")  # For functions in packages installed but not loaded
help(package="MASS")       # For whole packages

## 4.3. ## help.search() and ??
# any help pages, vignettes, code demos with these characters
??"glm"
??"ggplot"

## 4.4. ## vignette()
# document to explain and illustrate some functions of a package
vignette()                   # list of vignettes of all installed packages
vignette(package="ggplot2")  # list of vignettes of a specific package
vignette("extending-ggplot2", package = "ggplot2")  # a specific vignette

## 4.5. ## demo()
# code demonstrations
demo()                                             # all demos for packages in your library
demo(package = .packages(all.available = TRUE))    # demos in all available packages

demo("error.catching", package = "base")           # call a specific one 

## 4.6. ## Cheat Sheets
# https://www.rstudio.com/resources/cheatsheets/



############################## #
### 5 ### WORKING DIRECTORY ####
############################## #
# Get current working directory
getwd()

# Set working directory 
    # Option 1:
    # (attention! bars in this direction / or double \\)
    setwd("C:/Users/Sara Villén-Pérez/Desktop")
    setwd("C:\\Users\\Sara Villén-Pérez\\Desktop")
    # Option 2:
    # Choose folder using shortcut: Ctrl+Shift+H
    setwd("...")
    
############################# #
### 6 ### DATA IMPORTATION ####
############################# #
library(readxl)

# Option 1: with code
example_data <- read_excel("example_data.xlsx")
# view imported database
View(example_data)

# Option 2: from Environment > Import Dataset
    
  
############################# #
### 7 ### WORKING PROJECTS ####
############################# #  
# https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects

# Each with their own working directory, workspace, history, and documents
# Each one opened in a new RStudio session

### CREATE a new project:  
# File > New Project    or    Projects toolbar > New Project  
# choose a new or existing directory

# When a new project is created RStudio:
# 1- Creates a project file (.Rproj) within the project directory. The project can be opened directly from this file.
# 2- Creates a hidden directory (.Rproj.user) to store temporary files. 
# 3- Loads the project into RStudio and display its name in the Projects toolbar

### OPEN an existing project in a new RStudio session:     
# File > Open Project in New Session    or    Projects toolbar > Open Project in New Session
# Open the new project from file

### CHANGE project
# File > Open Project    or    Projects toolbar > Open Project     (closes the previous project)
# Projects toolbar > select from project list

### When we CLOSE a Project:
# .RData and/or .Rhistory are written to the project directory
# The list of open source documents is saved (so it can be restored next time the project is opened)
# The R session is terminated.

### When we OPEN a Project:
# R Workspace (global environment) is restored from .RData file

############################ #
### 8 ### TIDY WORK SPACE ####
############################ #
# Delete an object from global environment
rm(a)
    
# Clear all objects from workspace
rm(list=ls())

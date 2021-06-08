######################################################################################################## #
######                                                                                               ### #
######                                 Curso Ciencia de datos en R                                   ### #
######              Escuela de Doctorado, Universidad de Alcalá, Mayo-Junio 2021                     ### #
######                                 Profesora Sara Villén Pérez                                   ### #
######                                                                                               ### #
######                                  1) DATA MANIPULATION IN R                                    ### #                                                                                         #####
######                                                                                               ### #
######################################################################################################## #

# Recommended reading:
# Wickham, H., & Grolemund, G. (2016). R for data science: import, tidy, transform, visualize, and model data. " O'Reilly Media, Inc.".
#   Online: https://r4ds.had.co.nz/index.html
# Teetor, P. (2019). R cookbook: Proven recipes for data analysis, statistics, and graphics. " O'Reilly Media, Inc.".2nd edition
#   Online: https://rc2e.com/
# CHEAT SHEETS: base-r, readr, dplyr, pdlyr/tidyr, forcats, lubridate, stringr, tibble (vignette)
# https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts

############################# #
### 0 ### EXAMPLE DATASETS ####
############################# #
# We will use example data available in R base (R Built-in Data Sets)
# (R comes with several built-in data sets, which are generally used as demo data for playing with R functions)
# There are specific packages that are compilations of datasets, but most packages include some datasets to support examples

### From R Datasets package
    # (base package, so it needs loading but not installation)
    library(datasets)
    # To see a list of all datasets in Datasets
    data()
    # To load and view a dataset
    data(mtcars)
    View(mtcars)
    # Actually, it is not needed to load it in order to see it
    View(Orange)
    # To learn more about a dataset
    ?mtcars

### List of all datasets available in all loaded packages (the package needs to be loaded)
data(package = .packages(all.available = TRUE))


#################################### #
### 1 ### DATA TYPE AND STRUCTURE ####
#################################### #

### 1.1 # DATA TYPE ####
######################## #

### 1. Numeric (integer/double)
1
class(1) 
1:4
class(1:4)

    # Numeric includes integer and double subtypes (double is usually identified as numeric)
    # It is not important to distinguish them
    # R automatically changes to these types when needed
      # Integer: stored as a single number (max ~2 billion)
      # Double: stored as "double precision floating point numbers", i.e., in two pieces
                # e.g., 1.79e+308 has two pieces: the exponend (308) and the significand (1.79)
                # It uses more space than integer
                # It can reach larger numbers
                # Used for most operations, more common than integer
                

### 2. Character
"Hello"
class("Hello")


### 3. Logical
1==2
class(1==2)
2<3
class(2<3)


### 4. Others. e.g., date-time


### 1.2 # DATA STRUCTURE ####
############################# #
# A classification by dimensionality and heterogeneity of data type 
View(data.frame(row.names = c("1-dimension", "2-dimensions", "n-dimensions"),
           Homogeneous = c("Atomic Vector", "Matrix", "Array"),
           Heterogeneous = c("List", "Data Frame", NA)))

### 1. ATOMIC VECTOR (1-dimension, elements of same type) 
?vector 

vector(mode = "numeric", length = 4)  # zeroed numeric vector   
a <- c(-1, 4.2, 8)                    # numeric vector
b <- c("two","one","three")           # character vector
c <- c(TRUE,TRUE,FALSE)               # logical vector

str(a) # let's see the structure of a vector

        # 1.1. FACTOR   (vector with categorical data, i.e., fixed levels) 
        ?factor
        af <- factor(a)
        bf <- factor(b)
        cf <- factor(c)
        af2 <- as.factor(c(-1,4.2,8))
         
        # 1.2. ORDINAL FACTOR (ordered levels) 
        ordered(b)                                   # alphabetical ordered
        ordered(b, levels = c("one","two","three"))  # to specify the order

### 2. MATRIX    (2-dimensions, all columns of same length and type) 
?matrix
matrix(1:80, ncol = 8, nrow = 10) # numeric matrix
matrix(1:2, nrow = 10, ncol = 8)  # recicles 1:2 to fulfill the matrix
matrix(1:3, nrow = 10, ncol = 8)  # recicles 1:3 to fulfill the matrix, warning because 1:3 is not a multiple of 80
matrix(1:4, nrow = 2, ncol = 2, 
       dimnames = list(c("line1", "line2"), c("col1","col2")))  # names of rows and columns
matrix(c("a","b","c","d","e","f"), nrow = 2, ncol = 3)          # character matrix
matrix(c("a","b","c",4,5,6), nrow = 2, ncol = 3)                # character matrix (coerces 4,5,6 to character)
str(matrix(1:80, nrow = 10, ncol = 8))  # let's see the structure of a matrix
View(matrix(1:80, nrow = 10, ncol = 8)) # and view it apart

### 3. ARRAY     (n-dimensions, all columns of same length and type) 
?array
array(1:30, dim=c(2,5,3))      # array of 3 dimensions 
                               # dim=c(lines, columns, 3rd dimension)
str(array(1:30, c(2,5,3)))
array("a", c(2,2,2,3))     # array of 4 dimensions
array(c("a",2), c(2,2,2,3))# the "2" is coerced to character

### 4. DATAFRAME (2-dimensional, all columns of same length but NOT necessarily same type) 
?data.frame
data.frame(data.frame(tree=1, branch=letters[1:5], leaf=logical(length = 5)))
str(data.frame(data.frame(tree=1, branch=letters[1:5], leaf=logical(length = 5))))
View(data.frame(data.frame(tree=1, branch=letters[1:5], leaf=logical(length = 5))))

       # 4.1. TIBBLE (enhanced dataframe) 
       library(tibble)
       ?tibble::tibble
       tibble(x = 1:3, y = c("a", "b", "c"))     # construction by columns
       tribble(~x, ~y, 1,"a",2,"b",3,"c")        # construction by rows
       tribble(~x, ~y, ~z, "1","a","2","b","3","c")    # construction by rows
       
       str(tibble(x = 1:3, y = c("a", "b", "c")))
       View(tibble(x = 1:3, y = c("a", "b", "c")))
       
         # WHY TIBBLE? Tibble() does much less than data.frame(), MAKING LIFE EASIER: 
           # it never changes the type of the inputs (e.g. it never converts strings to factors!)
           # data.frame() recently moved to do the same, so this is not a problem anymore.
           tibble(x = 1:3, y = c("a", "b", "c"))    
           data.frame(x = 1:3, y = c("a", "b", "c"))
           str(tibble(x = 1:3, y = c("a", "b", "c")))
           str(data.frame(x = 1:3, y = c("a", "b", "c")))
           
           # it allows working with list-columns
           tibble(x = 1:3, y = list(1:5, 1:10, 1:20))
           str(tibble(x = 1:3, y = list(1:5, 1:10, 1:20)))
           data.frame(x = 1:3, y = list(1:5, 1:10, 1:20))
           
           # it never changes the names of variables 
           data.frame(`Hello world!` = 1)
           tibble(`Hello world!` = 1)
           
           # it only recycles inputs of length 1 
           #(recycling vectors of greater lengths is a frequent source of bugs)
           tibble(a = 1:4, b = 1:4)     # no need for recycling
           data.frame(a = 1:4, b = 1:4)
           tibble(a = 1:4, b = 8)       # value 8 (length 1) is recycled
           data.frame(a = 1:4, b = 8)
           tibble(a = 1:4, b = 1:2)     # vector 1:2 (length 2) CANNOT be recycled
           data.frame(a = 1:4, b = 1:2) # vector 1:2 (length 2) CAN be recycled
           
           # it never creates row.names(): all variables are consistently stored in columns
           tibble(row.names=c("one","two","three"),x=1:3,y=c("a","b","c"))
           data.frame(row.names=c("one","two","three"),x=1:3,y=c("a","b","c"))
           tibble(x=1:3,y=c("a","b","c"))
           data.frame(x=1:3,y=c("a","b","c"))
           
           # print abbreviated and more informative (structure, column type)
           tibble(x = 1:100,y=101:200)          # 10 columns by default 
           data.frame(x = 1:100,y=101:200)  
           

### 5. LIST  (collection of objects with different structures) 
?list
L <- list(a_string = "hello_world!",
         a_numeric_vector = 1:10,
         a_matrix = matrix(1:16,c(2,8)),
         a_number = 3.2,
         a_logical_vector = c(T,F,F,T),
         an_array = array(1:32,c(2,8,2)))
str(L)

L3 <- list(L,L,L)  # a list of lists
str(L3)

L33 <- list(L3,L3,L3)
str(L33)

### 6. SPATIAL DATA
# http://rspatial.org/spatial/
# Raster and Vector data: https://en.wikipedia.org/wiki/GIS_file_formats

    # 6.1. RASTER 
    library(raster)
    # 1) RasterLayer: single-layer raster data (one variable)
    ?raster
    r <- raster(ncol=10,  # number of columns 
                nrow=10,  # number of rows
                xmn=-20,  # extent (x min)
                xmx=20,   # extent (x max)
                ymn=20,   # extent (y min)
                ymx=60,   # extent (y max)
                crs = CRS('+proj=longlat +datum=WGS84'))  # Coordinate Reference System (CRS)
    values(r) <- runif(ncell(r)) # assign values to r with uniform distribution as an example (any value has the same probability)
    r     
    class(r)
    plot(r)
    
    r2 <- r*r       # it is possible to operate on values in a raster, as if it were a matrix
    r3  <- sqrt(r)
    
    # 2) RasterStack: a "list" of RasterLayers with same extent and resolution (multiple variables)
    s <- stack(r, r2, r3)  # rasterStack with three layers
    s
    class(s)
    plot(s)
    
    # 3) RasterBrick: a multi-layer raster data in a single file (multiple variables)
    # More efficient processing than RasterStack
    b <- brick(s)
    b
    class(b)
    plot(b)

    # 6.2. VECTOR 
    library(sp)
    # 1) SpatialPoints
            longitude <- c(-116.7, -120.4, -116.7) # just generating data
            latitude <- c(45.3, 42.6, 38.9)
            lonlat <- cbind(longitude, latitude)
            lonlat
    spp <- SpatialPoints(lonlat)  # without reference system
    spp
    spp <- SpatialPoints(lonlat,                                           # Coordinates of points
                         proj4string = CRS('+proj=longlat +datum=WGS84'))  # Coordinate Reference System (CRS)
    spp                                                                    
    plot(spp)
    
    # 2) SpatialPointsDataFrame
            df <- data.frame(ID=1:nrow(lonlat), precip=runif(nrow(lonlat), min=0, max=100)) # just generating data
            df  
    sppdf <- SpatialPointsDataFrame(spp,df)
    sppdf
    plot(sppdf)

    # 3) SpatialLines        ...a bit more complex... next time.
    # 4) SpatialPolygons     ...a bit more complex... next time.
    
    
    # Spatial manipulation in R is moving from package {sp} to new package {sf}...
    # sf: simple feature objects
    library(sf)
    library(ggspatial)
    load_longlake_data() # Example data
    longlake_buildingsdf # Points
    longlake_waterdf     # Polygons
    longlake_roadsdf     # Lines

    
### 1.3 # TEST DATA TYPE AND STRUCTURE ####
########################################### #

### DATA TYPE
is.numeric(1)     # numeric double
is.double(1)
is.integer(1)

is.numeric(1:2)   # numeric integer
is.double(1:2)
is.integer(1:2)

is.character("a") # character
is.character(a)

is.logical(2<3)   # logical
is.logical(2)

### DATA STRUCTURE
is.vector(1)
is.factor(factor(c("a","b")))
is.matrix(matrix(1:80, 10, 8))
is.array(array(1:80, c(10,8,2)))
is.data.frame(data.frame(var1=1:10, var2=11:20))
is.list(list(a,b))
library(tibble)
is_tibble(tibble(x=1:3,y=c("a","b","c")))

### 1.4 # COERCE DATA TYPE AND STRUCTURE ####
############################################# #
# Coerce: change data type or structure

# integer to numeric (or double)
class(1:2)                
as.numeric(1:2)
class(as.numeric(1:2))
as.double(1:2)
class(as.double(1:2))

# numeric to integer
class(1)
as.integer(1)
class(as.integer(1))

# continuous to categorical vector (i.e., factor)
str(1:2)
factor(1:2)
class(factor(1:2))

# continuous to categorical ordered vector (i.e., ordered factor)
str(1:2)
ordered(1:2)
class(ordered(1:2))

# matrix to data.frame
matrix(1:80, 10, 8)
as.data.frame(matrix(1:80, 10, 8))
class(as.data.frame(matrix(1:80, 10, 8)))

# data.frame to matrix 
as.matrix(as.data.frame(matrix(1:80, 10, 8)))
class(as.matrix(as.data.frame(matrix(1:80, 10, 8))))

# dataframe to tibble
library(tibble)
as_tibble(as.data.frame(matrix(1:80, 10, 8)))

# matrix to tibble
library(tibble)
as_tibble(matrix(1:80, 10, 8))

# tibble to dataframe
as.data.frame(tibble(x=1:3,y=c("a","b","c")))

# tibble to matrix
as.matrix(tibble(x=1:3,y=c("a","b","c")))

# matrix to array
as.array(matrix(1:80, 10, 8))
class(array(matrix(1:80, 10, 8)))
str(as.array(matrix(1:80, 10, 8)))

# anything to list
as.list(1)
class(list(1))


############################# #
### 2 ### DATA EXPLORATION ####
############################# #

### Data exploration
  # See
View(trees)         # see database in new window

head(trees)         # see first lines of dataframe in the console
head(trees,3)       # " (specify number of lines)
tail(trees)         # see last lines of dataframe in the console
tail(trees,2)       # " (specify number of lines)

  # Dimensions
nrow(trees)         # number of rows
ncol(trees)         # number of columns
dim(trees)          # dataframe dimensions (rows, columns)
length(trees)       # number of columns of a dataframe
length(trees$Girth) # number of elements of a vector
nchar("hello")      # number of characters of a character string

  # Names
colnames(trees)     # names of columns
rownames(trees)     # names of rows
names(trees)
names(list(uno=1,dos=2,tres=3))

  # Class, Structure
class(trees)        # class of an object
str(trees)          # structure of the object

  # Summary statistics
summary(trees)      # min, mean, max, median, quartiles
table(trees$Height) # Counts of values

  # Unique and duplicated values
unique(Orange$Tree)            # Unique values
duplicated(Orange$Tree)        # logical vector for duplicated values
which(duplicated(Orange$Tree)) # position of duplicated values

  # Attributes
attributes(trees)   # Does the data have any attributes?

  # Factors
levels(Orange$Tree) # Levels of factors

### Visual exploration
hist(trees$Girth)
hist(trees$Height)
hist(trees$Volume)
plot(trees$Girth, trees$Height)

### MATCH a value in a vector (by its position)
head(trees)
match(x=8.8, trees$Girth, nomatch = 0)      # gives the position of the matched value
match(x=40, trees$Girth, nomatch = 0)       # or zero if there is no match
match(x=40, trees$Girth, nomatch = 99999)   # note that nomatch can be any value

############################ #
### 3 ### DATA SUBSETTING ####
############################ #

### By position (row and column number) ####
Orange[1,]
Orange[-1,]
Orange[,1]
Orange[1,1]
Orange[,1:2]
Orange[,-(1:2)]
Orange[1:3,1:2]
Orange[c(1:3,5,8:10),]
L
L[[3]] # for lists (see list l created above)
L[[3]][,1:4]

  # Option 2 (slice{dplyr}): select rows by position
  dplyr::slice(Orange,1:3)

### By column name ####
Orange[,"Tree"]
Orange$Tree
Orange[,"age"]
Orange$age

  # Option 2 (select{dplyr}): select columns by name
  dplyr::select(Orange, Tree)
  dplyr::select(Orange, Tree, age)

  # Option 3 (subset{base})
  subset(Orange, select = Tree:circumference)
  subset(Orange, select = c(Tree, circumference))
  

### By column name and row position ####
Orange$Tree[1:5]
Orange$Tree[c(1:5,10:15)]
Orange[1:5,"Tree"]
Orange[1:5,"age"]
Orange[1:5,c("Tree","age")]
mtcars["Mazda RX4",]


### By value (conditions with boolean operators) ####
#See ?Comparison and figure pg 47 in "R for Data Science (2016) Hadley Wickham & Garrett Grolemund"
Orange[Orange$Tree == 1,]     # equal 
Orange[Orange$Tree != 1,]     # not equal 
Orange[Orange$age == 664,]    # equal 
Orange[Orange$age != 664,]    # not equal 
Orange[Orange$age > 1000,]    # higher
Orange[Orange$age >= 1000,]   # equal or higher
Orange[Orange$age <= 1000,]   # equal or smaller
Orange[Orange$Tree == 1 | Orange$Tree == 3,]     # OR
Orange[Orange$Tree == 1 & Orange$Tree == 3,]     # AND   (&& is used in "if" statements)
Orange[Orange$Tree == 1 & Orange$age == 664,]    # AND


  # Option 2 (filter{dplyr}): select rows by value
  dplyr::filter(Orange, Tree==1)
  dplyr::filter(Orange, Tree==1 & Tree==3)
  dplyr::filter(Orange, Tree==1 | Tree==3)
  
  # Option 3 (subset{base})
  subset(Orange, Orange$Tree == 1)


######################### #
### 4 ### DATA EDITING ####
######################### #
Orange2 <- Orange # new database in order not to edit the original one
  View(Orange2)

### RENAME columns and rows ####
colnames(Orange2) <- c("banana","acerola","mamao")   # all columns
  View(Orange2)
newnames <- c("ban","ace","mam")            # all columns, using a vector
colnames(Orange2) <- newnames
  View(Orange2)
colnames(Orange2)[1] <- "Amazonas"                        # selected columns
  View(Orange2)
rownames(Orange2)[1:3] <- c("Oi","Hola","Hello")     # selected rows
  View(Orange2)

### RECODE the levels of a categorical variable ####
  # (edit the original variable)
  Orange3 <- Orange
  levels(Orange3$Tree)
  View(Orange3)
        
        # Option 1
        levels(Orange3$Tree) <- c("A","B","C","D","E")
        levels(Orange3$Tree)[2] <- "BBB"
        
        # Option 2 (recode{dplyr})
        library(dplyr)
        Orange3 <- Orange
        Orange3$Tree <- recode(Orange3$Tree,"1"="A","2"="B","3"="C","4"="D","5"="E")

  # (in a new variable)
  Orange3 <- Orange
  Orange3$Tree
        
        # Option 1
        Orange3$newcode[Orange3$Tree == 1] <- "A"
        Orange3$newcode[Orange3$Tree == 2] <- "B"
        Orange3$newcode[Orange3$Tree == 3] <- "C"
        Orange3$newcode[Orange3$Tree == 4] <- "D" 
        Orange3$newcode[Orange3$Tree == 5] <- "E"
        head(Orange3)
        Orange3$newcode  # NOT ordered in the same way than in the original variable!
        
        # Option 2 (recode{dplyr})
        library(dplyr)
        Orange3$newcode2 <- recode(Orange3$Tree, "1"="A","2"="B","3"="C","4"="D","5"="E")
        head(Orange3)
        Orange3$newcode2 # ordered in the same way than in the original variable!
        
        
### RECODE a continuous variable into categorical ####
#   (numeric to factor) (create a new variable)
  Orange3$age
        
        # Option 1  
        Orange3$agecat[Orange3$age < 500] <- "young"
        Orange3$agecat[Orange3$age >= 500] <- "old"
        Orange3$agecat <- factor(Orange3$agecat)
        
        # Option 2  (cut{Rbase})    # returns a factor
        Orange3$agecat2 <- cut(Orange3$age, 
                                breaks = 2,                 # how many intervals (of equal length)
                                labels = c("Young","Old"))  # labels of new factor levels
        Orange3$agecat3 <- cut(Orange3$age, 
                                breaks = c(-Inf,400,600,Inf),   # breakpoints of intervals
                                labels = c("Young","Medium" ,"Old"))  # labels of new factor levels

  
### CALCULATE new variables operating on old ones ####
Orange4 <- Orange
View(Orange4)

        # Option 1
        Orange4$newvar <- Orange4$circumference / Orange4$age  
        Orange4$newvar2 <- Orange4$circumference * Orange4$age  
        Orange4$newvar3 <- Orange4$circumference + Orange4$age  
        Orange4$newvar4 <- Orange4$circumference - Orange4$age  
        Orange4$newvar5 <- Orange4$circumference^2
        
        # Option 2 (mutate{dplyr})
        Orange4 <- mutate(Orange4, newvar6 = circumference*age/2)
  
### Manage NAs ####
# NA: Not Available (missing values)
# NaN: Not a Number (impossible values, e.g. result of dividing by zero)
View(airquality)
  
  # Identify NAs
  is.na(airquality)  # logical matrix
  
  # Edit NAs
  airquality2 <- airquality
  airquality2[is.na(airquality2)] <- 99999
  
  # Identify complete cases (rows without NAs)
  complete.cases(airquality) # logical vector
  airquality[complete.cases(airquality),]
  
  # Identify non-complete cases (rows with NAs)
  !complete.cases(airquality) # logical vector
  airquality[!complete.cases(airquality),] 
  
  # Eliminate non-complete cases (rows with NAs)
  na.omit(airquality)
  
  # Exclude NAs from analyses
  mean(airquality$Ozone)               # without removing NAs
  mean(airquality$Ozone, na.rm = TRUE) # Removing NAs

### ATTRIBUTES: to store metadata ####
b <- 4
attributes(b)
attr(b, "new_attribute") <- "here I store metadata"
attributes(b)
attr(b, "new_attribute2") <- "here also"
attributes(b)
attr(Orange4$newvar, "a") <- "a"
attributes(Orange4$newvar)
str(Orange) # Exemplo


################################ #
### 5 ### DATA REORGANIZATION ####
################################ #
# See also "dplyr" and "sjmisc" packages for other sintaxes and functions

### REVERSE a vector / dataframe ####
1:10
rev(1:10) 

View(mtcars)
View(rev(mtcars))  # In a dataframe: reverses column order, not line order
mtcars$mpg
rev(mtcars$mpg)    # In a vector: reverses value order

### TRANSPOSE a matrix or a dataframe ####
View(mtcars)  
View(t(mtcars))               

### SORT a vector ####
Orange$age
sort(Orange$age) # default: increasing
sort(Orange$age, decreasing = TRUE)

### REORDER the levels of a factor based on a second continuous variable ####
Orange$Tree
reorder(Orange$Tree, Orange$circumference)
reorder(Orange$Tree, -Orange$circumference)

library(ggplot2) # just to get data
View(msleep)
str(msleep)
levels(factor(msleep$order))
msleepreord <- reorder(factor(msleep$order), msleep$sleep_total)  # order mammal Orders by total sleeping time
levels(msleepreord)
msleepreordcontr <- reorder(factor(msleep$order), -msleep$sleep_total) # order mammal Orders by inverse of total sleeping time
levels(msleepreordcontr)

### ORDER a dataframe ####
  # Option 1 (order{base})       # order() alone returns the order of rows
  Orange[order(Orange$age),]                                               # one variable
  Orange[order(Orange$age, Orange$circumference),]                         # two variables
  Orange[order(Orange$age, decreasing = TRUE),]                            # decreasing 
  Orange[order(Orange$age, Orange$circumference, decreasing = c(F,T)),]    # two variables, one in descending order and the other ascending

  # Option 2 (arrange{dplyr}) 
  library(dplyr)
  arrange(Orange,age)                      # one variable
  arrange(Orange,age,circumference)        # two variables
  arrange(Orange,desc(age))                # descending order
  arrange(Orange,desc(age),circumference)  # two variables, one in descending order and the other ascending
  arrange(Orange)                          # all variables, ascending, priority from left to right

### RANDOMIZE the order of a vector or dataframe ####
# set.seed(245)
1:10
sample(1:10)            # randomize order of vector elements (without replacement by default)
sample(1:10, replace=T) # randomize order of vector elements (with replacement)

Orange[,]
Orange[sample(1:nrow(Orange)),]             # randomize order of rows
Orange[sample(1:nrow(Orange), replace=T),]  # randomize order of rows (with replacement)
Orange[,sample(1:ncol(Orange))]             # randomize order of columns
Orange[,sample(1:ncol(Orange), replace=T)]  # randomize order of columns (with replacement)

### ORDER the columns of a dataframe ####
head(Orange)
Orange[,c("circumference","Tree","age")]
Orange[,c("Tree","circumference","age")]

### GROUP a tibble by the levels of a factor ####
library(dplyr)
mpg 
mpg_grouped <- group_by(mpg, cyl)  # group_by() creates a grouped tibble.
mpg_grouped                        # A grouped tibble seems almost the same than a tibble (but see # Groups) 
                                   #   but all operations will be made by group!
                                   # The combination group_by() + summarise() is the most frequent
mpg_ungrouped <- ungroup(mpg_grouped) #   a grouped tibble can be un-grouped using ungroup()
mpg_ungrouped

### BIND columns/ rows ####
cbind(Orange$Tree, Orange2$mam)   # Need to have same number of rows
rbind(Orange[3,], Orange[8,])     # Need to have same column name

### DELETE rows/columns ####
Orange4 <- Orange[-35,] # rows
Orange4 <- Orange[,-2]  # columns
Orange4$Tree <- NULL    # columns

### MERGE two dataframes ####
# (equivalent to Excel "vlookup"): merge{base}
    # Just preparing example data
    area <- as.data.frame(cbind(state.abb,state.area))
    region <- as.data.frame(cbind(state.abb,state.region))
    region <- region[order(region$state.region, decreasing = T),]
    View(area)
    View(region)

# When the common columns have the same name                         
merge(x = area,          # dataframe 1
      y = region,        # dataframe 2
      by = "state.abb",  # name of common columns (by default it will look for columns with common names)
      all = T)           # Possibilities:
                            # all = T  to keep all rows from the 2 dataframes
                            # all = F  to keep only the rows that match the two dataframes (default)
                            # all.x = T to keep all rows in x, and only those of y that match
                            # all.y = T to keep all rows in y, and only those of x that match

# When the common columns do not have the same name 
colnames(area)[1] <- "abb"
merge(x = area,          # dataframe 1
      y = region,        # dataframe 2
      by.x = "abb",         # name of common column in the x database
      by.y = "state.abb",   # name of common column in the y database
      all = T)           

################################ #
### 6 ### TIDY | RESHAPE DATA ####
################################ #
library(tidyr)
# Same functions for two different objectives:
# 1) Tidy data
# 2) Reshape data between wide and long formats

# Characteristics of tidy data:
# 1. One variable per column
# 2. One observation per row 
# 3. One value per cell   

# Characteristics of data in:
# Wide format: one observation per line, one variable per column  -- tidy data
# Long format: three columns: id, variable names, value           -- data for ggplot

# Functions of {tidyr} package:
# gather(): Wide to long format or tidy to get 1 variable per column & 1 observation per row
# spread(): Long to wide format or tidy to get 1 variable per column & 1 observation per row
# separate(),unite(): No change of format / tidy to get 1 value per cell

                  ### ALTERNATIVE FUNCTIONS AND PACKAGES:
                  # gather/spread from tidyr package: no problem - THE ONE WE WILL LEARN. # tidyverse family of packages
                  # melt()/dcast() from reshape2 package: a bit confusing, sometimes not desired results
                  # stack()/unstack() from utils: it needs postprocessing of results (colnames, etc)
                  # reshape() function from Stats package: confusing and not preferred option today
                  # unpivot()/pivot() from spreadsheets package
                  # fold()/unfold() from databases package

### GATHER(): Wide to long format / tidy to get 1 variable per column & 1 observation per row ####
    # exampe for objective: wide to long format
    View(airquality) # tidy data, day and month are the ID variables; ozone,solar.r,wind,temp are those we want to compile
    airlong <- gather(airquality,                  # dataframe
                      c(Solar.R,Ozone,Wind,Temp),  # columns to be compiled (we leave out the IDs)
                      key="Variable_name",         # name of variable with old-columns names
                      value = "Values")            # name of variable with values
    View(airlong)
    
    # exampe for objective: tidy data to get 1 variable per column & 1 observation per row
    Cerrado <- data.frame(state=c("MS","GO","MG"),year1=c(34,45,87),year2=c(13,32,75)) # species richness in 3 states and 2 years
    View(Cerrado) # state is the ID, in columns we have species richness per year (not tidy data because the two variables "species richness" and "year" are not identified in columns)
    Celong <- gather(Cerrado,
                     c(year1,year2),
                     key="year",
                     value="species")
    View(Celong)

### SPREAD(): Long to wide format / tidy to get 1 variable per column & 1 observation per row ####
    # example for both objectives
    View(airlong)
    airwide <- spread(airlong,
                      key = "Variable_name",  # where are variable names?
                      value = "Values")       # where are values of those?
    View(airwide)
        
### UNITE() two columns into one ####
    Cerryear <- data.frame(state=c("MS","GO","MG"),century=c(19,19,19),year=c(72,67,81))
    region <- as.data.frame(cbind(state.abb,state.region))
    # Option 1 (unite{tidyr})
    Cerryear # example 1
    Cerryearunite <- unite(Cerryear,         # dataframe
                      col = "completeyear",  # new column name
                      c(century,year),       # columns to unify
                      sep = "")              # separation between values (_ by default)
    Cerryearunite
    
    region   # example 2
    region2 <-  unite(region,               
                     col = "state_region",
                     c(state.abb,state.region))
    region2
    
    # Option 2 (paste{base})
    Cerryear$completeyear <- paste(Cerryear$century, # first column
                                   Cerryear$year,    # second column
                                   sep = "")         # separation between values
    Cerryear
    
### SEPARATE a vector into multiple columns (useful to split characters) ####
    region2
    separate(region2,                     # database
             col = state_region,          # column to separate
             into = c("Stat","Reg"))      # new column names
                                          # It automatically interprets the space or the _ as separation point
    
    separate(region2,                      # 
             col = state_region,          # 
             into = c("Stat","Reg"),      # 
             sep = "_")                   # separation point identified by a character string (which is omitted)
    
    separate(region2,                      # 
             col = state_region,          # 
             into = c("Stat","Reg"),      # 
             sep = 1)                     # separation point defined by positions from left (positive number) 
  
    separate(region2,                      # 
             col = state_region,          # 
             into = c("Stat","Reg"),      # 
             sep = -1)                    # separation point defined by positions from right (negative number) 

    
 
####################################### #
### 7 ### AGGREGATE AND ANALYZE DATA ####
####################################### #

### 7.1. ROW & COLUMN MEAN / SUM {base} ####
############################################ #
airquality
# Means
rowMeans(airquality)
rowMeans(airquality, na.rm = T)
colMeans(airquality)
colMeans(airquality, na.rm = T)
# Sums
rowSums(airquality)
rowSums(airquality, na.rm = T)
colSums(airquality)    
colSums(airquality, na.rm = T)    


### 7.2. SUMMARISE {dplyr} ####
############################# #
library(dplyr)
### 7.2.1. summarise() with standard functions ####
mpg
dplyr::summarise(mpg, max(cyl))
dplyr::summarise(mpg,
                 max_cyl = max(cyl), 
                 avg_cty = mean(cty), 
                 min_year = min(year))

# Some functions you can use inside summarize:
  # Arithmetic: prod() , sum()
  # Centrality: mean() , median()
  # Dispersion: sd() , var() 
  # Range: max() , min() , quantile()
  # Position: first() , last() , nth()
  # Logical: any() , all()
  # Count: n() , n_distinct() (functions to be used only inside summarize())

### 7.2.2. summarise() with personalized functions ####
# You can use your own functions:
my_function = function(x){x^2}
dplyr::summarise(mpg,
                 cyl_2= my_function(cyl))

### 7.2.3. summarise() by group ####
# group_by() + summarise()
dplyr::summarise(group_by(mpg, cyl),
                 max_cyl = max(cyl), 
                 avg_cty = mean(cty), 
                 min_year = min(year))


### 7.3. APPLY FAMILY {base}: apply(), lapply() , sapply(), vapply(), tapply(), rapply(), mapply() ####
######################
    
# Apply a function in a repetitive way across dataframes, matrices, arrays or lists
# Conceived to avoid loops (for, etc.) when unnecessary 
# Each specific apply function is conceived for a specific input data structure (though it can usually be applied to others) 
#     and returns an output with a specific data structure
# Example functions to be applied: mean, sum, median, min, max, range, quantile, ..., 
#    and any user-defined function using this notation: function(x){x^2}
  
### 7.3.1. apply(): applies the function over rows or columns and returns a vector ####
    # Input: matrix or array (also dataframe)
    # Output: vector
        # MATRIX
        trees
        apply(X = trees,
              MARGIN = 1,  # 1 applies the function over matrix ROWS
              FUN = mean) 
        apply(X = trees,
              MARGIN = 2,  # 2 applies the function over matrix COLUMNS
              FUN = mean)
        # ARRAY
        array(1, c(4,3,2))
        apply(X = array(1, c(4,3,2)),
              MARGIN = 1,  # 1 applies the function over the array ROWS (first number is all first rows in all matrices)
              FUN = sum)
        apply(X = array(1, c(4,3,2)),
              MARGIN = 2,  # 2 applies the function over the array COLUMNS
              FUN = sum)
        apply(X = array(1, c(4,3,2)),
              MARGIN = 3,  # 3 applies the function over the array MATRICES
              FUN = sum)

        
### 7.3.2. tapply(): applies a function over a vector grouped by the levels of a second vector ####
    # Input: vector
    # Output: vector
    Orange
    tapply(X = Orange$circumference,  # vector over which the function is applied
           INDEX = Orange$Tree,       # grouping factor (same length than X)
           FUN = mean)
        
### LESS USED:
    
### 7.3.3. lapply(): list apply: applies the function over each element of the list and returns a list ####
    # Input: list (also dataframe, vector, ...)
    # Output: list
    list(A=1:4, B=matrix(1:4,4,2), C=2)
    lapply(X = list(A=1:4, B=matrix(1:4,4,2), C=2), 
           FUN = sum) 
    lapply(X = list(GIRTH=trees$Girth, HEIGHT=trees$Height),  
           FUN = sum)
    lapply(X = list(GIRTH=trees$Girth, HEIGHT=trees$Height),  
           FUN = quantile)
    
### 7.3.4. sapply(): simple apply: is like lapply() but returns a simpler object (not a list) if possible (when length of results from each element are the same) ####
    # Input: list (also dataframe, vector, ...)
    # Output: a vector or a matrix 
    sapply(X = list(A=1:4, B=matrix(1:4,4,2), C=2), 
           FUN = sum)
    sapply(X = list(GIRTH=trees$Girth, HEIGHT=trees$Height),  # output: vector
           FUN = sum)
    sapply(X = list(GIRTH=trees$Girth, HEIGHT=trees$Height),  # output: matrix
           FUN = quantile)

### 7.3.5. vapply(): is like sapply() but the output structure is specified ("safer" to detect errors than sapply()) ####
    # Input: list (also dataframe, vector, ...)
    # Output: specified
    vapply(X = list(GIRTH=trees$Girth, HEIGHT=trees$Height),  
           FUN = mean,
           FUN.VALUE = 2)                                     # required output: vector of 2
    vapply(X = list(GIRTH=trees$Girth, HEIGHT=trees$Height),  
           FUN = range,
           FUN.VALUE = c(2,2))                                # required output: matrix of 2 by 2
    vapply(X = list(GIRTH=trees$Girth, HEIGHT=trees$Height),  
           FUN = range,
           FUN.VALUE = 2)                                     # it gives an error if the output is not the required (nice!) 

### 7.3.6. rapply(): recursive apply (apply a function to all elements of a list recursively, i.e., to lists and sublists) ####
    # Input: list or list with sublists; target data type can be specified
    # Output: vector or specified
    
    # Input: simple list, specifying target data type
    list(1,2,3,4,"a")
    rapply(list(1,2,3,4,"a"),      
           function(x){x^2},      
           class=c("numeric"))     # element type to which the function should be applied (it ignores the "a")

    # Input: simple list, multiple target data type
    list(1,2,3,4,"a")
    rapply(list(1,2,3,4,"a"),      
           function(x){x},       
           class="ANY")                         # element type = any (note that all elements of output vector are transformed to character)
    rapply(list(1,2,3,4,"a"),      
           function(x){x},       
           class=c("numeric", "character"))     # element type = numeric or character
    
    # Input: list with sublists; Output: vector
    list(A=1,B=list(B1=2,B2=list(B21=3, B22="a")))          
    str(list(A=1,B=list(B1=2,B2=list(B21=3, B22="a"))))
    rapply(list(A=1,B=list(B1=2,B2=list(B21=3, B22="a"))),  
           function(x){x^2},       
           class=c("numeric"))  

    # Input: list with sublists; Output: list (it will keep the input structure)
    rapply(list(A=1,B=list(B1=2,B2=list(B21=3, B22="a"))),  # list over which the function is applied
           function(x){x^2},       # function
           class=c("numeric"),     # element type to which the function should be applied
           how = "list")           # to preserve the original structure
    
    # Input: list with sublists; Output: list (elements not included in class will remain)
    rapply(list(A=1,B=list(B1=2,B2=list(B21=3, B22="a"))),  # list over which the function is applied
           function(x){x^2},       # function
           class=c("numeric"),     # element type to which the function should be applied
           how = "replace")        # to preserve the original structure

### 7.3.7. mapply(): multivariate apply: applies a multivariate function to elements through vectors or lists ####
                  # (applies the function to the first elements of all vectors, then to the second element, etc)
    # Input: vectors or lists
    # Output: list (or vector/array whenever possible, unless SIMPLIFY=F)
    
    mapply(rep,  # function that requires two arguments (example: which element is repeated, times it is repeated)
           1:4,  # vector of elements for first argument:  1, 2, 3, 4
           4:1)  # vector of elements for second argument: 4, 3, 2, 1
    
    # This is equivalent to:
    list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
    
    # Arguments are recycled if necessary:
    mapply(rep,  
           2,    # always same element for first argument 
           4:1)  # vector of elements for second argument: 4, 3, 2, 1
    
    # SIMPLIFY=T by default, so if possible results will be presented as a vector, matrix or array
    mapply(rep,  
           1:4,    
           2)    # always repeated 2 times, so that elements can be organized in a matrix
    mapply(rep,  
           2,    
           4:1)    # here it cannot simplify the output

    
############################################## #
### 8 ### CONCATENATE OPERATIONS: PIPES %>% ####
############################################## #
# Pipes are implemented in two packages of the tidyverse family:
library(magrittr) # the original one
library(dplyr)    # highly used for managing data
# Recommended writing style: https://style.tidyverse.org/pipes.html
# Further lecture: https://r4ds.had.co.nz/pipes.html

## OPTIONS TO CONCATENATE OPERATIONS:    
# Example: we aim to 1) filter, 2) select, 3) arrange
    
# Option 1. Using parenthesis.
arrange(dplyr::select(filter(Orange, Tree==1),age,circumference),age)

# Option 2. Using intermediate objects
temp1 <- filter(Orange, Tree==1)
temp2 <- dplyr::select(temp1,age,circumference)
final <- arrange(temp2,age)

# Option 3. Overwrite original object
Orange4 <- Orange
Orange4 <- filter(Orange4, Tree==1)
Orange4 <- dplyr::select(Orange4,age,circumference)
Orange4 <- arrange(Orange4,age)

# Option 4. Using pipes %>%
Orange %>% 
  filter(Tree==1) %>%
  dplyr::select(age,circumference) %>%
  arrange(age)

## REASONS TO USE PIPES:
# 1) Increased readability: 
#    - structure of data operations from left to right, as apposed to from inside and out
#    - reduce text (exclude unimportant words)
# 2) Increased flexibility:
#    - simplicity to include a new intermediate step in operations
# 3) Avoid problems: 
#    - errors associated with complex nested code (parenthesis)
#    - memory problems associated with saving intermediate objects
#    - debugging cost associated with overwriting objects

# WHEN NOT TO USE PIPES:
# 1) For some specific functions:
#     - that use the current environment. E.g., assign(), get(), load()
#     - that use lazy evaluation.  E.g., tryCatch(), try(), suppressMessages(), and suppressWarnings()
# 2) Short operations (1 step)
#     It is simpler not to use pipes.
# 3) Large operations (> 10 steps). 
#     It is recommended to generate intermediate objects to facilitate debugging.
# 4) Multiple inputs or outputs; complex structure of dependencies in operations
#     When various objects are combined together, pipes make the code more difficult to understand.
#     Thus, use pipes only when the logic of operations is linear.

# NOMENCLATURE:  
# Pipe: %>%
# Pipeline: chain of processing actions (e.g., Orange %>% filter(Tree==1) %>% arrange(age))


# ASSIGN THE RESULT
# Using the assignment operator (<-)
NewOrange <- Orange %>% 
  filter(Tree==1) 

# OVERWRITE THE ORIGINAL DATABASE
# Option 1. Using the assignment operator (<-)  
Orange4 <- Orange
Orange4 <- Orange4 %>% 
  filter(Tree==1) 
# Option 2. Using the compound assignment pipe operator (%<>%) 
# (not highly recommended because the overwriting is not so obvious at a glance).
Orange4 <- Orange
Orange4 %<>% 
  filter(age==118) 

# Keyboard Shortcut for %>%: Ctrl+Shift+M 


######################################## #
### 9 ### SPECIFIC DATA MANIPULATION ####
######################################## #

### 9.1 # FACTORS {forcats} ####
############################## #
# Factor: categorical variable with an small, fixed and known number of categories
library(forcats) # part of "tidyverse" ecosystem of packages

# Functions we already know:
factor()  # to create a factor
levels()  # to read or define the levels of a factor
ordered() # to create an ordered factor
reorder() # to reorder the levels of a factor based on a second continuous variable


### FREQUENCY of the levels of a factor
fct_count(CO2$Treatment)
fct_count(Orange$Tree)
fct_count(factor(msleep$order))

### REORDER the levels of a factor manually
CO2$Treatment
fct_relevel(CO2$Treatment, "chilled","nonchilled")

### REORDER the levels of a factor based on their frequency 
factor(msleep$order)
fct_infreq(factor(msleep$order))

### REORDER the levels of a factor based on a second continuous variable
CO2$Type
fct_reorder(CO2$Type, CO2$uptake, .fun=min)  # similar to reorder() but can use other functions


### 9.2 # CHARACTER STRINGS {stringr} ####
######################################## #
# character strings: sequences of characters surrounded by quotation marks
library(stringr)  # part of "tidyverse" ecosystem of packages

### DETECT the existence of characters
fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "a")       # presence of "a" character
str_detect(fruit, ".")       # presence of any character
str_detect(fruit, "p{2}")    # presence of double p ("pp")
str_detect(fruit, "p{1,3}")  # between 1 and 3 p ("p", "pp", "ppp")
str_detect(fruit, "^a")      # "a" at start of string
str_detect(fruit, "a$")      # "a" at end of string
str_detect(fruit, "[eiou]")  # any of "e", "i", "o", "u"
str_detect(fruit, "[b-d]")   # any of "b", "c", "d"
str_detect(fruit, "[p|l]")   # any/both of "p" or "l"
str_detect(fruit, "[^apple]")# anything apart from "apple"
str_detect(fruit, "n(?=a)")  # "n" followed by "a"
str_detect(fruit, "p(?!e)")  # "p" NOT followed by "e"
str_detect(fruit, "(?<=a)n") # "n" preceded by "a"
str_detect(fruit, "(?<!a)n") # "n" NOT preceded by "a"

fruit2 <- c("Apple", "BANA\nNA", "p34 r", "pinapple.")
str_detect(fruit2, "[:alpha:]") # letters
str_detect(fruit2, "[:punct:]") # punctuation
str_detect(fruit2, "[:lower:]") # lowercase letters
str_detect(fruit2, "[:upper:]") # uppercase letters
str_detect(fruit2, "[:alnum:]") # letters and/or numbers
str_detect(fruit2, "[:space:]") # space, tab or new line
str_detect(fruit2, "[:blank:]") # space or tab

### POSITION of characters
fruit <- c("apple", "banana", "pear", "pinapple")
str_which(fruit, "a")       # position of "a" character (the first time it appears)
str_locate(fruit, "na")     # position "na" string (first time it appears, start and end positions of string) 
str_locate_all(fruit, "na") # position "na" string (all times it appears, start and end positions of string) 
str_locate_all(fruit, "a")  # position "a" string (all times it appears, start and end positions of string) 

### COUNT of characters
str_count(fruit, "a")       # count "a" character 

# *** see stringr CHEAT SHEET:

### SUBSET strings

### manage LENGTHS of strings

### MUTATE strings

### JOIN and SPLIT strings

### ORDER strings

### WRITE in strings (\ as scape)
writeLines("apple")
writeLines("app\nple")  # \n for new line
writeLines("app\tple")  # \t for tab
writeLines("app\\ple")  # \\ for \
writeLines("app\"ple")  # \" for "



### 9.3 # DATES AND TIMES {lubridate} ####
######################################## #
# see lubridate cheat sheet
library(lubridate)

### three object types:
# 1. DATE-TIME: a point on the timeline, stored as the number of seconds since 1970-01-01 00:00:00 UTC (UTC: coordinated universal time)
as_datetime(1305482400) 

as_datetime(1)
class(as_datetime(1))    # POSIXct and POSIXlt classes allow for dates and times with control for time zones

# 2. DATE: a day, stored as the number of days since 1970-01-01
as_date(15109)
as_date(1)
class(as_date(1))

# 3. HMS: a time, stored as the number of seconds since 00:00:00
hms::as_hms(85)
hms::as_hms(1)
class(hms::as_hms(1))

### TIMEZONES. Every date-time has a time zone assigned. Default is Universal Coordinated Time (UTC) 
    # List of time zones (TZ)(around 600 TZ): https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    OlsonNames()

    # To see the time in a different time zone:
    with_tz(as_datetime("2011-05-15 18:11:22"),tzone = "America/Santiago")  # Santiago is UTC-4
    
    # To re-define the time zone:
    utc <- as_datetime("2011-05-15 18:11:22")
    utc
    sa <- force_tz(utc,tzone = "America/Santiago")
    sa

### NOW and TODAY
now()                   # by default, time zone of your computer
now("UTC")              # Universal Coordinated Time (UTC) 
now("Africa/Accra")     # specifying a time zone
now("America/Bogota")
now("America/Bahia")
today()
today("Asia/Tokyo")
today("Pacific/Samoa")

### COERCE string to date-time
    # Functions for varying data completeness:
    ymd_hms("2011-05-15 18:11:22")
    ymd_hm("2011-05-15 18:11")     
    ymd_h("2011-05-15 18")
    ymd("2011-05-15")
    hms::hms(22,11,18) # sec, min, h

    # Functions for different string structures:
    ymd("2018-12-03") # year-month-day
    ydm("2018-03-12") # year-day-month
    mdy("12-03-2018") # month-day-year
    dmy("03-12-2018") # day-month-year
    date_decimal(2019.133) # year with decimals
    
    # These functions respond to different string formats:
    ymd("2018-12-03")
    ymd("2018-12-3")
    ymd("2018/12/03")
    ymd("20181203")
    ymd("2018Dec03")
    ymd("2018 Dec 03")
    dmy("3 December 2018")
    dmy("3rd of December 2018")    
    dmy("3rd of December '18")
    mdy("December 3rd,  2018")
   
### SUBSET date-time elements (useful to get and edit elements)
    date("2018-12-03 12:11:22")
    year("2018-12-03 12:11:22")
    month("2018-12-03 12:11:22")
    day("2018-12-03 12:11:22")
    hour("2018-12-03 12:11:22")
    minute("2018-12-03 12:11:22")
    second("2018-12-03 12:11:22")

### GET intrinsic information from date-time        
    wday("2018-12-03 12:11:22")      # week day, considering that sunday=1
    week("2018-12-03 12:11:22")      # week of the year
    quarter("2018-12-03 12:11:22")   # quarter of the year (4 in total)
    semester("2018-12-03 12:11:22")  # semester of the year (2 in total)
    am("2018-12-03 12:11:22")        # is a.m.?
    pm("2018-12-03 12:11:22")        # is p.m.?
    dst("2018-12-03 12:11:22")       # id Daylight Savings Time? (horario de verao / horario de verano)
    leap_year(as_date("2018-12-03")) # is it a leap year? (ano bissexto / anio bisiesto) 

### ROUND date-times
    # Round to nearest
    round_date(as_datetime("2018-12-03 12:11:22"), unit = "seconds")
    round_date(as_datetime("2018-12-03 12:11:22"), unit = "minutes")
    round_date(as_datetime("2018-12-03 12:11:22"), unit = "hours")
    round_date(as_datetime("2018-12-03 12:11:22"), unit = "day")
    round_date(as_datetime("2018-12-03 12:11:22"), unit = "month")
    round_date(as_datetime("2018-12-03 12:11:22"), unit = "year")
    # Round DOWN to nearest
    floor_date(as_datetime("2018-12-03 12:11:22"), unit = "year")
    # Round UP to nearest
    ceiling_date(as_datetime("2018-12-03 12:11:22"), unit = "hour")

### CALCULUS with date-times
    # Intrinsic difficulties: timeline irregularities (leap years, leap seconds, start/end of daylight savings)
    # three classes of timespan
           # 1. Periods: changes in clock time (ignore irregularities)
                # seconds, minutes, hours, days, months, years
                as_date("2018-12-03")+days(3)
                as_date("2020-02-28")+days(1)
                ymd_hms("2018-03-11 01:30:00",tz="US/Eastern")            # start of daylight savings (at 2a.m. becomes 3a.m., there is a time gap)
                ymd_hms("2018-03-11 01:30:00",tz="US/Eastern")+hours(2)   # it ignores the gap 
                
           # 2. Duration: changes in physical time (deviates to avoid irregularities)
                # dseconds, dminutes, dhours, ddays, dmonths, dyears
                as_date("2018-12-03")+ddays(3)  # If there is no irregularity, there is no difference with periods
                ymd_hms("2018-03-11 01:30:00",tz="US/Eastern")+dhours(2)  # it does not ignore the gap
                
           # 3. Intervals: bounded by start and end points (it is supposed to ignore irregularities)
                interval(as_date("2018-12-03"), as_date("2018-12-03")+ddays(3))
                interval(ymd_hms("2018-03-11 01:30:00",tz="US/Eastern"), ymd_hms("2018-03-11 01:30:00",tz="US/Eastern")+dhours(2))  # it is supposed to ignore the gap. EST - Eastern Standard Time, EDT - Eastern Daylight Time 

    # There are multiple functions for calculus (see lubridate cheat sheet)

                
############################################# #
### 10 ### DATA IMPORTATION AND EXPORTATION ####
############################################# #                

### 10.1 # DATA IMPORTATION ####
############################### #
# define working directory
setwd("C:/~/2_DATA_MANIPULATION/import_data_examples")

### A. IMPORT FROM EXTERNAL FILE
    ### 1. PREPARING DATA
        # Databases can be prepared in excel
        # Best Practices:
          # ROW / COLUMN NAMES
            # First row: column names
            # First column: row names
          # NAMING CONVENTIONS          
            # Avoid names with blank spaces. "hello_world" or "hello.world" instead of "hello world".
            # Avoid names with special symbols: ? $ * + # ) ( , - / } { | > <. 
            # Only _ and . can be used.
            # Avoid beginning variable names with a number. "dist_100m" or "x100m" better than "100m".
            # Column names must be unique. Duplicated names are not allowed.
            # R is case sensitive. "Name" is different from "name" or "NAME".
            # Avoid blank rows in your data.
            # Delete any comments in your file.
            # Replace missing values by NA.
            # If you have a column containing date, use the four digit format for year: "01/01/2016" instead of "01/01/16".
          # Save it better as .txt or .csv (can also be .xls | .xlsx)
                      
    ### 2.(Option1) IMPORT MANUALLY FROM ENVIRONMENT TAB
        # Import Dataset
        # From CSV / Excel
        # Browse and select delimiters
        # [I recommend] Copy the code into your script before "Import"
            # From .csv
            library(readr)
            example <- read_delim("example.csv", 
                                  ";", escape_double = FALSE, trim_ws = TRUE)
            View(example)
            
            # From .txt (via "From CSV")
            library(readr)
            example <- read_delim("example.txt", 
                                  "\t", escape_double = FALSE, trim_ws = TRUE)
            View(example)
            
            # From .xlsx
            library(readxl)
            example <- read_excel("example.xlsx")
            View(example)
                    
    ### 2.(Option2) IMPORT WITH CODE
        # run your code, specific for each file type and delimiter
            # From .csv
            library(readr) # tidyverse family of packages
            read_table("example.csv")                       # if you need to check what is the delimiter
            csv <- read_delim("example.csv", delim = ";")   # specify that the delimiter is ;
            csv # is a tibble, because readr belongs to tidyverse
            View(csv)     
            
            # From .txt
            library(readr) # tidyverse family of packages
            read_table("example.txt")                       # if you need to see what is the delimiter (\t is tab)
            txt <- read_delim("example.txt", delim = "\t")  # specify that the delimiter is \t (\t means tab; .txt is tab delimited text)
            txt 
            View(txt)
            
            # From .xls or .xlsx
            library(readxl)
            xlsx <- read_excel("example.xlsx")
            xlsx
            View(xlsx)
    
        # specify details:
            # My original file does not have column names
            csv2 <- read_delim("example.csv", delim = ";",
                               col_names = F)  
            csv2 
            View(csv2)
            
            # specify column names
            csv3 <- read_delim("example.csv", delim = ";",
                               col_names = c("hello","world","happy","day"))  
            csv3 
            View(csv3)
            
            # other details (subsetting, variable type... that I think is simpler to do afterwards)
            
        # databases can be read from internet
            read_delim("http://www.sthda.com/upload/boxplot_format.txt", delim = "\t")
        
### B. IMPORT FROM R FILE
    # From RDS (single-object file)
      OrangefromRDS <- readRDS("OrangeRDS.rds")
      View(OrangefromRDS)
    
    # From RData (multiple-object file)
      OravolfromRData <- load("OravolRData.RData")
      OravolfromRData
      View(Orange)
      View(volcano)
    
    # Workspace from RData
      load("my_workspace.RData")

### 10.2 # DATA EXPORTATION ####
############################### #

### A. IMPORT FROM EXTERNAL FILE
    ### 1. PREPARE DATA
    export <- csv
    
    ### 2. EXPORT WITH CODE (better to csv or txt and then open and save in excel if necessary)     
        # To .csv
        library(readr) # tidyverse family of packages
        write_delim(Orange,                 # R dataframe
                    "orange_example.csv", # file name
                    delim = ";")            # text delimiter in new file 
    
        # To .txt
        library(readr) # tidyverse family of packages
        write_delim(export,"exporttxt.txt", delim = "\t")
        
### B. EXPORT TO R FILE
    # Save a single database to RDS (single-object file)  
    data(Orange)
    View(Orange)
    saveRDS(Orange, file = "OrangeRDS.rds")
    
    # Save multiple databases to RData (multiple-object file)
    data(Orange)
    data(volcano)
    View(Orange)
    View(volcano)
    save(Orange,volcano, file = "OravolRData.RData")
    
    # Save entire workspace to RData
    save.image()                            # save to file with no name (.RData)
    save.image(file = "my_workspace.RData") # give name




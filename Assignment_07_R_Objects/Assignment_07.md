Assignment_07
================
Megan Xiao

2025-10-10

## Choose or Download Data

In this section, I will load an existing data set, analyze its first few
rows, and describe its structure. I will use a well-known data
set,“iris,” for this demonstration. To obtain the “iris” dataset, I will
load the “datasets” library.<br>

``` r
library(datasets)
```

To view the first six rows, I use the head() function:<br>

``` r
head(iris)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1          5.1         3.5          1.4         0.2  setosa
    ## 2          4.9         3.0          1.4         0.2  setosa
    ## 3          4.7         3.2          1.3         0.2  setosa
    ## 4          4.6         3.1          1.5         0.2  setosa
    ## 5          5.0         3.6          1.4         0.2  setosa
    ## 6          5.4         3.9          1.7         0.4  setosa

The rows are not ordered based on any specific columns; however, they
doseem to be grouped based on species, as seen by the rows only being of
the species “setosa.”<br> To view the data type of each column and
thenumber of rows (observations) and columns (variables), we use the
str() function:<br>

``` r
str(iris)
```

    ## 'data.frame':    150 obs. of  5 variables:
    ##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
    ##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
    ##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
    ##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
    ##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

The DataFrame contains 150 rows and 5 columns. The first four columns
(sepal length, sepal width, petal length, and petal width) contain
numerical decimals. <br> The last column, species, is a “Factor” data
type with three levels; otherwise known as categorical columns. Although
we can see the first two values, “setosa” and “versicolor,” we cannot
see the third value. We can find the unique values in column by using
the unique() function:<br>

``` r
unique(iris$Species)
```

    ## [1] setosa     versicolor virginica 
    ## Levels: setosa versicolor virginica

Now, we can clearly see the three levels of the Species column: setosa,
versicolor, and virginica.<br>

## Test Generic Functions

Generic functions are those which are derived from base R. These include
functions such as print(), summary(), and plot(). For this section, I
will use the functions mean(), range(), and summary().<br>

### Mean

The mean() function calculates the average for a vector of numbers. It
possesses three main parameters: x, trim, and na.rm.<br> Let’s pretend
we want the mean of all the columns in iris. We might try passing the
entire iris DataFrame into mean():<br>

``` r
tryCatch(mean(iris), error = function(e) e)
```

    ## Warning in mean.default(iris): argument is not numeric or logical: returning NA

    ## [1] NA

This does not work because iris itself is not a numeric or logical. It
is of the class “data.frame.” To get the average of all numeric columns
using the mean() function, we need to use the sapply() function, which
applies the function to all possible corresponding elements of a vector
or expression object.<br>

``` r
sapply(iris, mean)
```

    ## Warning in mean.default(X[[i]], ...): argument is not numeric or logical:
    ## returning NA

    ## Sepal.Length  Sepal.Width Petal.Length  Petal.Width      Species 
    ##     5.843333     3.057333     3.758000     1.199333           NA

We get the mean of each numeric column. However, for the column
Species,we get a warning and an NA value because it is a categorical
column. To ensure we only get numeric columns, we can extract only the
numeric columns as a new DataFrame and perform the mean on it.<br>

``` r
iris.nums <- iris[sapply(iris, is.numeric)]
sapply(iris.nums, mean)
```

    ## Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
    ##     5.843333     3.057333     3.758000     1.199333

### Range

The range() function returns the minimum and maximum of a vector. Like
the mean() function, it only works for numerical values. If we try to
pass the iris DataFrame into range() directly, we get an error because
we have a categorical column.<br>

``` r
tryCatch(range(iris), error = function(e) e)
```

    ## <simpleError in FUN(X[[i]], ...): only defined on a data frame with all numeric-alike variables>

If we want to find the minimum and maximum numbers for each numerical
column, we will need to use the apply() function because it allows us to
apply functions based on row or column using the MARGIN parameter. With
the iris.nums DataFrame we created in the previous step, we can find the
minimum and maximum of only the numeric column:<br>

``` r
apply(iris, MARGIN = 2, FUN = range)
```

    ##      Sepal.Length Sepal.Width Petal.Length Petal.Width Species    
    ## [1,] "4.3"        "2.0"       "1.0"        "0.1"       "setosa"   
    ## [2,] "7.9"        "4.4"       "6.9"        "2.5"       "virginica"

The first row represents the minimum of each column and the second row
represents the maximum. MARGIN = 2 indicates we want to apply the
function based on column.<br>

### Summary

The summary() function produces result summaries of various objects. For
numeric columns, it produces a five-number summary and the mean. For
factor columns, it produces the counts for each level and the number of
NA values. For characters, the length, class, and mode of the column.
For logicals, the counts of TRUE, FALSE, and NA values. Because of its
versatility, we can pass the entire DataFrame without manipulating or
changing it:<br>

``` r
summary(iris)
```

    ##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width   
    ##  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
    ##  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
    ##  Median :5.800   Median :3.000   Median :4.350   Median :1.300  
    ##  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
    ##  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
    ##  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
    ##        Species  
    ##  setosa    :50  
    ##  versicolor:50  
    ##  virginica :50  
    ##                 
    ##                 
    ## 

Since the first four columns are numeric, we receive a
five-numbersummary and the means. Since the Species column is a factor,
we receivethe counts of each level. We can see we have no NA values in
Species.<br>

## Explore S3 vs. S4

S3 and S4 refer to two different object-oriented programming systems
that allow developers to create custom classes and methods. <br> S3
systems are informal, lightweight, and simple. They are mostly used when
a project does not require strict class definitions or structures, and
there is a desire for the classes to work with standard R functions. S4
systems, on the other hand, are best for large, complex systems with
formal structures. It is best used when classes involve complex
relationships and multiple inheritance.<br> In this section, I create a
S3 and S4 objects, analyze their usages with generic functions, and
compare their similarities and differences.<br> First, let’s create a
list with the attributes of name, age, and GPA. Let’s assign this
variable a class called “student_s3”:<br>

``` r
s3_obj <- list(name = "Myself", age = 29, GPA = 3.5)
class(s3_obj) <- "student_s3"
```

If we print s3_obj, we will receive the outputs assigned to each
attribute:<br>

``` r
s3_obj
```

    ## $name
    ## [1] "Myself"
    ## 
    ## $age
    ## [1] 29
    ## 
    ## $GPA
    ## [1] 3.5
    ## 
    ## attr(,"class")
    ## [1] "student_s3"

To create an S4 class and object, we will need to use the setClass() and
new() function. setClass() allows us to create a class; within its
parameters, we can set the name of the class, the name of the
attributes, and the class types of the attributes. To create an object
from the class, we use the new() function, passing in values to each
predefined slot:<br>

``` r
setClass("student_s4",
  slots = c(name = "character", age = "numeric", GPA = "numeric"))
s4_obj <- new("student_s4", name = "Myself", age = 29, GPA = 3.5)
```

Unlike S3 objects, we must define the class and its attributes first
before creating an object from it. S3 objects are the opposite; create
the attributes and values first before assigning the object a class.<br>
If we print s4_obj, we will receive the value for each object’s
attribute:<br>

``` r
s4_obj
```

    ## An object of class "student_s4"
    ## Slot "name":
    ## [1] "Myself"
    ## 
    ## Slot "age":
    ## [1] 29
    ## 
    ## Slot "GPA":
    ## [1] 3.5

Generic functions are functions that performs an action based on the
class of the object being passed into the argument. R allows us to build
our own generic functions using the UseMethod() function. Developers use
UseMethod() to define their own generic function; depending on the class
of the object being passed, a certain action can occur.<br> Below, I
define a function named “generic_func” with UseMethod():<br>

``` r
generic_func <- function(x, ...){
  UseMethod("generic_func")
}
```

Let’s create four methods for generic_func: student_s4, student_s3,
numeric, and character.<br> The methods student_s4 and student_s3
determine if the object is part of the student_s4 or student_s3 classes
respectively. The methods numeric and character determine if the class
of the object is part of the numeric or character class respectively.
Depending on the object’s class, a print statement is returned,
signifying the object’s class.<br>

``` r
generic_func.student_s4 <- function(x, ...){
  print("This is a student_s4 object")
}

generic_func.student_s3 <- function(x, ...){
  print("This is a student_s3 object")
}

generic_func.numeric <- function(x, ...){
  print("This is a numeric object")
}

generic_func.character <- function(x, ...){
  print("This is a character object")
}
```

First, let’s pass s3_obj and s4_obj into generic_func():

``` r
generic_func(s3_obj)
```

    ## [1] "This is a student_s3 object"

``` r
generic_func(s4_obj)
```

    ## [1] "This is a student_s4 object"

The generic_func() function determines the classes of s3_obj and s4_obj.
Once their classes have been determined, generic_func() runs the
function based on the class. In this case, it is the print statement,
“This is a (class name) object.”<br> We can do the same for s3_obj and
s4_obj attributes. We reference attributes of S3 objects with a “\$” and
S4 objects with an “@”:<br>

``` r
generic_func(s3_obj$name)
```

    ## [1] "This is a character object"

``` r
generic_func(s4_obj@age)
```

    ## [1] "This is a numeric object"

The output returns whether the object is a character or numeric, similar
to the former two generic_func() statements above.<br>

## Discussion Questions

To determine whether an object uses S3 or S4, we use the str() function.
S3 systems are built from lists and S4 systems are built from a formal
class system. Let’s test this using s3_obj and s4_obj:<br>

``` r
str(s3_obj)
```

    ## List of 3
    ##  $ name: chr "Myself"
    ##  $ age : num 29
    ##  $ GPA : num 3.5
    ##  - attr(*, "class")= chr "student_s3"

``` r
str(s4_obj)
```

    ## Formal class 'student_s4' [package ".GlobalEnv"] with 3 slots
    ##   ..@ name: chr "Myself"
    ##   ..@ age : num 29
    ##   ..@ GPA : num 3.5

These outputs display the differences between s3_obj and s4_obj: s3_obj
is a “List of 3” and s4_obj is a “Formal class … with 3 slots.”<br>
Similarly, we use isS4() to determine if an object is a S4 system:<br>

``` r
isS4(s3_obj)
```

    ## [1] FALSE

``` r
isS4(s4_obj)
```

    ## [1] TRUE

While the class() function determines the high-level classification of
an object, str() outputs an object’s internal structure and detailed
components.<br>

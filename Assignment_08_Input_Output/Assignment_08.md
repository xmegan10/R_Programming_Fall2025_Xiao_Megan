Assignment_08
================
Author: Megan Xiao

Due Date: 2025-10-19

## Import Assignment 6 Data

Importing a TXT file into R requires the read.table() function. Users
can provide the file path and name within the first argument or use the
file.choose() function, which lets us choose a file from our computer
interactively. Since file.choose() does not work when publishing R
Markdown files, we will import the file using the file name for this
demonstration. <br> We’ll import the TXT file with column names by
specifying header = TRUE, import strings without converting them into
unique factor levels, and separate values into their respective columns
by specifying sep = ‘,’. <br>

``` r
#Original code, allows user to choose file interactively
#student6 <- read.table(file.choose(), header = TRUE, stringsAsFactors = FALSE, sep = ',')

student6 <- read.table("Assignment 6 Dataset.txt", header = TRUE, stringsAsFactors = FALSE, sep = ',')
```

We can now access the file (“Assignment 6 Dataset.txt”) in our
environment. Let’s transform this file into a DataFrame. <br>

``` r
student6 <- data.frame(student6)
```

We want to see the average grade values for females and males. We can
achieve this using the plyr package. We’ll import it with library().
Then, with the ddply() function, we select the student6 DataFrame,
select the “Sex” column, apply the summarise function on “Sex” (our
grouping variable), and create a new column titled “GradeAverage” that
displays the average grade values for our grouping variable, Sex. <br>

``` r
library(plyr)
gender_mean <- ddply(.data = student6,
                     .variable = "Sex",
                     .fun = summarise,
                     GradeAverage = mean(Grade, na.rm = TRUE))
```

Let’s view gender_mean:<br>

``` r
gender_mean
```

    ##      Sex GradeAverage
    ## 1 Female      86.9375
    ## 2   Male      80.2500

Females have a higher grade average than males based on this data
set.<br> To save this new DataFrame as a TXT file on our computer, we
use the write.table() function. We specify the following arguments: the
DataFrame, the name of the new TXT file, separation method (sep = “
means separating values using tab), and whether row names should
display.<br>

``` r
write.table(
  gender_mean,
  file = "gender_mean.txt",
  sep = "\t",
  row.names = FALSE)
```

After refreshing our file directory, we see a new file: gender_mean.txt.
This file also appears in this Github directory. <br>

## Filter Names Containing “i”

Many applications, like SQL and Python, let developers filter data sets
based on specific attributes. Filtering is mandatory for almost all
real-life data sets, since data in the real world are often messy and
disorganized. <br> Subsetting is a user-friendly way of selecting and
excluding variables and observations, like indexing. To select only the
rows in Name containing the letter “i” or “I,” we pass the DataFrame,
student6, and the selection expression, grepl(). In grepl(), we specify
the pattern we want to keep, the column we extract the pattern from, and
ignore cases in matching so that we get the rows regardless of whether
the letter is upper- or lower-case.<br>

``` r
i_students <- subset(
  student6,
  grepl("i", Name, ignore.case = TRUE)
)
```

Printing i_students, we see that we have only saved rows where names
contained the letter “i.”<br>

``` r
i_students
```

    ##         Name Age    Sex Grade
    ## 3      Lauri  21 Female    90
    ## 4     Leonie  21 Female    91
    ## 6    Mikaela  20 Female    69
    ## 8       Aiko  24 Female    97
    ## 9   Tiffaney  21 Female    78
    ## 10    Corina  23 Female    81
    ## 11 Petronila  23 Female    98
    ## 12    Alecia  20 Female    87
    ## 13   Shemika  23 Female    97
    ## 15   Deloris  21 Female    67
    ## 17     Eboni  20 Female    84
    ## 18   Delfina  19 Female    93
    ## 19 Ernestina  19 Female    93
    ## 20      Milo  19   Male    67

Similar to using write.table() to create TXT files, we can use the
write.csv() function to export DataFrames or columns of a DataFrame to a
CSV. We specify the following arguments: the DataFrame column, the name
of the new CSV file, whether row names should display, and whether
columns should be surrounded by double quotes. <br>

``` r
write.csv(
  i_students$Name,
  file = "i_students.csv",
  row.names = FALSE,
  quote = FALSE
)
```

## Export Filtered Dataset

We will export the entire i_students DataFrame as a CSV file. This
expression is the same as the one we did before, except we do not set
quote to FALSE. <br>

``` r
write.csv(
  i_students,
  file = "i_students_full.csv",
  row.names = FALSE
)
```

The following files will now be visible in the current working
directory: “gender_mean.txt”, “i_students.csv”, and
“i_students_full.csv”. <br>

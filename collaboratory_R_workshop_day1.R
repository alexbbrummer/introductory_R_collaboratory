#### Collaboratory Workshop - Introduction to Programming in R - Day 1/3 ####

# This workshop aims to teach you the basics of using R Studio, and speaking the R language.
# The workshop is designed in two parts for each day.  In the first part we are introduced to 
# different aspects of R and programming in general, all built towards the broad task of reading
# some data into R, graphing it (or a portion of it), and performing some type of statistical 
# test on the data.  In this first portion you are reading instructions and typing code along
# with the instructor.  In the second portion you will work on implementing the techniques
# introduced, but on a different dataset.

# << R overview >> -----------------------------------------------------------------------

# R reads your data (e.g., from an excel or text file) and makes an image of it, which is
# stored in temporary memory. When you edit your data, you are only editing an image of
# it; the original dataset is unaffected.  You can then create graphs and altered
# datasets, which can be written back to a permanent file. This is called 'nondestructive
# editing'. You can also create objects (like matrices) from directly within R, as opposed
# to reading them in from a file.

# R can do almost anything you can think of doing with your data, which greatly expands
# the amount of creativity you can apply to your analyses. By using scripts (".R" files, 
# such as this one), you can keep a record of everything you've done to manipulate and 
# analyze your data. Those benefit you later, and can be published or shared with colleagues.

#=========================================================================================
# Part 1: Getting to know R Studio and basic R functionality
#=========================================================================================

#-----------------------------------------------------------------------------------------
# R Studio layout
#-----------------------------------------------------------------------------------------

# R studio is just a nice visual interface with R. You can open up R on its own to see
# what the default visual interface looks like.

# R Studio has 4 window panes: Script window (upper left), console (below), two
# multi-purpose windows (right). You can drag the edges to adjust sizes.

# NOTE: What is a script?:
# A script is like a story about your data analysis. It is written with comments in plain English (preceded by the pound, or hashtag, symbol), and code in the R language. R reads the story, ignoring the English, and performing the actions you instructed it to take (this is "running", "executing", or "compiling" the code). You can execute code directly in the console by hitting return. But writing scripts keeps a record of every step of your analysis, and allows you re-run the analysis later (maybe on an altered datasest), or change steps in the analysis.  To run code from your script, press command+return (for MACs) or Ctrl+return (for PCs).  To run multiple lines of code from script, you must first highlight the desired lines and then press the command+return or Ctrl+return buttons.

# Script window: This is where you develop scripts. Some nice automatic functions include
# color coding, indenting, auotmted bracket/quote closing, and tab completion. Multiple scripts can be stored in
# separate tabs that can be selected above. It's useful to keep several old scripts open
# in these tabs to use as a reference while you work.

# Console window: This is like the regular R console window from the command line (terminal) interface. This is where your scripts run, and where visualized results are returned (but if you don't ask R to show you something, it won't).

# Bottom right window: This is mostly used for viewing Help files and Plots you've created
# during a session.

# Upper right window: Here you can view a list of items in your 'Environment'. These are
# all the objects you've created or loaded into your environment during this session.

#=========================================================================================
# Part 1.5: How to ask for HELP!
#=========================================================================================

# Anytime you want to ask R for help, type the word (function, object, etc.) that you want more information on preceded by a question mark, and R will provide you with the R Documentation for that thing. Alternatively you can use the help function, "help()", where you place the object you want more information on inside the parenthesis.  The documentation will be provided in the bottom right window.   Let's practice on a few commands.

?mean
?plot
help(mean)
?help

# Note that sometimes the documentation is useless, and searching the internet for additional documentation (help) is necessary.  In these instances you can also ask for help by using Google and strategic searching.  This typically includes the name of the function, command, or object you want information on, and the letter "R" to make sure that you are searching for results specific to the R language.

#=========================================================================================
# Part 2: Importing data as data frames
#=========================================================================================

#-----------------------------------------------------------------------------------------
# The working directory
#-----------------------------------------------------------------------------------------

# Setting a 'working directory' simplifies importing and exporting. When you ask R to
# import (read) a file, or export (write) a file, it will point automatically to the
# working directory, so you don't have to type in a directory path.

# >> The easiest way: set wd to the script file location.
# In R Studio, go to "Session" in the drop-down menu at the very top.
# Click "Set working directory" -> "to source file location".
# This will point R to the folder containing THIS SCRIPT.
# Notice that the line of code for doing that is implemented in the console. To
# incorporate that line into your script (so you don't have to take that extra step in the
# future) just copy it from the console and paste it into the script.

setwd("~/Directory path to the folder containing the R Primer script")

setwd("/Users/alexwork/Desktop/collaboratory_R_workshop_062719/day1/")

# You can also ask R what the current working directory is by using the command getwd().

getwd()

# Finally, you can ask R what files and folders are contained in the current working directory by using the dir() command

dir()

# NOTE: you can use the command setwd() to set the working directory to any other file
# path you want. The "~" points to your current directory. When in doubt, type the full file path instead of "~".

#-----------------------------------------------------------------------------------------
# Reading in a file as a data frame.
#-----------------------------------------------------------------------------------------

# Now we're going to load our field data into R for analysis.
# Set your working directory to the folder that contains the "iris.csv" data as described above.
# Use the read.table() function to read in the file and assign it to an object called
# 'iris.data'.  

# In order store the imported data as an object in R, we will use the assignment command <- in conjunction with a name for the object.

iris <- read.table (file="iris.csv", sep=",", header=TRUE, row.names = 1)

# To view the data in the Console, run the name of the object.

iris

# >> read.csv() function
# This is a shortcut for '.csv' files. The default separator is "," and header=TRUE.
iris.2 <- read.csv(file="iris.csv", row.names = 1)

#=========================================================================================
# Part 3: Viewing your data.frames.
#=========================================================================================

# >> Viewing the data frame as a spreadsheet.
# Go to the upper right R Studio window, in the Workspace tab, click on iris. It will open
# a new script tab and show you the first 1000 rows of your data table in spreadsheet format.
# Alternatively, you can use the View() command.

View(iris)

# CAUTION! Viewing large datasets (100,000 rows or more) can slow down R.  If you are working with large datasets, ask your mentor for effective ways of viewing them.

## Some data functions
# >> str(), will print the "structure" of a data.frame (number of rows and columns, the names of the columns, and the class of the columns (we'll talk about classes momentarily)).

str(iris)

# >> head() prints the first six rows of data in the console.
head(iris)

# >> tail() prints the last six rows of data in the console.
tail(iris)

# >> names() gives you a list of column names in the data frame. (For a data frame, it's
# the same as colnames() )
names(iris)

colnames(iris)
rownames(iris)

#=========================================================================================
# Part 4: Accessing the data in your data.frames, AKA Indexing
#=========================================================================================

# If we wanted to access certain columns in our data.frames, we need to perorm a task that is called "indexing".  There are many nuances to indexing and it is an extremely powerful tool.  There us much to say about indexing, but for now we will learn only what we need most for the time being.

# There are two primary ways of accessing different colums of data in our data.frames.  One method is by using matrix notation where we input the numerical position for the row and column, seperated by a comma.  If we wanted to print the 10th row and the 7th column, we would type iris[10,7].

iris[10,3]

# If we want to print an entire row, then we leave the space for the column number blank.

iris[10, ]

# If we want to print an entire column (most useful for making graphs), then we leave the space for the row number blank.

iris[ ,3]

# The other method of accessing entire columns of data is to use the dollar sign, $, and the name of the column we want to access.  So to print the column for Species, we would type iris$Species

iris$Species

# From here we can access particular rows in the iris$Species vector by using the numerical method as described earlier, only now we don't need to use any commas since the iris$Species vector is one-dimensional whereas the data.frame is two-dimensional.  So, let's print the 10th entry in the iris$Species vector.

iris$Species[10]

# If we wanted to print more than one row from our iris$Species vector (or more than one column and row from our iris data frame) then we can use the c() command and the colon symbol for listing.  For example, let's print rows 1 through 10 in the iris$Petal.Width column of data by indexing with c(1:10).

iris$Petal.Width[c(1:10)]

# If we wanted to print more than one set of rows then we use a comma.  Let's try printing rows 1 through 10 and rows 12 through 15 by indexing with c(1:10, 12:15)

iris$Petal.Width[c(1:10, 12:15)]

#=========================================================================================
# Part 5: Mathematical operations and functions
#=========================================================================================

# We can use R just like a calculator to perform basic mathematical operations on numbers.  The operators for addition, subtraction, mulitplication, and division are, (+, -, *, /).  For exponents, you can use either the carrot symbol (^) or the multiplication symbol twice (**).  Here are some examples...

2 + 3
2 - 3
2*3
2/3
2^3
2**3

# We can also use the assignment operator to define a new variable and do math on the variable.  For example, let's define the letter a to be the number 2.
a <- 2

# Repeating our above operations...
a + 3
a - 3
a*3
a/3
a^3

# We can even save our operations on a as yet another variable, let's call it b
b <- a + 3
c <- a - 3
d <- a * c

# Many mathematical functions exist within R.  Here are a few examples.

# The statistical functions, like, mean, varation, 

mean(iris$Sepal.Length, na.rm = TRUE)

var(iris$Sepal.Length)

# Random/probabilistic number generators, like normal, lognormal, binomial

rnorm(n = 10, mean = 0.5, sd = 3)

rlnorm(n = 10, meanlog = 0.5, sdlog = 3)

rbinom(n = 10, size = 100, prob = 0.5)

# Common functions, like sine, cosine, log, exp

sin(pi/2)
cos(pi/2)

exp(1)

log(exp(1))
log10(10)

log(x = 20, base = 20)


#=========================================================================================
# Part 6: Object (data) Types, or Classes.
#=========================================================================================

# You may have noticed that the commands iris$Petal.Width[10] and iris$Species[10] returned slightly different results.

iris$Petal.Width[10]
iris$Species[10]

# iris$Petal.Width[10] returned "[1] 0.1", while iris$Species[10] returned "[1] setosa
# Levels: setosa versicolor virginica".  That is, iris$Petal.Width[10] just returned the numerical value, and iris$Species[10] returned both the Species value as well as a list of all of the other Speciess available.  This is because these two columns are different classes, or types of data.  The main classes that we will be working with are:
# integers, numerics, characters, data.frames (fancy matrices), logicals and factors.  Other than factors, all of these classes are fairly universal across programming languages.  Factors are specific to R, however Python has a class that is somewhat similar to factors, called a "dictionary".
# >> Integers are rounded numbers (-6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6).  They are great for indexing!
# >> Numerics are non-rounded numbers (0.5, -1.2, 145.039).  They are great for measured values!
# >> Characters are collections of alpha-numeric letters, as well as punctuation, and are always surrounded by quotation marks ("string", "cheese", "incident", "asdf083lkj", "j.k. rowling")
# >> Data frames are what we've been working with for analyzing data.
# >> Logicals are the statements TRUE (T) or FALSE (F).  Try executing the statement "TRUE", without quotes.

TRUE

# Next try executing the statements 2 < 5, and 5 < 2.

2 < 5
5 < 2

# Logicals are useful for indexing by some kind of condition on your data.  We will return to this idea shortly.

# >> Factors are vectors (or columns) of repeating characters or integers used to subdivide larger collections of other classes into the common or shared factor.  For example, iris$Species is defined as a factor because even though there are many different flower occurances in the data frame, many of them have the same type of Species.  The factor class can be difficult and awkward to work with and understand, but it can also be very powerful.

# Finally, there are vectors and lists.  These are one dimensional collections of objects of either the same class (vectors) or different classes (lists).  Because of this, lists are typically more complicated collections, while vectors are simpler collections.  Your data frame iris is technically a collection of column vectors, each of varying class.  To find out the class of an object use the class() command.  Let's practice on the iris data frame and some its columns.

class(iris)
class(iris$Species)
class(iris$Petal.Width)

# To define a vector, we use the c() function, short for concatenate.

a.vec <- c(1,2,3,4)


# But don't mix up the classes of the objects in your vector...otherwise R will coerce everything to one class


a.bad.vec <- c(1,2,3,4, "cheese")


# If you want a one-dimensional object with mixed classes, use a list and the list() function.

a.list <- list(1, 2, 3, 4, "cheese", a.vec, a.bad.vec)


# Indexing lists is different though, we must use double square brackets

a.list[[2]]
a.list[[5]]


# To index the vectors inside of list, then we use a second set of indexing variables.

a.list[[6]]
a.list[[6]][3]


#=========================================================================================
# Activity 1
#=========================================================================================

### With your designated partner, practice the following tasks.
# Read the hawks.csv data into R
# Calculate the mean value of the first hundred entries of data from each numerical column of data from the hawks.csv data
# Save each value as a list item.

hawks <- read.csv(file = "hawks_day1.csv")

names(hawks)

hawks.means <- list(mean(hawks$Wing[1:100]), mean(hawks$Weight[1:100]), mean(hawks$Tail[1:100]))

hawks.means

#=========================================================================================
# Part 7: Basic Plotting
#=========================================================================================

# Here we will examine some basic aspects of plotting our data, and introduce the plotting package "ggplot".  Packages are extra bundles of funtions and utilities that do not come with the default installation of R or RStudio.  You likely do not already have "ggplot2" installed, so first we will run the function install.packages() with the argument "ggplot2".

install.packages('ggplot2')

# Once you have installed the package, you need to use the library() function with the pacakge name to load the package into your workspace.

library(ggplot2)

# Now to use ggplot.  ggplot is not the default plotting method for R.  That is simply "plot()".  However, ggplot has quickly become a favored plotting pacakge for use in R, so we will be using it exclusively.  Let's plot a histogram of our data.  A histogram is very common plot. It plots the frequencies that data appears within certain range of values.

# basic histogram
# First we have to tell R which data set we want to graph using ggplot, and which aspect of the data in particular we are interested in.  The aes() function refers to aesthetics, and it is how we tell R how specifically which data to plot (in this case, to associate Sepal.Width with the x-axis). The "+" symbol tells R that we are going to do more in the following line, in this case to plot a histogram out of the data
ggplot(data = iris, aes(x=Sepal.Width))+ 
  geom_histogram()

# Great, but that is a rather messy graph.  Let's add some change bin width and color
ggplot(data = iris, aes(x=Sepal.Width))+
  geom_histogram(binwidth = 1, fill='green')

# That wasn't exactly better, but you see how we can adjust the boundary color and the fill color.  Now, about the binwidth, an important message for histograms.  Instead of selecting the binwidth, we could also select the number of bins.

ggplot(data = iris, aes(x=Sepal.Width))+
  geom_histogram(bins = 7)

ggplot(data = iris, aes(x=Sepal.Width))+
  geom_histogram(bins = 100)

ggplot(data = iris, aes(x=Sepal.Width))+
  geom_histogram(bins = 1)

# So how many bins is the "right" number of bins?  The answer depends on who you ask.  Either too many or too few and you can not see any real patterns in your data.  General rules exist, for example one is that the number of bins should roughly equal the cube-root of number of data points (but that also assumes a level of normality in the data, or that the data is gaussian distributed).  As long as your statistics don't depend on the number of bins, then the decision primarily influences the visual power of the graph.  So, we'll simply pick a number of bins that most ellucidates the general trends.

ggplot(data = iris, aes(x=Sepal.Width))+
  geom_histogram(bins = 7)

ggplot(data = iris, aes(x=Sepal.Width))+
  geom_histogram(bins = 10)

ggplot(data = iris, aes(x=Sepal.Width))+
  geom_histogram(bins = 20)

# Now let's do some very rudimentary statistics by calculating the mean value of Sepal.Width and adding its value to the graph as a line.  First we will use the mean function.

mean(x = iris$Sepal.Width)

mean.sep.wid <- mean(x = iris$Sepal.Width)

# Add a mean line to the graph

ggplot(data = iris, aes(x=Sepal.Width)) +
  geom_histogram(bins = 20) +
  geom_vline(aes(xintercept=mean.sep.wid))

# Change some of the formatting

ggplot(data = iris, aes(x=Sepal.Width))+
  geom_histogram(bins = 20)+
  geom_vline(aes(xintercept=mean.sep.wid), color = "blue", linetype = "dashed", size = 1)

## But now a question, our data has values for three different values, yet we have plotted all of them together in one histogram.  So, which for species is this the mean value of sepal lengths?  Setosa, versicolor, virginica, or some combination of them?

## Let's split our data by species and try plotting each separately by color, but in the same graph.  This is where the factor class comes in handy!

ggplot(data = iris, aes(x=Sepal.Width, fill = Species))+
  geom_histogram(bins = 20)+
  geom_vline(aes(xintercept=mean.sep.wid), color = "blue", linetype = "dashed", size = 1)

## It appears that our values are stacked on top of one another.  We can change this by specifying the "dodge" parameter, and the "alpha" channel for how transparent the colors are.

ggplot(data = iris, aes(x=Sepal.Width, fill = Species))+
  geom_histogram(bins = 20, position = "identity", alpha = 0.5)+
  geom_vline(aes(xintercept=mean.sep.wid), color = "blue", linetype = "dashed", size = 1)

## Clearly the mean value of petal length doesn't well represent the three separate species.  So, let's add mean values for each species instead. But wait, what are the mean values for each species?  To find out, we must index our data set using logicals.

## We want to extract all of the rows of the iris data frame whose species value is either setosa, versicolor, or virginica.  We can do this by writing a logical statement comparing every value in the species vector with the name of interest.

iris$Species == "setosa"
iris$Species == "versicolor"
iris$Species == "virginica"

## By using the which() function, we can identify which rows indeces correspond to the TRUEs from the above locical statements.

which(iris$Species == "setosa")
which(iris$Species == "versicolor")
which(iris$Species == "virginica")

## Now, we can use this vectors of indeces to subset the Sepal.Width column vector to extract the petal length values corresponding to the species of choice.

iris$Sepal.Width[which(iris$Species == "setosa")]
iris$Sepal.Width[which(iris$Species == "versicolor")]
iris$Sepal.Width[which(iris$Species == "virginica")]

## And finally we can define new variables for each mean value to keep the code clean.

ave.set.sep.wid <- mean(iris$Sepal.Width[which(iris$Species == "setosa")])
ave.ver.sep.wid <- mean(iris$Sepal.Width[which(iris$Species == "versicolor")])
ave.vir.sep.wid <- mean(iris$Sepal.Width[which(iris$Species == "virginica")])

## To keep things tidy, we will define a new data frame for just these mean values.  To do this, we will use the data.frame() function to define the column names and column entries.

means <- data.frame("mean_values" = c(ave.set.sep.wid, ave.ver.sep.wid, ave.vir.sep.wid), "Species" = c("setosa", "versicolor", "virginica"))

## And now we can use one call to the geom_vline() function to add lines for each mean value.  Note that now we must specify "data = means" and "xintercept = mean_values".  Since we want all groups to have the same linetype and size, those parameters are specified outisde of the aes() function.

ggplot(data = iris, aes(x=Sepal.Width, fill = Species))+
  geom_histogram(bins = 20, position = "identity", alpha = 0.5)+
  geom_vline(data = means, aes(xintercept = mean_values, color = Species), linetype = "dashed", size = 1)



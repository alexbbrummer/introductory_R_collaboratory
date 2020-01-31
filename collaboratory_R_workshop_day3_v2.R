
#=========================================================================================
# Part 0: Recap - Functions
#=========================================================================================

# Let's write a function that takes data frames and will plot a histogram depending on whether or not one of the column names meets a criteria. In this case, the criteria is whether or not the first column name is "blue".


my_plotting_function <- function(dataframe = dataframe, plotname){
  ## This function takes as its argument a csv file and, if the column name of the first column is "blue", then it will print to file a histogram of the "blue" column.
  if(names(dataframe)[1] == "blue"){
    # if(mean(dataframe[,1]) < 0){
    # ggplot(data = dataframe, aes(x = dataframe[,1]))+
    ggplot(data = dataframe, aes(x = blue))+
      geom_histogram(bins = 20)+
      labs(title = plotname)
  }
}


# Let's test our function on a sample file.  First, we need to change our directory to the data file directory

setwd("/Users/alexwork/odrive/Dropbox/Teaching/collaboratory_R_workshop/day2/data_files/")

test_file <- read.csv(file = "file_1.csv", header = TRUE)

my_plotting_function(dataframe = test_file, plotname = "test")

# Great, it appears to work.

#### Modify the function we made to produce an xy scatter plot of the two columns in the csv file *if* the mean value of the first column is negative.

# Modifying the function, and giving it a new name so we don't override the first function.

my_plotting_function2 <- function(dataframe = dataframe, plotname){
  ## This function takes as its argument a csv file and, if the column name of the first column is "blue", then it will print to file a histogram of the "blue" column.
  if(mean(dataframe[,1], na.rm = TRUE) < 0){  #here is the modified *if* statement
    ggplot(data = dataframe, aes(x = dataframe[,1], y = dataframe[,2]))+ #here is the modified plotting statements.
      geom_point()+
      labs(title = plotname)
  }
}

# Let's real quick check that this function does what it should.
my_plotting_function2(dataframe = test_file, plotname = "Test plot")

# We have an error!  And it has to do with the mean() function.  Let's try just running mean(test_file[,1]) to see what happens.
mean(test_file[,1])

# AHA!  We have NAs to handle!  Let's modify our function to handle NAs

# Let's try a case where the mean value is less than one.  That would be "file_4.csv".
test_file3 <- read.csv(file = "file_3.csv", header = TRUE)
mean(test_file3[,1], na.rm = TRUE)
my_plotting_function2(dataframe = test_file3, plotname = "Test plot 3")


# Now, let's write a for loop to run through all the files in the directory and use our first function on each one.


for(i in 1:length(dir())){
  # Use the dir() function to access all of the file names in the directory, and index dir().
  loop_file <- read.csv(file = dir()[i], header = TRUE)
  # Also, because we are plotting within a loop, we need to use the print() function to "print" the graphs as output.
  print(my_plotting_function(dataframe = loop_file, plotname = i))
}

#### Breakout session to practice the above ideas:

#### Use the second function you made in a for loop to produce graphs for all data files that meet the negative mean value criteria.

# Let's first set the working directory.
setwd("/Users/alexwork/odrive/Dropbox/Teaching/collaboratory_R_workshop/day2/data_files/")

for(i in 1:length(dir())){
  loop_file <- read.csv(file = dir()[i], header = TRUE)
  print(my_plotting_function2(dataframe = loop_file, plotname = i))
}

#### Modify the for loop so that each graph is saved to file as a png in the "graphs" folder (not the data_files folder).  A function that you may find useful for doing this is the paste() function, which takes two character class arguments and merges them together.  For example, I can use the paste() function to merge "string" and "cheese" into "string_cheese" as

paste("string", "cheese", sep = "_")

# For this scenario we will use the png() and dev.off() functions.  However, we have to specify that the graphs are to be saved in the "graphs" folder.  But, we don't want to change directories from that which has our data.  This is where the paste() function comes in use, as we can use it to paste the new directory into the filename for the saved graphs.

for(i in 1:length(dir())){
  loop_file <- read.csv(file = dir()[i], header = TRUE)
  png(filename = paste("/Users/alexwork/odrive/Dropbox/Teaching/collaboratory_R_workshop/day2/graphs/", i, ".png", sep = ""), width = 11, height = 8.5, units = "in", res = 300)
  print(my_plotting_function2(dataframe = loop_file, plotname = i))
  dev.off()
}


#=========================================================================================
# Part 1: Density plots, Box plots, and Violin plots
#=========================================================================================

# We will be using the hawks data for this activity.  So lets read into RStudio our hawks day3 file.

setwd("/Users/alexwork/odrive/Dropbox/Teaching/collaboratory_R_workshop/day3/")
hawks <- read.table(file = "hawks_day3.csv", header = TRUE, sep = ",", na.strings = c("", "NA"))
hawks <- na.omit(hawks)

#### Density plots ####

# Using a similar call to ggplot(), we will now use the geom_density() function to specify the type of graph we want to make out of our data.

ggplot(hawks, aes(x=Tail, fill = Species))+
  geom_density(alpha = 0.5)

#### Boxplots ####

# Using a similar call to ggplot(), we will plot the data as a bar plot instead of a histogram by using the geom_boxplot() function.


ggplot(hawks, aes(x=Species, y=Tail, fill = Species))+
  geom_boxplot()


# However, we may yet still want to see more structure in the data.  What if our data is bi-modal (has two peaks instead of just one).  To do this, we can look at Violin plots.

#### Violin plots ####

# Violin plots are similar to density plots, only they have been rotated, stretched, mirrored, and placed as non-overlapping objects.

ggplot(hawks, aes(x=Species, y=Tail, fill = Species))+
  geom_violin(trim = FALSE)

# But what if we still want to see the information for the distribution moments?  Let's add a boxplot to our violin plot.

ggplot(hawks, aes(x=Species, y=Tail, fill = Species))+
  geom_violin(trim = FALSE)+
  geom_boxplot()

# Cool idea, but it's a bit ugly.  Fortunately we can scale the sizes of our boxes.

ggplot(hawks, aes(x=Species, y=Tail, fill = Species))+
  geom_violin(trim = FALSE)+
  geom_boxplot(width = 0.2)

# Don't forget about Histograms.

ggplot(hawks, aes(x=Tail, fill = Species))+
  geom_histogram(bins = 20, position = 'identity', alpha = 0.5)
  

#=========================================================================================
# Part 2a: Some Stats Functions for 1D data
#=========================================================================================

## Finally, you might ask, "What about all those statistical tests?"

## Many statistical methods are already encoded into R.  We will highlight a few.

#### t-test on tail lengths between sharp shinned and cooper's hawk species.

t.test(x = hawks$Tail[which(hawks$Species == "SS")], y = hawks$Tail[which(hawks$Species == "CH")])

## CAUTION, R does not check assumptions for you.  You must do that yourself!!!

# By assigning the results of the t.test() to a variable, you can access the results for later use.

ttest_results <- t.test(x = hawks$Tail[which(hawks$Species == "SS")], y = hawks$Tail[which(hawks$Species == "CH")])

#### ks test 
ks.test(x = hawks$Tail[which(hawks$Species == "SS")], y = hawks$Tail[which(hawks$Species == "CH")])

#### Anova.  Here we will focus on the sharp shinned hawks only to examine how the tail measurements depend on the categorical age and sex of the hawks.  To run an anova on the dataset we have, we need to install and load a special package called "car".  This is because our data set has unequal numbers of data for age and sex.

install.packages("car")
library("car")

## Subsetting the data for just the sharp shinned hawks.

ss.hawks <- hawks[which(hawks$Species == "SS"),]

# Now, we will have to run our test in two steps.

my_anova <- aov(formula = Tail ~ Age * Sex, data = ss.hawks)
Anova(my_anova, type = "III")


#=========================================================================================
# Part 2b: Some Stats Functions for 2+D data
#=========================================================================================

#### Linear models (regression).  Suppose we want to fit a linear model to the tail versus wing relationship for the Sharp Shinned hawks, we use the lm() function (short for linear model).

ss.tw.lin.mod <- lm(formula = Tail~Wing, data = ss.hawks)

summary(ss.tw.lin.mod)

##  We can also plot this linear model to our data using the stat_smooth() function with ggplot().

ggplot(data = ss.hawks, aes(x = Wing, y = Tail))+
  geom_point()+
  stat_smooth(method = "lm")

#### Clustering graphs

## Some of you may be interested in using automated methods for identifying clusters within your data.  One particular method of doing this is called k-means clustering.  In this approach, the data is divided into a given number of clusters, where the clusters are determined so as to minimize the euclidean distance from their centers to every point within the cluster.

kmeans(x = hawks[,c("Tail", "Weight")], centers = 4)

clusters <- kmeans(x = hawks[,c("Tail", "Weight")], centers = 4)

# Now we will make a new column in the hawks data frame called tail.weight.cluster that is a factored vector of the cluster number from our clusters object.

hawks$tail.weight.cluster <- factor(clusters$cluster)

ggplot(data = hawks, aes(x = Weight, y = Tail))+
  geom_point(aes(color = tail.weight.cluster))

# In this example, we already knew what that these clusters were associated with species and sex, however in other research you conduct the kmeans method may be an insightful way to explore your data and help guide your reasoning.



#### Principle Component Analysis

# Principle component analysis is a way of identifying which variables are responsible for the greatest amount of variation in your data.  In an abstract way, we take the axes that correspond to your original dataset, and we rotate them to point in new directions (consisting of linear combinations of your old dataset axes).

# To study it, we will use the two following packages: "FactoMineR" and "factoextra".

install.packages(c("FactoMineR", "factoextra"))                 

library("FactoMineR")
library("factoextra")

# Next, we will set the working directory for the Day 3 materials and read into R the mtcars.txt data set

setwd("/Users/alexwork/odrive/Dropbox/Teaching/collaboratory_R_workshop/day3/")

cars <- read.csv(file = "mtcars.txt", header = TRUE)

# Uh oh, the cars object in our environment does not look like a data frame.  Let's look at the file we are trying to read and see what might have happened.

# The file format is .txt, let's google how to read .txt files into R

cars <- read.delim(file = "mtcars.txt", header = TRUE, sep = "\t", row.names = 1)

# Let's look at the data file.

View(cars)

# An NaN!  Let's re-run the read.delim function to read the NaN values as NA's.

cars <- read.delim(file = "mtcars.txt", header = TRUE, sep = "\t", row.names = 1, na.strings = c("NaN"))

# And now let's reassign the cars using the na.omit function to remove the bad row.

cars <- na.omit(cars)

# Now we can begine the PCA for the cars data.

# First off, what are the meanings of all the different columns in this dataset.

# mpg: Fuel consumption (Miles per (US) gallon): more powerful and heavier cars tend to consume more fuel.
# cyl: Number of cylinders: more powerful cars often have more cylinders
# disp: Displacement (cu.in.): the combined volume of the engine's cylinders
# hp: Gross horsepower: this is a measure of the power generated by the car
# drat: Rear axle ratio: this describes how a turn of the drive shaft corresponds to a turn of the wheels. Higher values will decrease fuel efficiency.
# wt: Weight (1000 lbs): pretty self-explanatory!
# qsec: 1/4 mile time: the cars speed and acceleration
# vs: Engine block: this denotes whether the vehicle's engine is shaped like a "V", or is a more common straight shape.
# am: Transmission: this denotes whether the car's transmission is automatic (0) or manual (1).
# gear: Number of forward gears: sports cars tend to have more gears.
# carb: Number of carburetors: associated with more powerful engines

# PCA's will only work on numerical data, so we will need to exclude the categorical variables of vs and am.  Also, PCA's assume that the data has already been scaled and centered (zero mean value and unit variance).  There are parameters in the prcomp() function that we will use to perform the scaling and centering for us.

mtcars.pca <- prcomp(x = mtcars[,c(1:7,10,11)], center = TRUE, scale. = TRUE)

# Let's look at a summary of mtcars.pca

summary(mtcars.pca)

# What this information tells us is that most of the variance in the data (two-thirds) is "explained" by the first principle component.

# To help understand what this means, it is important to graph the results.  To do so, we will use a special package called "ggbiplot".  However, to download and install this package, we will need to point RStudio toward a github account using the install_github() function from the devtools library.

library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)

# Plotting our pca results.

ggbiplot(pcobj = mtcars.pca)

# We can replace the points with labels using the labels parameter in the ggbiplot function.  For example, let's label each point with the make and mode for each car to get a better undertanding of which cars are sitting in this PC1-PC2 space.

ggbiplot(pcobj = mtcars.pca, labels = rownames(mtcars))

# This is informative.  We see that sports cars, fuel-economy cars, and muscle cars are all pretty nicely grouped.  What if we want to examine grouping by country?  A nice additional feature is circling common groups (or factors) in the PCA plot.  To do this, we use the ellipsis and group parameters.

ggbiplot(pcobj = mtcars.pca, ellipse = TRUE, labels = rownames(mtcars), groups = cars$origin)

# This too is informative as we can now see manufacturing habits for these different nations.

# Maybe you want to look at the next two principle components.  To do so, we use the choice parameter to select the 3rd and 4th components.

ggbiplot(pcobj = mtcars.pca, choices = c(3,4), ellipse = TRUE, labels = rownames(mtcars), groups = cars$origin)


#=========================================================================================
# Part 3: Writing a data frame to a file
#=========================================================================================

# Sometimes, after we edit a data frame that we have read into R, we want to write that data frame to file (save it as a spreadsheet).  To do so, we use the write.csv() funtion.

# Let's save a copy of the cars data frame as "cars_new.csv".

write.csv(x = cars, file = "cars_new.csv", row.names = TRUE)

#=========================================================================================
# Part 4: Breakout session
#=========================================================================================

##### Produce the following sets of graphs with the Iris dataset.

## A violin plot of petal width (on the vertical axis) and species (on the horizontal axis) and fill the violin colors by the species value (as we did for the hawks).

# Read in the data set
iris <- read.csv(file = "iris.csv", row.names = 1)

# Make ggplot as described above.

ggplot(data = iris, aes(x = Species, y = Petal.Width, fill = Species))+
  geom_violin()

#### An xy scatter plot of petal width (on the vertical axis) versus petal length (on the horizontal axis) where the sybmols *and* the colors represent the species.

# Make scatter plot as described above.

ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width, color = Species, shape = Species))+
  geom_point()

#### Add three fitted lines to the xy scatter plot you just made, one for each species.

# Add the stat_smooth(method = "lm") function to the above code.

ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width, color = Species, shape = Species))+
  geom_point()+
  stat_smooth(method = "lm")

#### *Challenge* Add another legend for the fitted lines that displays the values of the slopes for each line.  This is similar to the legend that displayed the mean values that we began tody with, however you will need to first get the slope for each fit.

# First we need to calculate, extract, and save the fitted slopes for each fitted line.

# Calculating the fitted lines.
# First index the data by species and save as separate data.frames.

pet.wid.len.set <- iris[which(iris$Species == "setosa"),]
pet.wid.len.ver <- iris[which(iris$Species == "versicolor"),]
pet.wid.len.vir <- iris[which(iris$Species == "virginica"),]

# Now perform the linear model function lm() on each subset of data and save as a separate object.

pet.wid.len.set.lin.mod <- lm(formula = Petal.Width~Petal.Length, data = pet.wid.len.set)
pet.wid.len.ver.lin.mod <- lm(formula = Petal.Width~Petal.Length, data = pet.wid.len.ver)
pet.wid.len.vir.lin.mod <- lm(formula = Petal.Width~Petal.Length, data = pet.wid.len.vir)

# Now, to extract the slope, you could run summary() on each linear model object and simply copy the printed value of the slope manually.  Or, we could index the linear model object to extract the value.  We'll practice indexing.  First, glance at the environment to note that the linear model objects (e.g. pet.wid.len.set.lin.mod) are identified as lists.  So, we will first have to index the linear model object as a list.  

# Examining the first entry in the linear model object list.
pet.wid.len.set.lin.mod[[1]]

# We see that two numbers are presented, the first is the intercept, the second is the slope.  So, since we want the second number, we now index again using single square-brackets as the first list entry in the linear model list is itself a vector of two numbers.

# Examining the second entry of the first entry in the linear model object list (that is, the slope)

pet.wid.len.set.lin.mod[[1]][2]

# Saving this number to a variable name.

pet.wid.len.set.lin.mod.slope <- pet.wid.len.set.lin.mod[[1]][2]

# And repeating for the versicolor and virginica species.

pet.wid.len.ver.lin.mod.slope <- pet.wid.len.ver.lin.mod[[1]][2]
pet.wid.len.vir.lin.mod.slope <- pet.wid.len.vir.lin.mod[[1]][2]

# Now, we'll make a data.frame of slope values for streamlined use in ggplot (note that this is very similar to what we did with the legend of mean values at the start of today)

slopes <- data.frame("slope_values" = c(pet.wid.len.set.lin.mod.slope, pet.wid.len.ver.lin.mod.slope, pet.wid.len.vir.lin.mod.slope), "Species" = c("setosa", "versicolor", "virginica"))

# Now we can make the final ggplot object.  Note that I have chosen to specify the linetype of the fitted lines as a function of the species, and am using the function scale_linetype_discrete() to specify the linetypes as different slopes.

ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width, shape = Species, color = Species, linetype = Species))+
  geom_point()+
  stat_smooth(method = "lm")+
  scale_linetype_discrete(name = "Slope Values", labels = slopes$slope_values)

# Lastly, I'd rather not have quite so many significant digits in the reported slopes, especially since we only had at minimum 2 significant digits in the recorded data.  So, I will use the round() function to make the slopes adhere to significant digitery.  I will also add a title and axis labels to make the graph a bit more presentable.

ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width, shape = Species, color = Species, linetype = Species))+
  geom_point()+
  stat_smooth(method = "lm")+
  scale_linetype_discrete(name = "Slope Values", labels = round(x = slopes$slope_values, digits = 2))+
  labs(title = "Petal Width versus Petal Length for Three Flower Species", x = "Petal Length", y = "Petal Width")



##### Make a graph of the first two principle components of the track and field data (make sure to remove any na's in the dataset before you begin graphing)

# First let's set our working directory and read the decathlon data into R

setwd("/Users/alexwork/Desktop/collaboratory_R_workshop_062719/day3/")

decathlon <- read.table(file = "decathlon.txt", header = TRUE, sep = "\t", row.names = 1)

# Real quick, let's check that this data doesn't have any NaN values we need to deal with.

View(decathlon)
# We can see that a contestant named Brummer had some events that they did not compete in, and instead have NaN enties for those events.  So, let's remove Brummers scores from the overall file by re-reading the data into R using the na.strings parameter, and the na.omit function to remove the NA's.

decathlon <- read.table(file = "decathlon.txt", header = TRUE, sep = "\t", row.names = 1, na.strings = c("NaN"))
decathlon <- na.omit(decathlon)

# Now we can run our prcomp and ggbiplot functions to view the PCA for this data.  Note that we will only use rows 1-10 as rows 11, 12, and 13 are the ranking, score, and competition name for the data.

decath.pca <- prcomp(x = decathlon[,c(1:10)], center = TRUE, scale. = TRUE)
ggbiplot(decath.pca)

# We can see from the PCA that the running events tend to be positively correlated with each other (in particular the short distance sprints of X110m.hurdle and x100m), and the field events are also correlated with each other (in particular the javeline, discuss, and shot.put).  However, these two clusters point along different axes, so it is not quite the case that those who are good at short distance running are bad at throwing events.


#=========================================================================================
# Part End: Some Online Resources
#=========================================================================================

# Many examples of plotting
# http://www.sthda.com/english/wiki/be-awesome-in-ggplot2-a-practical-guide-to-be-highly-effective-r-software-and-data-visualization


# A handy webpage for picking well-informed color pallettes for your graphs.  These include color pallettes that are safe for greyscale conversion, ideal for diverging, categorical, or continuous data, and visible those living with color-blindness.
# http://colorbrewer2.org


# A repository of graphs in R
# https://www.r-graph-gallery.com/all-graphs/


# A good source for answers to questions.
# https://stackoverflow.com/


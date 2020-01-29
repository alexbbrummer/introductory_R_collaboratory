
#=========================================================================================
# Part 0: Recap - Functions
#=========================================================================================

# Let's write a function that takes data frames and will plot a histogram depending on whether or not one of the column names meets a criteria. In this case, the criteria is whether or not the first column name is "blue".


my_plotting_function <- function(dataframe = dataframe, plotname){
  ## This function takes as its argument a csv file and, if the column name of the first column is "blue", then it will print to file a histogram of the "blue" column.
  if(names(dataframe)[1] == "blue"){
    ggplot(data = dataframe, aes(x = blue))+
      geom_histogram(bins = 20)+
      labs(title = plotname)
  }
}

# Let's test our function on a sample file.  First, we need to change our directory to the data file directory

setwd("/Users/alexwork/odrive/Dropbox/Teaching/collaboratory_R_workshop/day3/data_files/")
test_file <- read.csv(file = "file_3.csv", header = TRUE)
my_plotting_function(dataframe = test_file, plotname = "test")

#### Modify the function we made to produce an xy scatter plot of the two columns in the csv file *if* the mean value of the first column is negative.

# Modifying the function, and giving it a new name so we don't override the first function.






# Let's real quick check that this function does what it should.
my_plotting_function2(dataframe = test_file, plotname = "Test plot")

# We have an error!  And it has to do with the mean() function.  Let's try just running mean(test_file[,1]) to see what happens.



# AHA!  We have NAs to handle!  Let's modify our function to handle NAs

# Let's try a case where the mean value is less than one.  That would be "file_4.csv".



#### Now, let's write a for loop to run through all the files in the directory and use our second function on each one.  print(my_plotting_function()),  dir()

for(i in 1:length(dir())){
    # Use the dir() function to access all of the file names in the directory, and index dir().
    loop_file <- read.csv(file = dir()[i], header = TRUE)
    # Also, because we are plotting within a loop, we need to use the print() function to "print" the graphs as output.
    print(my_plotting_function(dataframe = loop_file, plotname = i))
}

#### Breakout session to practice the above ideas:

#### Use the second function you made in a for loop to produce graphs for all data files that meet the negative mean value criteria.

# Let's first set the working directory.



#### Modify the for loop so that each graph is saved to file as a png in the "graphs" folder (not the data_files folder).  A function that you may find useful for doing this is the paste() function, which takes two character class arguments and merges them together.  For example, I can use the paste() function to merge "string" and "cheese" into "string_cheese" as

paste("string", "cheese", sep = "_")

# For this scenario we will use the png() and dev.off() functions.  However, we have to specify that the graphs are to be saved in the "graphs" folder.  But, we don't want to change directories from that which has our data.  This is where the paste() function comes in use, as we can use it to paste the new directory into the filename for the saved graphs.





#=========================================================================================
# Part 1: Density plots, Box plots, and Violin plots
#=========================================================================================

# We will be using the hawks data for this activity.  So lets read into RStudio our hawks day3 file.








#### Density plots ####

# Using a similar call to ggplot(), we will now use the geom_density() function to specify the type of graph we want to make out of our data.



#### Boxplots ####

# Using a similar call to ggplot(), we will plot the data as a bar plot instead of a histogram by using the geom_boxplot() function.





# However, we may yet still want to see more structure in the data.  What if our data is bi-modal (has two peaks instead of just one).  To do this, we can look at Violin plots.

#### Violin plots ####

# Violin plots are similar to density plots, only they have been rotated, stretched, mirrored, and placed as non-overlapping objects.





# But what if we still want to see the information for the distribution moments?  Let's add a boxplot to our violin plot.




# Cool idea, but it's a bit ugly.  Fortunately we can scale the sizes of our boxes.



# Don't forget about Histograms.



#=========================================================================================
# Part 2a: Some Stats Functions for 1D data
#=========================================================================================

## Finally, you might ask, "What about all those statistical tests?"

## Many statistical methods are already encoded into R.  We will highlight a few.


#### t-test on tail lengths between sharp shinned and cooper's hawk species.



## CAUTION, R does not check assumptions for you.  You must do that yourself!!!

# By assigning the results of the t.test() to a variable, you can access the results for later use.



#### ks test 



#### Anova.  Here we will focus on the sharp shinned hawks only to examine how the tail measurements depend on the categorical age and sex of the hawks.  To run an anova on the dataset we have, we need to install and load a special package called "car".  This is because our data set has unequal numbers of data for age and sex.




## Subsetting the data for just the sharp shinned hawks.



# Now, we will have to run our test in two steps.




#=========================================================================================
# Part 2b: Some Stats Functions for 2+D data
#=========================================================================================

#### Linear models (regression).  Suppose we want to fit a linear model to the tail versus wing relationship for the Sharp Shinned hawks, we use the lm() function (short for linear model).




##  We can also plot this linear model to our data using the stat_smooth() function with ggplot().



#### Clustering graphs

## Some of you may be interested in using automated methods for identifying clusters within your data.  One particular method of doing this is called k-means clustering.  In this approach, the data is divided into a given number of clusters, where the clusters are determined so as to minimize the euclidean distance from their centers to every point within the cluster.



# Now we will make a new column in the hawks data frame called tail.weight.cluster that is a factored vector of the cluster number from our clusters object.



# In this example, we already knew what that these clusters were associated with species and sex, however in other research you conduct the kmeans method may be an insightful way to explore your data and help guide your reasoning.



#### Principle Component Analysis

# Principle component analysis is a way of identifying which variables are responsible for the greatest amount of variation in your data.  In an abstract way, we take the axes that correspond to your original dataset, and we rotate them to point in new directions (consisting of linear combinations of your old dataset axes).

# To study it, we will use the two following packages: "FactoMineR" and "factoextra".




# Next, we will set the working directory for the Day 3 materials and read into R the mtcars.csv data set





# Uh oh, the cars object in our environment does not look like a data frame.  Let's look at the file we are trying to read and see what might have happened.

# The file format is .txt, let's google how to read .txt files into R



# Let's look at the data file.



# An NaN!  Let's re-run the read.delim function to read the NaN values as NA's.



# And now let's reassign the cars using the na.omit function to remove the bad row.



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



# Let's look at a summary of mtcars.pca



# What this information tells us is that most of the variance in the data (two-thirds) is "explained" by the first principle component.

# To help understand what this means, it is important to graph the results.  To do so, we will use a special package called "ggbiplot".  However, to download and install this package, we will need to point RStudio toward a github account using the install_github() function from the devtools library.



# Plotting our pca results.



# We can replace the points with labels using the labels parameter in the ggbiplot function.  For example, let's label each point with the make and mode for each car to get a better undertanding of which cars are sitting in this PC1-PC2 space.



# This is informative.  We see that sports cars, fuel-economy cars, and muscle cars are all pretty nicely grouped.  What if we want to examine grouping by country?  A nice additional feature is circling common groups (or factors) in the PCA plot.  To do this, we use the ellipsis and group parameters.



# This too is informative as we can now see manufacturing habits for these different nations.

# Maybe you want to look at the next two principle components.  To do so, we use the choice parameter to select the 3rd and 4th components.




#=========================================================================================
# Part 3: Writing a data frame to a file
#=========================================================================================

# Sometimes, after we edit a data frame that we have read into R, we want to write that data frame to file (save it as a spreadsheet).  To do so, we use the write.csv() funtion.

# Let's save a copy of the hawks.trim data frame as "hawks_trim.csv".

write.csv(x = hawks.trim, file = "hawks_trim.csv")

#=========================================================================================
# Part 4: Breakout session
#=========================================================================================

##### Produce the following sets of graphs with the Iris dataset.

#### A violin plot of petal width (on the vertical axis) and species (on the horizontal axis) and fill the violin colors by the species value (as we did for the hawks).


#### An xy scatter plot of petal width (on the vertical axis) versus petal length (on the horizontal axis) where the sybmols *and* the colors represent the species.


#### Add three fitted lines to the xy scatter plot you just made, one for each species.


#### *Challenge* Add another legend for the fitted lines that displays the values of the slopes for each line.  This is similar to the legend that displayed the mean values that we began tody with, however you will need to first get the slope for each fit.


##### Make a graph of the first two principle components of the track and field data (make sure to remove any na's in the dataset before you begin graphing)


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


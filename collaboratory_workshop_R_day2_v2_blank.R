#### Collaboratory Workshop - Introduction to Programming in R - Day 2/3 ####

# Welcome back for day 2 of the introduction to programming in R workshop!  Today we are going to focus on producing different kinds of graphs from yesterday, and learn about additional statistical tests that can be performed when analyzing our data.

#=========================================================================================
# Part 0: Recap
#=========================================================================================

# Begin by setting the working directory to the location of your workshop materials, and reading in the iris dataset for Day 2.

setwd("/Users/alexwork/odrive/Dropbox/Teaching/collaboratory_R_workshop/day2/")

## Read the iris.csv file into RStudio

iris <- read.csv(file = "iris.csv")

## Define new variables for each mean value.

ave.set.sep.wid <- mean(iris$Sepal.Width[which(iris$Species == "setosa")])
ave.ver.sep.wid <- mean(iris$Sepal.Width[which(iris$Species == "versicolor")])
ave.vir.sep.wid <- mean(iris$Sepal.Width[which(iris$Species == "virginica")])

# Define a new data frame for just these mean values.  To do this, we will use the data.frame() function to define the column names and column entries.

means <- data.frame("mean_values" = c(ave.set.sep.wid, ave.ver.sep.wid, ave.vir.sep.wid), "Species" = c("setosa", "versicolor", "virginica"))

## And now we can use one call to the geom_vline() function to add lines for each mean value.  Note that now we must specify "data = means" and "xintercept = mean_values".  Since we want all groups to have the same linetype and size, those parameters are specified outisde of the aes() function.

library(ggplot2)

ggplot(data = iris, aes(x=Sepal.Width, fill = Species))+
  geom_histogram(bins = 20, position = "identity", alpha = 0.5)+
  geom_vline(data = means, aes(xintercept = mean_values, color = Species), linetype = "dashed", size = 1)

## Now, let's add a few more details to the graph itself. First the title and axis lables using the labs() function.



## Next we'll modify the entries in the legend.  Note that, since we are using the "fill" parameter in the first call to aes() to factor the data, then we need to use the "fill" parameter else where when wanting to modify the legend.  To change the legend title, we will that with the scale_fill_discrete() function.




## Oops!  We forgot that we are also using the "color" parameter for the mean lines!  To do this, we use the scale_color_discrete() function.  While we are at it, let's use the mean values as the labels.




## Lastly, let's save our graph using the png() function.  The png() function allows us to produce a saved png() file.  Its parameters set the dimensions and resolution of the image.  When we are done adding elements to the plot, we must use the dev.off() function to tell R we are finished graphing.










##### Now, for the next 15-20 minutes, produce a similar graph as above but for the hawks_day2.csv file.  Use the variable "Tail" for your histogram data, and label the "Species Name" legend with the full species names (CH = Cooper's Hawk, RT = Red Tail, SS = Sharp Shinned), and present the mean values of the tails for each species in the legend as we did for the flowers, as well as vertical dashed lines demonstrating their values.  If you have time, feel free to edit titles, axis labels, etc.

## A hint.  Don't try to go straight to the final graph, as small missteps get compounded.  Instead, I suggest you start from the simpliest graph and work your way up.



#=========================================================================================
# Part 1: NA Handling, Negative Indexing, Defining Factors
#=========================================================================================
# Don't forget to look at your data.



# Uh on!  We have blank entries where someone didn't record that data!  What will we do?  Ideally, those cells would have "NA" in them for "not applicable".  R recognizes "NA" as a unique object, and we can filter our data based on it's presence.  For example, we can use the function is.na() to check if something is an 'NA" or not.



# Let's use a new parameter in the read.table() function to tag the empty cells as "NA"'s.



# Now let's filter the data by the NA cells.  Searching for all rows in which an "NA" exists will be annoying, because we have to search each column too.  Fortunately there exists a function to simply remove all rows with an NA in them, anywhere.  It is called na.omit().



# Now, let's re-examine the hawks graph that we ended yesterday with, only we will forgo the mean values.



# It looks like we have very few red tail hawks.  To see exactly how many, in addition to how many entries for all of our other variables, we'll use the summary() function.



# Now we can see we have only 4 red tail hawk entries in our data.  That's not very much, so let's just remove them all so we can more easily focus on only two species.  Here we will index by which species names equal RT



## Save those rows as an object, call it RT.rows



## Check to make sure that indexing by those rows gives us only the four RT hawk rows.



## Now, we learn that negative indexing gives us everything but the indeces we provided.



# Using negative indexing, we can redefine the hawks data frame and remove the RT.rows entirely.






# While we have removed red tails from the data, the species column is a factor that is still counting the red tails as a potential category.  To fix this, we will redefine the Species column as a factor, but we will specify the levels of the factor to not include red tails hawks.





# Great, now lets visualize our data once more.



#=========================================================================================
# Part 3: Graphing Two Continuous Variables, Logical 'and' and 'or'
#=========================================================================================

# So far we have examined ways to visualize and analyze one-dimensional variables at a time.  But, sometimes we are interested in two variables at once.  For example, what patterns might exists between the tail length of a hawk and the weight of the hawk?

# Examining the data graphically

# A common way to visualize two-dimensional data is an xy scatter plot.



# Well, what do we have here?  Some clustering and some trends!  Let's try to visually disect and identify the sources of the clustering and trends.  We can do this by using the aes() parameter in the geom_point() function.



# We could also color by the Age parameter.



### Now, if we wanted to make comparisons within these various groups, we need to use logicals (TRUE, FALSE) to index.  However, since we have multiple groupings (Age, Species, Sex), then we may need to perform multiple logical comparisons.  We do this using the statements for "and" (represented by the & symbol) and "or" (represented by the | symbol).

# Let's subset the Hawks data for female sharp-shinned hawks.





# Let's subset the Hawks data for either female or sharp-shinned hawks.





#=========================================================================================
# Part 3 Loops, If/else statements, and Functions
#=========================================================================================

## Loops
# Sometimes we may need to perform the same operations multiple times.  In these instances, it can be beneficial to know about loop structures.  Loops allow us to take a generalized procedure, and repeat until reaching some stopping condition.


# As an example, we will use a "for" loop to add the number two to every number in a vector of numbers that spans 1 to 10 by integer values, and save the result in a second vector.



# First make the vectors.



# The mat or vec function allows us to define an "empty" vector, or matrix, depending on the dimensions provided.



# And now the "for" loop.





# It is important to realize that some operations do not actually need a loop



# And sometimes using loops may actually be slower than using the built in functionality within R ("vectorized operations").  However, more complicated processes can still benefit from using loops (for example, looping through all of the files in a folder).



## If/Else statements
# Another important functionality are if/else statements.  These are logic based statements that allows us to perform certain operations as long specified conditions are met.  "If condition 1 is met, then perform condition 2, else do nothing or perform condition 3."  They typically are used as part of a more complicated procedure.

# As an example, let's suppose that all of the "setosa" sepal widths were accidentially measured in millimeters, and we need to convert them to centimeters.

# First we will loop through all of the rows of the iris data frame, and for each row we will use an "if" statement to check whether the species is "setosa", and if so, then we will divide the sepal width value by 10.



# Let's read the iris data file into RStudio.



# Now, again, you should realize that this operation can also be done without a loop, through the use of the which function, via the following.





## Functions
# In some instances, we may perform a complex task frequently enough that it would be beneficial to be able to define a function that performs the task entirely, and all we have to do is type the name of the function.

# Let's write a function that takes data frames and will plot a histogram depending on whether or not one of the column names meets a criteria. In this case, the criteria is whether or not the first column name is "blue".











#### Modify the function we made to produce an xy scatter plot of the two columns in the csv file *if* the mean value of the first column is negative.





# Let's test our function on a sample file.  First, we need to change our directory to the data file directory



# Great, it appears to work.

# Now, let's write a for loop to run through all the files in the directory and use our function on each one.




#=========================================================================================
# Part 4 Breakout session to practice days materials.
#=========================================================================================

## Now, for the rest of the day, practice these techniques on the following tasks.

#### Modify the function we made to produce an xy scatter plot of the two columns in the csv file *if* the mean value of the first column is negative.


#### Use the function in a for loop to produce graphs for all data files that meet the negative mean value criteria.



#### Modify the for loop so that each graph is saved to file as a png in the "graphs" folder (not the data_files folder).  A function that you may find useful for doing this is the paste() function, which takes two character class arguments and merges them together.  For example, I can use the paste() function to merge "string" and "cheese" into "string_cheese" as

paste("string", "cheese", sep = "_")

# For this scenario we will use the png() and dev.off() functions.  However, we have to specify that the graphs are to be saved in the "graphs" folder.  But, we don't want to change directories from that which has our data.  This is where the paste() function comes in use, as we can use it to paste the new directory into the filename for the saved graphs.




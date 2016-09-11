# Exercise 4: DPLYR and flights data

# Install the nycflights13 package and read it in.  Require the dplyr package
# install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data.frame flights should now be accessible to you.  View it, 
# and get some basic information about the number of rows/columns
View(flights)
dim(flights)
nrow(flights)
ncol(flights)
?flights

# Add a column that is the amount of time gained in the air
flights <- mutate(flights, gain = arr_delay - dep_delay)

# Sort your data.frame desceding by the column you just created
flights <- arrange(flights, desc(gain))

# Try doing the last 2 steps in a single operation using the pipe operator
flights <- flights %>% mutate(gain = arr_delay - dep_delay) %>% arrange(desc(gain))

# Make a histogram of the amount of gain using the `hist` command
hist(flights$gain)

# On average, did flights gain or lose time?
mean(flights$gain, na.rm = TRUE) # Lost 5 minutes!

# Create a data.frame of flights headed to seatac ('SEA'), 
# and only include the column you just created
to.sea <- flights %>% select(gain, dest) %>% filter(dest == 'SEA') 

# On average, did flights to seatac gain or loose time?
mean(to.sea$gain, na.rm = TRUE) # Lost 11 minutes!

OriginDestInterest <- function(my_origin, my_dest, interest) {
  ret <- flights %>% filter(origin == my_origin, dest == my_dest) %>% select_(interest)
  return(ret)
}

# Retireve the air_time column for flights from JFK to SEA
jfk.to.sea <- OriginDestInterest('JFK', 'SEA', 'air_time')

# What was the average air time of those flights (in hours)?  What was the min/max?
mean(jfk.to.sea$air_time, na.rm = TRUE)/60
min(jfk.to.sea$air_time, na.rm = TRUE)/60
max(jfk.to.sea$air_time, na.rm = TRUE)/60

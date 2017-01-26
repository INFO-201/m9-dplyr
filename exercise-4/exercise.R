# Exercise 4: DPLYR and flights data

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data.frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# use `??flights` to search for documentation on the data set (for what cols are)
nrow(flights)
ncol(flights)
colnames(flights)
?flights

# Use `dplyr` to give the data frame a new column that is the amount of time gained in the air
flights <- mutate(flights, gain = arr_delay - dep_delay)

# Use `dplyr` to sort your data.frame descending by the column you just created.
# Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, desc(gain))
View(head(flights))

# For practice, repeat the last 2 steps in a single statement using the pipe operator
flights <- flights %>% mutate(gain = arr_delay - dep_delay) %>% arrange(desc(gain))

# Make a histogram of the amount of gain using the `hist()` function
hist(flights$gain)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(flights$gain, na.rm = TRUE) # Lost 5 minutes!

# Create a data.frame of flights headed to seatac ('SEA'), only including the
# origin, destination, and the "gain" column you just created
to.sea <- flights %>% select(origin, dest, gain) %>% filter(dest == 'SEA')
to.sea

# On average, did flights to seatac gain or loose time?

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement!
# (and don't show any other data)
filter(flights, origin=="JFK", dest=="SEA") %>%
  summarize(
    average.air.time = mean(air_time, na.rm = TRUE),
    max.air.time = max(air_time, na.rm = TRUE),
    min.air.time = min(air_time, na.rm = TRUE)
  )

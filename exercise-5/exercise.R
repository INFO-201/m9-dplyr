# Exercise 5: DPLYR Grouped Operations

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library(nycflights13)
library(dplyr)

# What was the average department delay in each month?
# Save this as a data frame `dep.delay.by.month`
# Hint: you'll have to perform a grouping operation before summarizing your data
dep.delay.by.month <- flights %>%
  group_by(month) %>%
  summarize(delay = mean(dep_delay, na.rm=TRUE))
dep.delay.by.month

# Which month had the greatest average departure delay?
filter(dep.delay.by.month, delay == max(delay))

# If your above data frame contains the columns "month", and "delay", you can create
# a scatterplot by passing that data frame to the 'plot()' function
plot(dep.delay.by.month)

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation before summarizing your data
arr.delay.by.month <- flights %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm=TRUE)) %>%
  arrange(-delay)
arr.delay.by.month

# You can look up these airports in the `airports` data frame!
filter(airports, faa == arr.delay.by.month$dest[1])  # e.g.

### Bonus ###
# Which city was flown to with the highest average speed?
city.by.speed <- flights %>%
  mutate(speed = distance/air_time * 60) %>%
  group_by(dest) %>%
  summarise(avg_speed = mean(speed, na.rm = TRUE)) %>%
  arrange(-avg_speed)
city.by.speed

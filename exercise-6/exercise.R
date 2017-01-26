# Exercise 6: DPLYR join introduction

# Install the nycflights13 package and read it in. Require the dplyr package.
# install.packages("nycflights13")



# Create a dataframe of the average arrival delay for each destination, then use `left_join()`
# to join on the "airports" dataframe, which has the airport info
avg.arrival.delay <- flights %>%
  group_by(dest) %>%
  summarise(avg.delay = mean(arr_delay, na.rm = TRUE)) %>%
  mutate(faa = dest) %>%
  left_join(airports, by = 'faa') %>%
  arrange(-avg.delay)

# Create a dataframe of the average arrival delay for each airline, then use `left_join()``
# to join on the "airlines" dataframe, which has the airline info
avg.airline.delay <- flights %>%
  group_by(carrier) %>%
  summarise(avg.delay = mean(arr_delay, na.rm=TRUE)) %>%
  left_join(airlines, by='carrier') %>%
  arrange(-avg.delay)

### Bonus ###
# Calculate the average delay by city AND airline, then merge on the city and airline information
avg_city_airline <- flights %>%
  group_by(dest, carrier) %>%
  summarise(avg.delay = mean(arr_delay, na.rm=TRUE)) %>%
  left_join(airlines, by='carrier') %>%
  mutate(faa = dest) %>%
  left_join(airports, by = 'faa') %>%
  left_join(airlines, by='carrier') %>%
  ungroup() %>%
  arrange(-avg.delay)

# If you're running into sorting issues:
# http://stackoverflow.com/questions/26555297/dplyr-arrange-a-grouped-df-by-group-variable-not-working

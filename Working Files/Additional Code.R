
# ------------------------------------------------------------------------------
#                                   OVERVIEW
# ------------------------------------------------------------------------------

# First 6 values for all columns
head(bike_usage)

# All columns horizontally spread
glimpse(bike_usage)

# All columns horizontally spread
str(bike_usage)

# Data Summary / Column Types / Variable Types
skim_without_charts(bike_usage)

# Describe (Hmisc Library)
describe(bike_usage_names)

# ------------------------------------------------------------------------------
#                                    ANALYSIS
# ------------------------------------------------------------------------------

# Calculate mean
mean(bike_usage$compteur_100003034, na.rm = TRUE)

# Part of Hmisc library. Detailed description
describe(bike_usage_names$`Berri No.1`)

#                                                               DATE AJUSTMENTS
# -----------------------------------------------------------------------------

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# Change date column stored as string into its POSIXct format
date_temp <- as.POSIXct(bike_usage$Date, tz = "EST")

# Confirm the change
min(date_temp)


str(bike_counters)

# Select columns from one dataframe, and store it in another
counter_names <- bike_counters %>% select(Data_Code, Name)


# Write a CSV to be able to work with in Tableau maybe?
write.csv(velo_db, "velo_database.csv")

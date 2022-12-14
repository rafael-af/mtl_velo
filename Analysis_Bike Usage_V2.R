#
#                                 USEFUL TOOLS
# ------------------------------------------------------------------------------

# working_dir <- "C:/Users/Raf/Desktop/Data/Projects/Montreal Case Study"
working_dir <- 
  "C:/Users/Raf/Desktop/Data/Projects/Montreal Case Study/GitHub/mtl_velo"

# Set working directory at the beginning of a session
setwd(working_dir)

# ------------------------------------------------------------------------------
#                                   LIBRARIES
# ------------------------------------------------------------------------------

load_libraries()

# ------------------------------------------------------------------------------
#                               STEPS OF THE PROCESS
# ------------------------------------------------------------------------------

# 1.   Install Packages (Run function)
# 2.   Load Data from MySQL
# 3.   Load Functions to be used
# 4.   Create bike_usage_names table in the Transform section
# 5.   Transform string date to POSlx Datetime and add column
# 6.   Derive the different time columns: year, month, day, hour, minute
# 7.   Rearrange columns so Dates are at the beginning


# ------------------------------------------------------------------------------
#                             LOAD DATA FROM MySQL
# ------------------------------------------------------------------------------

# Load data from database(montreal_velo) / table(velo_complete)
bike_usage <- load_data_from_db("montreal_velo", "velo_complete")

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


# ------------------------------------------------------------------------------
#                                   TRANSFORM
# ------------------------------------------------------------------------------

#                                                              RENAMING COLUMNS 
# -----------------------------------------------------------------------------
#                                     Rename the columns to their readable name

# Rename the columns in df using the corresponding values in the Name column 
# of key_table

bike_usage_names <- bike_usage %>% rename_at(vars(
                    compteur_100003034, compteur_100003039, compteur_100057500, 
                    compteur_100004575, compteur_100003032, compteur_100003040, 
                    compteur_100003041, compteur_100003042, compteur_100002880, 
                    compteur_100007390, compteur_100011747, compteur_100011748, 
                    compteur_100011783, compteur_100012217, compteur_100012218, 
                    compteur_100017441, compteur_100001753, compteur_100047030, 
                    compteur_100017523, compteur_38, compteur_39, 
                    compteur_100025474, compteur_100034805, compteur_100035408, 
                    compteur_100035409, compteur_100041101, compteur_100041114, 
                    compteur_100052600, compteur_100052601, compteur_100052602, 
                    compteur_100052603, compteur_100052604, compteur_100052605, 
                    compteur_100052606, compteur_100053055, compteur_100053057, 
                    compteur_100053058, compteur_100053059, compteur_100053210, 
                    compteur_100054073, compteur_100056188, compteur_100057050, 
                    compteur_100057051, compteur_100057052, compteur_100057053, 
                    compteur_100053209, compteur_100054585, compteur_100055268, 
                    compteur_100054241, compteur_300014993, compteur_300014986, 
                    compteur_300014985, compteur_300014995, compteur_300014996, 
                    compteur_300014916, compteur_300014994, compteur_300020478
                  ),
                  list(~bike_counters$Name[match(., bike_counters$Data_Code)]))


# Confirm change
colnames(bike_usage_names)

# Summary
# bike_usage_names goes through transform first
summary(bike_usage_names)

# Part of Hmisc library. Detailed description
describe(bike_usage_names$`Berri No.1`)


#                                                               DATE AJUSTMENTS
# -----------------------------------------------------------------------------

# DATETIME String to Year, Month, Day, Time columns -GPT

# Convert the datetime strings to POSIXct objects
bike_usage_names$Datetime <- strptime(
                                  bike_usage$Date, format = "%Y-%m-%d %H:%M:%S")

# Split the datetime column into separate year, month, day, and time columns
bike_usage_names$year <- year(bike_usage_names$Datetime)
bike_usage_names$month <- month(bike_usage_names$Datetime)
bike_usage_names$day <- day(bike_usage_names$Datetime)
bike_usage_names$hour <- hour(bike_usage_names$Datetime)
bike_usage_names$minute <- minute(bike_usage_names$Datetime)

# Confirm changes
head(bike_usage_names)
str(bike_usage_names)

describe(bike_usage_names$minute)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# Change date column stored as string into its POSIXct format
date_temp <- as.POSIXct(bike_usage$Date, tz = "EST")

# Confirm the change
min(date_temp)


str(bike_counters)

# Select columns from one dataframe, and store it in another
counter_names <- bike_counters %>% select(Data_Code, Name)



#                                                           REARRANGING COLUMNS 
# -----------------------------------------------------------------------------
#                                            Reorder the columns in a dataframe

# Rearrange columns in dataframe // Data starts in column 7
bike_usage_names_reordered <- select(bike_usage_names, 60:65, 3:59, 1:2)

head(bike_usage_names_reordered)

# ------------------------------------------------------------------------------
#                                   CHECKPOINT
# ------------------------------------------------------------------------------

# create a copy of the bike_usage_names dataframe
velo_db <- bike_usage_names_reordered

# Store velo_db in MySQL to make it easier to retrieve checkpoint
dbWriteTable(mysqlconnection, "velo_database", velo_db, overwrite = TRUE)

# Write a CSV to be able to work with in Tableau maybe?
write.csv(velo_db, "velo_database.csv")

str(velo_db)

# ------------------------------------------------------------------------------
#                               TRANSFORMING DATA
# ------------------------------------------------------------------------------


# Structure
str(velo_db)

# Transform all char columns to int
velo_db <- column_to_int(velo_db, c(3:62))

# Rearrange columns to have time, year, month first. Then all other data.
velo_db <- select(velo_db, 60:62, 3:59)

# Data Summary / Column Types / Variable Types
skim_without_charts(velo_db)



# ------------------------------------------------------------------------------
#                     PARC - UNIVERSITY - MAISONNEUVE / PEEL
# ------------------------------------------------------------------------------
# Create a subset
velo_university <- select(velo_db, Datetime,
                        year,
                        month,
                        `University / Milton`, 
                        `Maisonneuve / Peel`,
                        `Parc / Duluth`)

# Check structure
str(velo_university)

# Get the names of all columns in the data frame
column_names <- names(velo_university)
column_names

# Identify rows where not all locations have NA values
clean_uni <- subset(velo_university, complete.cases(velo_university[, 
                                                        column_names[4:6]]))

# Summarize
summary(clean_uni)
# Check structure
str(clean_uni)

# Quick glimpse of NAs per column
sum(is.na(clean_uni$Datetime))

# Clean NAs from subset
clean_uni <- na.omit(velo_university)

# Check structure
str(clean_uni)

# Look at range
min(clean_uni$Datetime)
max(clean_uni$Datetime)

# Choose Date range for graph
filtered_uni <- date_window(clean_uni, 2019, 2022)
str(filtered_uni)

#                                                          PLOTTING THE DATA NOW
# ------------------------------------------------------------------------------

# create generic df to work with
df <- filtered_uni

# Summarize_at with list() instead of funs()
df2 <- df %>%
  group_by(year, month) %>%
  summarize_at(colnames(select(df, 4:6)), list(sum))

# Confirm structure
str(df2)

# Convert the dataframe to long format
df3 <- melt(df2, id.vars = c("year", "month"), measure.vars = names(df2)[3:5])

# Create a line plot of the sums for each location over time
ggplot(df3, aes(x = as.Date(paste(year, month, "01", sep = "-")), 
                y = value, color = variable)) +
      geom_line(size=1.1)+
      scale_x_date(date_labels="%b, %y",date_breaks="1 month") +
      scale_y_continuous(labels = label_number(suffix = "mil", scale = 1e-3)) +
      labs(title = "Bicycle Usage in Montreal",
           x = "Year",
           y = "Total Count",
           color = "Month") +
      theme(axis.text.x = element_text(angle = 30, hjust = 1))


# ------------------------------------------------------------------------------
#                              MOUNTAIN BIKE PATH
# ------------------------------------------------------------------------------

# Create a subset
velo_mountain <- select(velo_db, Datetime,
                                 year,
                                 month,
                                `Remembrance`, 
                                `Camillien-Houde No.1`,
                                `Parc / Duluth`)


# Check structure
str(velo_mountain)

# Get the names of all columns in the data frame
column_names <- names(velo_mountain)
column_names

# Clean NAs from subset - USING ALTERNATIVE
velo_mountain_clean <- na.omit(velo_mountain)

# Identify rows where not all locations have NA values
clean_mountain <- subset(velo_mountain, 
                         complete.cases(velo_mountain[, column_names[4:6]]))

# Identify rows where not all values in the specified range of columns are NA
clean_mountain <- velo_mountain[which(!rowSums(is.na(
                                  velo_mountain[, column_names[4:6]])) == 3), ]

# Check structure
str(clean_mountain)

# Look at range
min(velo_mountain_clean$Datetime)
max(velo_mountain_clean$Datetime)

c(1, NA, 2, NA, 3)
sum(is.na(c(1, NA, 2, NA, 3))) == 2

#                                                          PLOTTING THE DATA NOW
# ------------------------------------------------------------------------------

# create generic df to work with
df <- clean_mountain

# Summarize_at with list() instead of funs()
df2 <- df %>%
  group_by(year, month) %>%
  summarize_at(colnames(select(df, 4:6)), list(sum))

# Confirm structure
str(df2)

# Convert the dataframe to long format
df3 <- melt(df2, id.vars = c("year", "month"), measure.vars = names(df2)[3:5])

# Create a line plot of the sums for each location over time
ggplot(df3, aes(x = as.Date(paste(year, month, "01", sep = "-")), 
                y = value, color = variable)) +
      geom_line(size=1.1)+
      scale_x_date(date_labels="%b, %y",date_breaks="1 month") +
      scale_y_continuous(labels = label_number(suffix = "mil", scale = 1e-3)) +
      labs(title = "Bicycle Usage in Montreal",
           x = "Year",
           y = "Total Count",
           color = "Month") +
      theme(axis.text.x = element_text(angle = 30, hjust = 1))


# ------------------------------------------------------------------------------
#                                PLOTTING DATA
# ------------------------------------------------------------------------------

# create generic df to work with
df <- velo_db

# troubleshooting
head(df)
colnames(df)
str(df)

# Data Summary / Column Types / Variable Types
skim_without_charts(velo_db)

# Summarize_at with list() instead of funs()
df2 <- df %>%
  group_by(year, month) %>%
  summarize_at(colnames(select(df, 4:60)), list(sum))

str(df2)

# Convert the dataframe to long format
df3 <- melt(df2, id.vars = c("year", "month"), measure.vars = names(df2)[4:59])

# Take a look at how it did it
glimpse(df3)

# Create a line plot of the sums for each location over time
ggplot(df3, aes(x = as.Date(paste(year, month, "01", sep = "-")), y = value, color = variable)) +
  geom_line()+
  scale_y_continuous(labels = label_number(suffix = "mil", scale = 1e-3)) + # thousands
  labs(title = "Bicycle Usage in Montreal",
       x = "Year",
       y = "Total Count",
       color = "Month")


# Create a line plot of the sums for each location over time
ggplot(df3, aes(y = value, color = variable)) +
  geom_bar()+
  scale_y_continuous(labels = label_number(suffix = " T", scale = 1e-3)) + # thousands
  labs(title = "Bicycle Usage in Montreal",
       x = "Year",
       y = "Total Count",
       color = "Month")




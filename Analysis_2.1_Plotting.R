#
#                                   USEFUL TOOLS
# ------------------------------------------------------------------------------

# working_dir <- "C:/Users/Raf/Desktop/Data/Projects/Montreal Case Study"
working_dir <- 
  "C:/Users/Raf/Desktop/Data/Projects/Montreal Case Study/GitHub/mtl_velo"

# Set working directory at the beginning of a session
setwd(working_dir)

# ------------------------------------------------------------------------------
#                                STEPS OF THE PROCESS
# ------------------------------------------------------------------------------

# 0.   Install Helper function
# 1.   Install Packages (Run function)
# 2.   Load Data from MySQL // Pick up from Checkpoint



# ------------------------------------------------------------------------------
#                                 HELPER FUNCTION                            / 0
# ------------------------------------------------------------------------------

# This function will help run any scripts that may be necessary at the beginning 
# of the process
runScript <- function(scriptName) {
  source(scriptName)
}

# ------------------------------------------------------------------------------
#                                   LIBRARIES                                / 1
# ------------------------------------------------------------------------------

# Run the functions script first
runScript('Script_Functions_V1.R')  

# Function is now available
load_libraries()

# ------------------------------------------------------------------------------
#                              LOAD DATA FROM MySQL                          / 2
# ------------------------------------------------------------------------------

# Load data from database(montreal_velo) / table(velo_database)
velo_db <- load_data_from_db("montreal_velo", "velo_database")

# Loading bicycle counter names
bike_counters <- load_data_from_db("montreal_velo", "bicycle_counter_names")


# ------------------------------------------------------------------------------
#                                RESTARTING POINT                            / 8
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
#                               TRANSFORMING DATA
# ------------------------------------------------------------------------------

# Structure
str(velo_db)

# Transform all char columns to int
velo_db <- column_to_int(velo_db, c(7:63))

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
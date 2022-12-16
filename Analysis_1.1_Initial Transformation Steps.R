#
#                                 USEFUL TOOLS
# ------------------------------------------------------------------------------

# working_dir <- "C:/Users/Raf/Desktop/Data/Projects/Montreal Case Study"
working_dir <- 
  "C:/Users/Raf/Desktop/Data/Projects/Montreal Case Study/GitHub/mtl_velo"

# Set working directory at the beginning of a session
setwd(working_dir)

# ------------------------------------------------------------------------------
#                               STEPS OF THE PROCESS
# ------------------------------------------------------------------------------

# 0.   Install Helper function
# 1.   Install Packages (Run function)
# 2.   Load Data from MySQL
# 3.   Create bike_usage_names table in the Transform section
# 4.   Transform string date to POSlx Datetime and add column
# 5.   Derive the different time columns: year, month, day, hour, minute
# 6.   Rearrange columns so Dates are at the beginning
# ----------------------------------------------------------------------
# 7.   CHECKPOINT No. 1
#      
#      Export table into MySQL database for later use
#      Save as a CSV for redundancy / Tableau export
# ----------------------------------------------------------------------
# 8.   RESTARTING POINT
#
#      Pick up where you left off
# ----------------------------------------------------------------------


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
#                             LOAD DATA FROM MySQL                           / 2
# ------------------------------------------------------------------------------

# Load data from database(montreal_velo) / table(velo_complete)
bike_usage <- load_data_from_db("montreal_velo", "velo_complete")

# Loading bicycle counter names
bike_counters <- load_data_from_db("montreal_velo", "bicycle_counter_names")

# ------------------------------------------------------------------------------
#                                   TRANSFORM                                / 3
# ------------------------------------------------------------------------------


#                                                              RENAMING COLUMNS 
# -----------------------------------------------------------------------------

# Rename the columns in df using the corresponding values in the Name column 
# of key_table / readable name

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

# DATETIME String to Year, Month, Day, Time columns -GPT                     / 4

# Convert the datetime strings to POSIXct objects
bike_usage_names$Datetime <- strptime(
                                  bike_usage$Date, format = "%Y-%m-%d %H:%M:%S")

# Split the datetime column into separate columns                            / 5
# year, month, day, and time columns
bike_usage_names$year <- year(bike_usage_names$Datetime)
bike_usage_names$month <- month(bike_usage_names$Datetime)
bike_usage_names$day <- day(bike_usage_names$Datetime)
bike_usage_names$hour <- hour(bike_usage_names$Datetime)
bike_usage_names$minute <- minute(bike_usage_names$Datetime)

# Confirm changes
head(bike_usage_names)
str(bike_usage_names)

describe(bike_usage_names$minute)

#                                                           REARRANGING COLUMNS 
# -----------------------------------------------------------------------------
#                                            Reorder the columns in a dataframe

# Rearrange columns in dataframe // Data starts in column 7                  / 6
bike_usage_names_reordered <- select(bike_usage_names, 60:65, 3:59, 1:2)

head(bike_usage_names_reordered)

# ------------------------------------------------------------------------------
#                                   CHECKPOINT
# ------------------------------------------------------------------------------

# create a copy of the bike_usage_names dataframe                            / 7
velo_db <- bike_usage_names_reordered

# Store velo_db in MySQL to make it easier to retrieve checkpoint
dbWriteTable(mysqlconnection, "velo_database", velo_db, overwrite = TRUE)

# Use this function to export out of repository
exportCSVout(velo_db, "velo_database.csv")

# Confirm structure of final state dataframe
str(velo_db)




# DATABASE CONNECTION

#                                   USEFUL TOOLS
# ------------------------------------------------------------------------------

# Set working directory at the beginning of a session

# New working directory when working with GitHub repositories
working_dir <- 
  "C:/Users/Raf/Desktop/Data/Projects/Montreal Case Study/GitHub/mtl_velo"

setwd(working_dir)


# ------------------------------------------------------------------------------
#                                   CONNECTIONS
# ------------------------------------------------------------------------------

# Load the required packages
library(DBI)
library(RMySQL)


# Connect to MySQL database
mysqlconnection = dbConnect(RMySQL::MySQL(),
                            dbname='montreal_velo',
                            host='localhost',
                            port=3306,
                            user='working',
                            password='Working$',
                            local_infile = 1)


# displays the tables available in this database.
dbListTables(mysqlconnection)


# Retrieve data from different tables in Database
# -----------------------------------------------
# VELO_COMPLETE
result <- dbSendQuery(mysqlconnection, "select * from velo_complete")
bike_usage <- fetch(result, n=-1)

# BICYCLE_COUNTER_NAMES
result <- dbSendQuery(mysqlconnection, "select * from bicycle_counter_names")
bike_counters <- fetch(result, n=-1)

# Confirm results
head(bike_usage)

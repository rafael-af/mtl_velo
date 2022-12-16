# ------------------------------------------------------------------------------
#                                FUNCTIONS
# ------------------------------------------------------------------------------

load_data_from_db <- function(db_name, db_table) {

  # Load the required packages
  library(DBI)
  library(RMySQL)
  
  # Connect to MySQL database
  mysqlconnection = dbConnect(RMySQL::MySQL(),
                              dbname=db_name,
                              host='localhost',
                              port=3306,
                              user='working',
                              password='Working$',
                              local_infile = 1)
  
  # Select * From db_table
  result <- dbSendQuery(mysqlconnection, paste0("select * from ", db_table))
  
  # Return the fetch result
  fetch(result, n=-1)

}

#                                                                 COLUMNS TO INT
# ------------------------------------------------------------------------------


column_to_int <- function(data, range) {
  # Get the names of the columns in the dataframe
  col_names <- names(data)
  
  # Loop through the columns in the specified range
  for (col in col_names[range]) {
    # Check if the column has a char type
    if (is.character(data[[col]])) {
      # Convert the column to an integer type
      data[[col]] <- as.integer(data[[col]])
    }
  }
  
  # Return the transformed dataframe
  return(data)
}

#                                                                 LOAD LIBRARIES
# ------------------------------------------------------------------------------

load_libraries <- function() {
  # Shortcut
  install.packages(c("tidyverse", "ggplot2", "skimr", "lubridate"))
  library(tidyverse)
  library(ggplot2)
  library(skimr)
  library(lubridate)
  
  # Flexibly restructure and aggregate data using just two functions: 
  # melt and 'dcast' (or 'acast').
  # ------------------------------
  install.packages("reshape2")
  library(reshape2)
  
  # Harrell Miscellaneous
  install.packages("Hmisc")
  library(Hmisc)
  
  # Scales
  install.packages("scales")
  library(scales)
  
  # GitHub
  # The following object is masked from ‘package:RMySQL’: -> fetch
  # The following object is masked from ‘package:DBI’: -> fetch
  install.packages("git2r")
  library(git2r)
  
  install.packages("gitcreds")
  library(gitcreds)
  
  install.packages("credentials")
  library(credentials)
  
  install.packages("esquisse")
  library(esquisse)
}

#                                                                    DATE WINDOW
# ------------------------------------------------------------------------------

# Subset dataframe between two years
date_window <- function(data, start_date, end_date) {
  
  # Create a subset between the two years
  subset <- data[data$year >= start_date & data$year <= end_date,]
  
  return(subset)
}

#                                                  EXPORT CSV OUTSIDE REPOSITORY
# ------------------------------------------------------------------------------

# Exports a CSV file, outside the working directory to a folder called Exports
exportCSVout <- function(data, fileName) {
  
  filePath <- file.path("..", "Exports", fileName)
  write.csv(data, file = filePath, row.names = FALSE)

}
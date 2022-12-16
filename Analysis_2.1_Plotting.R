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
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
# 2.   Load Data from MySQL


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
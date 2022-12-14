# ------------------------------------------------------------------------------
#                               STEPS OF THE PROCESS
# ------------------------------------------------------------------------------

# Set the PAT credentials for GitHub
# PAT (expires Feb 2023)
gitcreds::gitcreds_set()
credentials::set_github_pat()


# In order for Git to make sense, I think I should be working in the directory
# I just created.

# Initialize a new Git repository in your current working directory by running 
# the following command:

repo <- init(path = ".", bare = FALSE)
repo <- git2r::repository("http://github.com/rafael-af/R-Test")
git2r::repository()

# Cloning a repository
# It seems cloning works when repository doesn't.

git2r::clone(repo, working_dir)

clone_dir <- "C:/Users/Raf/Desktop/Data/Projects/Montreal Case Study/test_dir"
clone_dir

repo <- git2r::clone(url = "http://github.com/rafael-af/R-Test", clone_dir)

# Add your GitHub account credentials to the repository by running the 
# following commands:
cred <- git2r::cred_ssh_key("C:/.ssh/ls.pub", "C:/.ssh/ls", "")

config(repo, global = FALSE, user.name = "rafael-af", 
       user.email = "rafaelarriaga.f@gmail.com", 
       cred)

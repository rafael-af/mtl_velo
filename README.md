# mtl_velo
Velo DB Analysis - V1

This is my first attempt at working in a GitHub repository, so things may be a bit messy.

I'll describe here what the purpose of this project is, and the steps I'm taking to get there.

BEGINNING
---------

It all started with datasets of bike usage in Montreal from 2009 all the way to the present.

I cleaned these datasets in Excel in order to bring them into a local MySQL database. Once they were in the database, I had to take a step back to correct a couple things that would make merging these files more challenging than it needed to be.

Once these 13 CSV files had the same structure (column names), and all empty cells were replaced with NULLs, they were ready to go back into MySQL. Once there, I UNION ALL of them into one main database called velo_complete.

WORKING IN R
------------

Now that the data was all in one place, it was ready to be brought into R to clean and put it into a format that worked better. All column names where changed to reader-friendly names, dates were transformed from strings into their individual components (year, month, day, hour, minute), as well as included a POSlx column to make it easier to work with it in R. 

With the help of ChatGPT, I put together a function to help me transform all the NULL columns that were considered text columns into INT so that they wouldn't cause weird errors further in the processing.



NOTES
------------

Also, this seems to be a better place to include this information. I found someone online suggesting this fix below in case you simplify the process when working with SSH authentication. In my case, I've reverted to PAT, so this probably won't be necessary.

SSH Use Case
------------
git config --global --add url."git@github.com:".insteadOf "https://github.com/"


To be continued: 
---------------
Next is working on visualizing the data and testing different tools to achieve it. I'll be trying plotly next.
#Initialize Your Package Skeleton
library(devtools)
create("Friedman")

#Edit the DESCRIPTION File

#Verify and Build
check("Friedman")
build("Friedman")

#Output of build:
#── R CMD build ─────────────────────────────────────────────────
#✔  checking for file ‘/Users/meganxiao/Desktop/USF/Fall 2025/LIS4370 R Programming/R Programming Assignments/Friedman/DESCRIPTION’ ...
#─  preparing ‘Cleaner’:
#  ✔  checking DESCRIPTION meta-information ...
#─  checking for LF line-endings in source and make files and shell scripts
#─  checking for empty or unneeded directories
#Removed empty directory ‘Cleaner/R’
#Removed empty directory ‘Cleaner/man’
#─  building ‘Cleaner_0.0.0.9000.tar.gz’

#[1] "/Users/meganxiao/Desktop/USF/Fall 2025/LIS4370 R Programming/R Programming Assignments/Cleaner_0.0.0.9000.tar.gz"
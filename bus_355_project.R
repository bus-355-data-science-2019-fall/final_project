# packages
library(readxl)

# Import data -----
col_descriptions <- read_excel("~/Downloads/ClassData1.xlsx", sheet = "Column Descriptions")
project_data <- read_excel("~/Downloads/ClassData1.xlsx")
View(project_data)
View(col_descriptions)
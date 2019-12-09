# packages
library(readxl)

# Import data -----
col_descriptions <- read_excel("data/ClassData1.xlsx", sheet = "Column Descriptions")
project_data <- read_excel("data/ClassData1.xlsx")
View(project_data)
View(col_descriptions)

ProjectDataCalc <- ProjectDataCalc %>% 
  mutate(IG = )

library(dplyr)
ProjectDataCalc <- project_data %>%
  mutate(UISOnC = (.[[5]] +.[[6]] +.[[13]] + .[[15]]))%>%
  mutate(UOSOnC = (.[[7]] +.[[8]] +.[[13]] + .[[15]]))%>%
  mutate(UISOffC = (.[[5]] +.[[6]] +.[[13]] + .[[14]]))%>%
  mutate(UOSOffC = (.[[7]] +.[[8]] +.[[13]] + .[[14]]))%>%
  mutate(GISOnC = (.[[9]] +.[[10]] +.[[13]] + .[[15]]))%>%
  mutate(GOSOnC = (.[[11]] +.[[12]] +.[[13]] + .[[15]]))%>%
  mutate(GISOffC = (.[[9]] +.[[10]] +.[[13]] + .[[14]]))%>%
  mutate(GOSOffC = (.[[11]] +.[[12]] +.[[13]] + .[[14]]))


mult <- (.[[18]]/ .[[20]]))
if(mult >= .75 mutate(TCA = (YCA * 4)) else(TCA = (YCA * 6))


  
# packages
library(readxl)
library(dplyr)

# Import data -----
col_descriptions <- read_excel("data/ClassData1.xlsx", sheet = "Column Descriptions")
project_data <- read_excel("data/ClassData1.xlsx")
View(project_data)
View(col_descriptions)


# sum calculations -----
ProjectDataCalc <- project_data %>%
  mutate(UISOnC = (.[[5]] +.[[6]] +.[[13]] + .[[15]]))%>%
  mutate(UOSOnC = (.[[7]] +.[[8]] +.[[13]] + .[[15]]))%>%
  mutate(UISOffC = (.[[5]] +.[[6]] +.[[13]] + .[[14]]))%>%
  mutate(UOSOffC = (.[[7]] +.[[8]] +.[[13]] + .[[14]]))%>%
  mutate(GISOnC = (.[[9]] +.[[10]] +.[[13]] + .[[15]]))%>%
  mutate(GOSOnC = (.[[11]] +.[[12]] +.[[13]] + .[[15]]))%>%
  mutate(GISOffC = (.[[9]] +.[[10]] +.[[13]] + .[[14]]))%>%
  mutate(GOSOffC = (.[[11]] +.[[12]] +.[[13]] + .[[14]]))

# IG calculation ----
ProjectDataCalc <- ProjectDataCalc %>% 
  mutate(IG = ((.[[16]]/100)*.[[17]]))

# YCA
YCA_calc <- ProjectDataCalc %>%
  mutate(IG_UISOnC = UISOnC - IG) %>%
  mutate(IG_UOSOnC = UOSOnC - IG) %>%
  mutate(IG_UISOffC = UISOffC - IG) %>%
  mutate(IG_UOSOffC = UOSOffC - IG) %>%
  mutate(IG_GISOnC = GISOnC - IG) %>%
  mutate(IG_GOSOnC = GOSOnC - IG) %>%
  mutate(IG_GISOffC = GISOffC - IG) %>%
  mutate(IG_GOSOffC = GOSOffC - IG) %>%

# multiplier (# of years) calculation ----
mutate(Year_calc = (.[[18]]/.[[20]])) %>%
mutate(Ugrad_Mult = ifelse(Year_calc >= .75, 4, 6))

# TCA calculation ----
TCA_Calc <- YCA_calc %>%
  mutate(TCA_IG_UISOnC = (IG_UISOnC * Ugrad_Mult)) %>%
  mutate(TCA_IG_UOSOnC = (IG_UOSOnC * Ugrad_Mult)) %>%
  mutate(TCA_IG_UISOffC = (IG_UISOffC * Ugrad_Mult)) %>%
  mutate(TCA_IG_UOSOffC = (IG_UOSOffC * Ugrad_Mult)) %>%
  mutate(TCA_UISOnC = (UISOnC * Ugrad_Mult)) %>%
  mutate(TCA_UOSOnC = (UOSOnC * Ugrad_Mult)) %>%
  mutate(TCA_UISOffC = (UISOffC * Ugrad_Mult)) %>%
  mutate(TCA_UOSOffC = (UOSOffC * Ugrad_Mult))
#Filta Stuff%
TCA_Cheapest <- head(arrange(TCA_Calc, TCA_UISOffC)) 
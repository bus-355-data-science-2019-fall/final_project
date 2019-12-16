# packages
library(readxl)
library(dplyr)

# Import data -----
col_descriptions <- read_excel("data/ClassData1.xlsx", sheet = "Column Descriptions") 
project_data <- read_excel("data/ClassData1.xlsx")
#View(project_data)
#View(col_descriptions)


# sum calculations -----
ProjectDataCalc <- project_data %>%
  mutate(UISOnC = (.[[5]] +.[[6]] +.[[13]] + .[[15]]))%>%  # Undergraduate In-State On Campus
  mutate(UOSOnC = (.[[7]] +.[[8]] +.[[13]] + .[[15]]))%>%  # Undergraduate Out-of-State On Campus
  mutate(UISOffC = (.[[5]] +.[[6]] +.[[13]] + .[[14]]))%>%  # Undergraduate In-State Off Campus
  mutate(UOSOffC = (.[[7]] +.[[8]] +.[[13]] + .[[14]]))%>%  # Undergraduate Out-of-State Off Campus
  mutate(GISOnC = (.[[9]] +.[[10]] +.[[13]] + .[[15]]))%>%  # Graduate In-State On Campus
  mutate(GOSOnC = (.[[11]] +.[[12]] +.[[13]] + .[[15]]))%>%  # Graduate Out-of-State On Campus
  mutate(GISOffC = (.[[9]] +.[[10]] +.[[13]] + .[[14]]))%>%  # Graduate In-State Off Campus 
  mutate(GOSOffC = (.[[11]] +.[[12]] +.[[13]] + .[[14]]))  # Graduate Out-of-state Off Campus

# IG calculation ----
ProjectDataCalc <- ProjectDataCalc %>%  # Institutional grant average 
  mutate(IG = ((.[[16]]/100)*.[[17]])) # IGRNT_P/100 * IGRNT_A = amount of IG per average student 

# YCA ----
YCA_calc <- ProjectDataCalc %>%
  mutate(IG_UISOnC = UISOnC - IG) %>%  # Undergraduate, In-State, On Campus, WITH (subtract) Institutional grant
  mutate(IG_UOSOnC = UOSOnC - IG) %>%  # Undergraduate, Out-of-State, On Campus, WITH (subtract) Institutional grant
  mutate(IG_UISOffC = UISOffC - IG) %>%  # Undergraduate, In-State, Off Campus, WITH (subtract) Institutional grant
  mutate(IG_UOSOffC = UOSOffC - IG) %>%  # Undergraduate, Out-of-State, Off Campus, WITH (subtract) Institutional grant
  mutate(IG_GISOnC = GISOnC - IG) %>%  #Graduate, In-State, On Campus, WITH (subtract Institutional Grant)
  mutate(IG_GOSOnC = GOSOnC - IG) %>% #Graduate, Out-of-State, On Campus, WITH (subtract Institutional Grant)
  mutate(IG_GISOffC = GISOffC - IG) %>% #Graduate, In-State, Off Campus, WITH (subtract Institutional Grant)
  mutate(IG_GOSOffC = GOSOffC - IG) %>% #Graduate, Out-of-State, Off Campus, WITH (subtract Institutional Grant)

# multiplier (# of years) calculation ----
mutate(Year_calc = (.[[18]]/.[[20]])) %>% # % of students that graduate in 4 years / 8 years
mutate(Ugrad_Mult = ifelse(Year_calc >= .70, 4, 6))

# TCA calculation ----
TCA_Calc <- YCA_calc %>%  # Total Cost of Attendance
  mutate(TCA_IG_UISOnC = (IG_UISOnC * Ugrad_Mult)) %>%  # with institutional grant, undergrad, in state, on campus, times # of years
  mutate(TCA_IG_UOSOnC = (IG_UOSOnC * Ugrad_Mult)) %>%  # with institutional grant, undergrad, out of state, on campus, times # of years
  mutate(TCA_IG_UISOffC = (IG_UISOffC * Ugrad_Mult)) %>%  # with institutional grant, undergrad, in state, off campus, times # of years
  mutate(TCA_IG_UOSOffC = (IG_UOSOffC * Ugrad_Mult)) %>%  # with institutional grant, undergrad, out of state, off campus, times # of years
  mutate(TCA_UISOnC = (UISOnC * Ugrad_Mult)) %>%  # without institutional grant, undergrad, in state, off campus, times # of years
  mutate(TCA_UOSOnC = (UOSOnC * Ugrad_Mult)) %>%  # without institutional grant, undergrad, out of state, on campus, times # of years
  mutate(TCA_UISOffC = (UISOffC * Ugrad_Mult)) %>% #without institutional grant, undergrad, in-state, off campus, times # of years
  mutate(TCA_UOSOffC = (UOSOffC * Ugrad_Mult))  # without institutional grant, undergrad, out of state, off campus, times # of years

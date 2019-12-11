# Cost of Attendance Input form
# 2019 12 09
# script modified from https://deanattali.com/2015/06/14/mimicking-google-form-shiny/#prereqs

# load packages and files -----
library(shiny)
library(shinyjs)
library(dplyr)
library(digest)
library(DT)
library(datasets)

source("bus_355_project.R")


shinyApp(
  # ui ----
  ui = fluidPage(

    titlePanel("Undergraduate Total Cost of Attendance (TCA) Model"),
    
    sidebarLayout(
      sidebarPanel(
        textInput("name", "Name", ""),
        selectInput("state_of_residence", "State of residence", c("",state.abb))
        #selectInput("graduate_undergrad", "Graduate or Undergraduate Degree?", c("","Graduate","Undergraduate")),
        #selectInput("oncampus_offcampus", "Will you live On-campus or Off-campus?", c("On Campus","Off Campus"))
      , width = 2),
      # Show a plot of the generated distribution
      mainPanel(
        DT::dataTableOutput("results")
      )
    )
  ),
 

  # server ----
  server = function(input, output, session) {
  
    output$results <- DT::renderDataTable({
      app_data <- TCA_Calc %>%
        {if ("STABBR" == input$state_of_residence) 
            select(., INSTNM, STABBR, WEBADDR, UOSOnC, UOSOffC, IGRNT_P, IGRNT_A, Ugrad_Mult, TCA_IG_UOSOnC, TCA_IG_UOSOffC, TCA_UOSOnC) else
          select(., INSTNM, STABBR, WEBADDR, UISOnC, UISOffC, IGRNT_P, IGRNT_A, Ugrad_Mult, TCA_IG_UISOnC, TCA_IG_UISOffC, TCA_UISOnC)}
        
      #rownames = FALSE
      #options = list(searching = FALSE, lengthChange = FALSE)
    }) 
    
#    observeEvent(input$state_of_residence)  
    
  }
  
)

# Cost of Attendance Input form
# 2019 12 09
# script modified from https://deanattali.com/2015/06/14/mimicking-google-form-shiny/#prereqs

# load packages and files -----
library(shiny)
library(shinyjs)
library(dplyr)
library(digest)
library(DT)

source("bus_355_project.R")
stateabb <-unique(TCA_Calc$STABBR)


shinyApp(
  # ui ----
  ui = fluidPage(

    titlePanel("Undergraduate Total Cost of Attendance (TCA) Model"),
    
    sidebarLayout(
      sidebarPanel(
        textInput("name", "Name", ""),
        selectInput("state_of_residence", "State of residence", c("",stateabb))
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
      print(input$state_of_residence)
      print(TCA_Calc$STABBR == input$residence)
      TCA_Calc %>%
        select(INSTNM, STABBR, WEBADDR, IGRNT_P, IGRNT_A, Ugrad_Mult, {if (TCA_Calc$STABBR == input$state_of_residence) (c(UISOnC, UISOffC, TCA_IG_UISOnC, TCA_IG_UISOffC)) #else (c(UOSOnC, UOSOffC, TCA_IG_UOSOnC, TCA_IG_UOSOffC))})
        })
        # {if ("STABBR" == input$state_of_residence) 
        #     select(., INSTNM, STABBR, WEBADDR, UOSOnC, UOSOffC, IGRNT_P, IGRNT_A, Ugrad_Mult, TCA_IG_UOSOnC, TCA_IG_UOSOffC, TCA_UOSOnC) else
        #   select(., INSTNM, STABBR, WEBADDR, UISOnC, UISOffC, IGRNT_P, IGRNT_A, Ugrad_Mult, TCA_IG_UISOnC, TCA_IG_UISOffC, TCA_UISOnC)}
        
      #rownames = FALSE
      #options = list(searching = FALSE, lengthChange = FALSE)
    }) 
    
#    observeEvent(input$state_of_residence)  
    
  }
  
)

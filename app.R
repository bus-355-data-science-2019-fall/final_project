# Undergraduate Total Cost of Attendance Model
# 2019 12 09

# load packages and files -----
library(shiny)
library(shinyjs)
library(dplyr)
library(digest)
library(DT)

source("bus_355_project.R")
stateabb <- c(" ", unique(TCA_Calc$STABBR))


shinyApp(
  # ui ----
  ui = fluidPage(

    titlePanel("Undergraduate Total Cost of Attendance (TCA) Model"),
    
    sidebarLayout(
      sidebarPanel(
        textInput("name", "Name", ""),
        selectInput("state_of_residence", "State of residence", stateabb),
        #selectInput("graduate_undergrad", "Graduate or Undergraduate Degree?", c("","Graduate","Undergraduate")),
        selectInput("oncampus_offcampus", "Will you live On-campus or Off-campus?", c("Live On Campus","Live Off Campus"))
      , width = 2),
      # Show a plot of the generated distribution
      mainPanel(
        DT::dataTableOutput("results")
      )
    )
  ),
 

  # server ----
  server = function(input, output, session) {
  
    #output$results <- DT::renderDataTable({
    output$results <- DT::renderDT({
      #print(input$state_of_residence)
      #print(input$oncampus_offcampus)
      #print(TCA_Calc$STABBR == input$residence)
      #print(input$state_of_residence == TCA_Calc$STABBR & input$oncampus_offcampus == "Live On Campus")
      
      # Testing purposes
      #input <- as.data.frame(t(c("AZ","Live On Campus")))
      #names(input) <- c("state_of_residence","oncampus_offcampus")

      TCA_present <- TCA_Calc %>%
        mutate(TCA_wIG = case_when(
          (input$state_of_residence == STABBR & input$oncampus_offcampus == "Live On Campus") ~ TCA_IG_UISOnC,
          (input$state_of_residence == STABBR & input$oncampus_offcampus == "Live Off Campus") ~ TCA_IG_UISOffC,
          (input$state_of_residence != STABBR & input$oncampus_offcampus == "Live On Campus") ~ TCA_IG_UOSOnC,
          (input$state_of_residence != STABBR & input$oncampus_offcampus == "Live Off Campus") ~ TCA_IG_UOSOffC
        )) %>%
        mutate(TCA_woIG = case_when(
          (input$state_of_residence == STABBR & input$oncampus_offcampus == "Live On Campus") ~ TCA_UISOnC,
          (input$state_of_residence == STABBR & input$oncampus_offcampus == "Live Off Campus") ~ TCA_UISOffC,
          (input$state_of_residence != STABBR & input$oncampus_offcampus == "Live On Campus") ~ TCA_UOSOnC,
          (input$state_of_residence != STABBR & input$oncampus_offcampus == "Live Off Campus") ~ TCA_UOSOffC
        )) %>%
        select(INSTNM, STABBR, WEBADDR, IGRNT_P, IGRNT_A, Ugrad_Mult, TCA_wIG, TCA_woIG) %>%
        arrange(TCA_woIG)
        
      
        # {if ("STABBR" == input$state_of_residence) 
        #     select(., INSTNM, STABBR, WEBADDR, UOSOnC, UOSOffC, IGRNT_P, IGRNT_A, Ugrad_Mult, TCA_IG_UOSOnC, TCA_IG_UOSOffC, TCA_UOSOnC) else
        #   select(., INSTNM, STABBR, WEBADDR, UISOnC, UISOffC, IGRNT_P, IGRNT_A, Ugrad_Mult, TCA_IG_UISOnC, TCA_IG_UISOffC, TCA_UISOnC)}
        
      #rownames = FALSE
      #options = list(searching = FALSE, lengthChange = FALSE)
      
    }) 
    
#    observeEvent(input$state_of_residence)  
    
  }
  
)

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

# mandatory fields ------
fieldsMandatory <- c("name", "state_of_residence")

labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

# CSS ----
appCSS <-
  ".mandatory_star { color: red; }
   #error { color: red; }"

# field list, response directory name, epochTime
fieldsAll <- c("name", "state_of_residence","graduate_undergrad","oncampus_offcampus")
responsesDir <- file.path("responses")
epochTime <- function() {
  as.integer(Sys.time())
}

# loadData function ----
loadData <- function() {
  # files <- list.files(file.path(responsesDir), full.names = TRUE)
  # data <- lapply(files, read.csv, stringsAsFactors = FALSE)
  # data <- dplyr::rbind_all(data)
  # data
  data <- TCA_Calc %>%
    select(INSTNM, STABBR, WEBADDR, Ugrad_Mult, {if (STABBR == input$state_of_residence & 
                                                  input$oncampus_offcampus == "On Campus") 
      (UISOnC)})
}

shinyApp(
  # ui ----
  ui = fluidPage(

    titlePanel("Undergraduate Total Cost of Attendance (TCA) Model"),
    
    sidebarLayout(
      sidebarPanel(
        textInput("name", "Name", ""),
        selectInput("state_of_residence", "State of residence", c("",state.abb),
        #selectInput("graduate_undergrad", "Graduate or Undergraduate Degree?", c("","Graduate","Undergraduate")),
        selectInput("oncampus_offcampus", "Will you live On-campus or Off-campus?", c("On Campus","Off Campus"))
      ),
      # Show a plot of the generated distribution
      mainPanel(
        DT::dataTableOutput("results")
      )
      
    )
  )
 )

  # server ----
  server = function(input, output, session) {
  
    output$results <- DT::renderDataTable({
      loadData()
      #rownames = FALSE
      #options = list(searching = FALSE, lengthChange = FALSE)
    }) 
    
#    observeEvent(input$state_of_residence)  
    
  }
  
)

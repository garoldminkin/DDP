# load required libraries
library(shiny)
library(maps)
library(mapdata)
library(ggplot2)

# load Department mapping data
states <- map_data("state")

# Capitalize 1st letter
states$region <- paste(toupper(substr(states$region, 1, 1)), substr(states$region, 2, nchar(states$region)), sep="")

# make the first Department choice be NA
state_choices <- c("<Select a state>")

# append the Department choices
state_choices <- c(state_choices, unique(states$region))

# Define UI for application
shinyUI(fluidPage(
    
    # Application title
    titlePanel("50 States of the USA"),
    
    # Sidebar with drop down selector to choose the Department
    # Also includes instructions to use the application
    sidebarLayout(
        sidebarPanel(
            "Select a State of the USA:",
            selectInput("sel_state", "",state_choices, selected = "<Select a state>", multiple=FALSE),
            h4("Detailed Instructions"),
            "Choose the state from the dropdown list to highlight on the map on your right. ",
            hr(),
            "You selected:",
            h4(textOutput("selection"))
        ),
        
        # Show the map plot
        mainPanel(
            h4("United States of America"),
            plotOutput("mapPlot")
        )
    )
))


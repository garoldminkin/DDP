library(shiny)
library(ggplot2)
library(stringr)
library(maps)
library(mapdata)

# Load state mapping data
states <- map_data("state")

# Capitalize 1st letter
states$region <- str_to_title(states$region)

# initial selection - use a prompt
state_choices <- c("<Select a state>")

# distinct vector of states
state_choices <- c(state_choices, unique(states$region))

# Define UI for application
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Crime Rate in the USA"),
    
    # Sidebar with drop down list to select a state
    sidebarLayout(
        sidebarPanel(
            "Select a State of the USA:",
            selectInput("sel_state", "",state_choices, selected = "<Select a state>", multiple=FALSE),
            h4("Detailed Instructions"),
            "Choose the state from the dropdown list to highlight on the map on your right and to see violent crime rates by US State below.",
            hr(),
            "You selected:",
            h4(textOutput("selection")),
            h5(textOutput("murders")),
            h5(textOutput("assault")),
            h5(textOutput("rape")),
            h5(textOutput("urbanPop"))
        ),
        
        # Show the map plot
        mainPanel(
            h4("United States of America"),
            plotOutput("mapPlot")
        )
    )
))


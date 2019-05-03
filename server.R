library(shiny)
library(ggplot2)
library(stringr)
library(datasets)
library(maps)
library(mapdata)

# Crime statistics provided by the USArrests dataset
data(USArrests)

# Define server logic required to draw the map and selected state
shinyServer(function(input, output) {
    
    # Load state mapping data
    states <- map_data("state")
    
    # Capitalize 1st letter
    states$region <- str_to_title(states$region)
    
    # Change column names to be displayed as plot labels
    colnames(states)[1] <- "Longitude"
    colnames(states)[2] <- "Latitude"
    
    # React to the state selection
    sel_state <- reactive({
        subset(states, region %in% input$sel_state)
    })
    
    # Render text below derived based on the state selected
    output$selection <- renderText(
        ifelse(substr(input$sel_state, 1, 1) == "<", "NONE", input$sel_state)
    )
    output$murders <- renderText(
        ifelse(substr(input$sel_state, 1, 1) == "<", "", paste("Murder Rate (per 100,000): ",USArrests[input$sel_state, ]$Murder))
    )
    output$assault <- renderText(
        ifelse(substr(input$sel_state, 1, 1) == "<", "", paste("Assault Rate (per 100,000): ",USArrests[input$sel_state, ]$Assault))
    )
    output$rape <- renderText(
        ifelse(substr(input$sel_state, 1, 1) == "<", "", paste("Rape Rate (per 100,000): ",USArrests[input$sel_state, ]$Rape))
    )
    output$urbanPop <- renderText(
        ifelse(substr(input$sel_state, 1, 1) == "<", "", paste("Urban Population (%): ",USArrests[input$sel_state, ]$UrbanPop))
    )
    
    output$mapPlot <- renderPlot({
        
        # draw the US map with the selected state highlighted in blue
        ggplot(data = states) + 
            geom_polygon(aes(x = Longitude, y = Latitude, group = group), fill = "white", color = "blue") + 
            geom_polygon(data=sel_state(), aes(x = Longitude, y = Latitude, group = group), fill = "blue")
        
    })
    
})

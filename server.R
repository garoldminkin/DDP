# load the necessary libraries
library(shiny)
library(ggplot2)
library(maps)
library(mapdata)

# Define server logic required to draw the map and selected state
shinyServer(function(input, output) {
    
    # Load state mapping data
    states <- map_data("state")
    # Capitalize 1st letter
    states$region <- paste(toupper(substr(states$region, 1, 1)), substr(states$region, 2, nchar(states$region)), sep="")
    # Change column names to be displayed as plot labels
    colnames(states)[1] <- "Longitude"
    colnames(states)[2] <- "Latitude"
    # React to the state selection
    sel_state <- reactive({
        subset(states, region %in% input$sel_state)
    })
    
    output$selection <- renderText(
        ifelse(substr(input$sel_state, 1, 1) == "<", "NONE", input$sel_state)
    )
    
    output$mapPlot <- renderPlot({
        
        # draw the US map with the selected state highlighted in blue
        ggplot(data = states) + 
            geom_polygon(aes(x = Longitude, y = Latitude, group = group), fill = "white", color = "blue") + 
            #coord_fixed(1.3) +
            #guides(fill=FALSE) + 
            geom_polygon(data=sel_state(), aes(x = Longitude, y = Latitude, group = group), fill = "blue")
        
    })
    
})

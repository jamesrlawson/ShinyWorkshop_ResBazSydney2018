# Exercise: add functionality to select a variable to colour points or change point shapes

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("mtcars data explorer"), # give our app a title
  
  sidebarLayout( # this is Shiny's basic type of layout - more complex layouts exist

    # Sidebar with a slider input for number of bins 
    sidebarPanel(
      
      ## add x-axis selector
      selectInput(inputID="x_axis", label="Select x-axis", choices=c("Miles per gallon" = "mpg",
                                                                     "Weight" = "wt",
                                                                     "Horsepower" = "hp",
                                                                     "Engine displacement" = "disp")),
      ## add y-axis selector

      ## add factor selector

      ## display a table 
      tableOutput('')
    ),
    
    # Show a graph of the selected relationships in a 'main panel'
    
    mainPanel(
      ## display the graph
      plotOutput('')
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # code to generate the table
  output$### <- renderTable({
    # create a dataframe from the mtcars dataset with just the three columns selected by the user using the selectInput()'s
  }, rownames = TRUE)
  
  # code to generate the plot
  output$### <- renderPlot({
    ggplot(mtcars, aes_string(x = input$x_axis, y = input$y_axis)) + # aes_string is important here!
      geom_point(aes_string(col = input$fac)) +
      scale_color_gradientn(colours = rainbow(5))+
      theme_minimal()
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


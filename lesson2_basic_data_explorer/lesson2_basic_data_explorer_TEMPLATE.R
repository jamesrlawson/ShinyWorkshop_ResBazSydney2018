# Exercise 1: fill out the template to create a working app!
# Exercise 2: add functionality to select a 'factor' variable to colour points or change point shapes

library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  # Application title
  titlePanel(""), # give our app a title
  
  sidebarLayout( # this is Shiny's basic type of layout - more complex layouts exist

    # Sidebar with input widgets
    sidebarPanel(
      
      ## add x-axis selector
      selectInput(inputId="x_axis", label="Select x-axis", choices=c("Miles per gallon" = "mpg",
                                                                     "Weight" = "wt",
                                                                     "Horsepower" = "hp",
                                                                     "Engine displacement" = "disp")),
      ## add y-axis selector

      ## add factor selector

      ## display a table 
      tableOutput("")
    ),
    
    # Show a graph of the selected relationships in a 'main panel'
    
    mainPanel(
      ## display the graph
      plotOutput("")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # code to generate the table
  output$YOURVALUEHERE <- renderTable({
    # create a dataframe from the mtcars dataset with just the columns selected by the user using the selectInput()'s
  })
  
  # code to generate the plot
  output$YOURVALUEHERE <- renderPlot({
    ggplot(mtcars, aes_string(x = input$x_axis, y = input$y_axis)) + # aes_string is important here!
      geom_point() +
      scale_color_gradientn(colours = rainbow(5))+
      theme_minimal()
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


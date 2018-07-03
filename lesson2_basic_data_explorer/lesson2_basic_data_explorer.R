library(shiny)
library(ggplot2)
library(plotly)

ui <- fluidPage(
   
  # Application title
  titlePanel("mtcars data explorer"), # give our app a title
  
  sidebarLayout( # this is Shiny's basic type of layout - more complex layouts exist
    
    # Sidebar with input widgets
    sidebarPanel(
        ## add x-axis selector
        selectInput("x_axis", "Select x-axis", choices=c("Miles per gallon" = "mpg",
                                                         "Weight" = "wt",
                                                         "Horsepower" = "hp",
                                                         "Engine displacement" = "disp")),
        ## add y-axis selector
        selectInput("y_axis", "Select y-axis", choices=c("Miles per gallon" = "mpg",
                                                         "Weight" = "wt",
                                                         "Horsepower" = "hp",
                                                         "Engine displacement" = "disp")),
        ## add factor selector
        selectInput("fac", "Select factor", choices=c("Miles per gallon" = "mpg",
                                                         "Weight" = "wt",
                                                         "Horsepower" = "hp",
                                                         "Engine displacement" = "disp")),
        ## display a table 
        tableOutput('table')
      ),
      
    # Show a graph of the selected relationships in a 'main panel'
    
    mainPanel(
        ## display the graph
        plotOutput('plot') # plotlyOutput
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # code to generate the table
  output$table <- renderTable({
    # create a dataframe from the mtcars dataset with just the columns selected by the user using the selectInput()'s
    mtcars[, c(input$x_axis, input$y_axis, input$fac), drop = FALSE]
  })
  
  # code to generate the graph
  output$plot <- renderPlot({ # renderPlotly
    ggplot(mtcars, aes_string(x = input$x_axis, y = input$y_axis)) + 
      geom_point(aes_string(col = input$fac)) +
      scale_color_gradientn(colours = rainbow(5))+
      theme_minimal()
  })

  
}

# Run the application 
shinyApp(ui = ui, server = server)


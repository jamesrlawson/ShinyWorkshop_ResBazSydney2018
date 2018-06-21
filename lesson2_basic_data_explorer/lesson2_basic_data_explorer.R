# Exercise: add functionality to select a variable to colour points or change point shapes

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("mtcars data explorer"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
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
        tableOutput('table')
      ),
      
      # Show a plot of the selected relationships
      mainPanel(
         ## add plotOutput("")
        plotOutput('plot')
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
   
  output$table <- renderTable({
    mtcars[, c(input$x_axis, input$y_axis, input$fac), drop = FALSE]
  }, rownames = TRUE)
  
  output$plot <- renderPlot({
    ggplot(mtcars, aes_string(x = input$x_axis, y = input$y_axis)) + 
      geom_point(aes_string(col = input$fac)) +
      scale_color_gradientn(colours = rainbow(5))+
      theme_minimal()
  })

  
}

# Run the application 
shinyApp(ui = ui, server = server)


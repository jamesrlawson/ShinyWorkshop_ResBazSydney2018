# Exercise 1: use the help for updateSelectedInput() and work out how to preselect some values (rather than have them start all the same)
# Exercise 2: use the help for fileUpload() and work out how to add the file name as a title to the plot - in ggtitle()

library(shiny)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  
  # Application title
  titlePanel("Interactive data explorer"), # give our app a title
  
  sidebarLayout( # this is Shiny's basic type of layout - more complex layouts exist
    
    # Sidebar with input widgets
    sidebarPanel(
      
      ## add fileInput widget
      fileInput("uploadedfile", "Choose CSV File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      ## add x-axis selector
      selectInput("x_axis", "Select x-axis", choices=NULL),
      ## add y-axis selector
      selectInput("y_axis", "Select y-axis", choices=NULL),
      ## add factor selector
      selectInput("fac", "Select factor", choices=NULL),
      ## display a table 
      tableOutput('table')
      
    ),
    
    # Show a graph of the selected relationships in a 'main panel'
    
    mainPanel(
      ## display the graph
      plotlyOutput('plot') # plotlyOutput
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output, session) {
   
  uploaded_file <- eventReactive(input$uploadedfile, {
    df <- read.csv(input$uploadedfile$datapath)
    
    vars <- names(df)
    updateSelectInput(session, "x_axis", choices = vars)
    updateSelectInput(session, "y_axis", choices = vars)
    updateSelectInput(session, "fac", choices = vars)
    
    return(df)
  })
  
  
  output$table <- renderTable({
    uploaded_file()[, c(input$x_axis, input$y_axis, input$fac), drop = FALSE]
  })
    
  output$plot <- renderPlotly({
    ggplot(uploaded_file(), aes_string(x = input$x_axis, y = input$y_axis)) + 
      geom_point(aes_string(col = input$fac)) +
      scale_color_gradientn(colours = rainbow(5))+
      ggtitle("") +
      theme_minimal()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)


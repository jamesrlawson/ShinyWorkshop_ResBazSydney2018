# ResBaz Sydney 2018 Advanced R Session - Get interactive with Shiny
# Lesson 1 - under the hood of a Shiny app

install.packages('shiny')

library(shiny)

# these instructive examples come with the Shiny package
# check out https://shiny.rstudio.com/articles/basics.html for a guide to the code

  runExample("01_hello")

# 01_hello shows a basic example of reactivity: one input, one output
# -	User changes the position of the slider, and this alters the binwidth of the histogram
# -	The user interface updates pretty quickly, gives a seamless experience
# 
# UI – user interface
# -	Input widgets collect information from the user
# -	Displays outputs, such as plots or tables
# -	Define how visual elements are laid out
# -	Written in R syntax, but most functions won’t be familiar
# 
# Server
# -	Where data is processed
# -	Regular R code combined with special shiny:: functions that implement reactivity
# - Reactive expressions are re-evaluated when their dependent values have changed
#
# The sliderInput widget defined in the UI allows the user to set a value, which is retrieved and used to set the binwidth in the Server.
#
# renderPlot is a reactive expression: code wrapped within renderPlot({}) will be re-evaluated any time an input changes
# 
# Exercise 1: identify how the value obtained by the sliderInput is used by the renderPlot expression in the Server 
#  
# Exercise 2: identify how the histogram object produced in the Server is passed to the User Interface 
# 
# N.B. if you want to use 'reactive values' (i.e. those that are updated), you must use them within one of Shiny's reactive expressions
 
  runExample("02_text")

# 02_text uses multiple input widgets and displays multiple outputs
# this example also implements a 'chain of reactivity', using the reactive({}) expression
# reactive({}) allows us to assign an expression to an object, which can be called upon in other reactive expressions
#
# Exercise 3: trace the path from the "dataset" input in the UI through the Server, and back to the "view" table in the UI
# (hint, think in terms of inputs and outputs)
#
# Exercise 4: play around with resizing the Shiny application window - notice what happens to the layout

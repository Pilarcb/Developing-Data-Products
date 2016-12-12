# Developing Data Products-Course Project
# ui.R file

library(shiny)
library(ggplot2)
library(shinyapps)
shinyUI(fluidPage(
        titlePanel("Predict PRICE from CARAT: 
as you change the slider value, you will see two models here: the red one, which
has no spline term, and the blue one, which has this spline term at 3. These two models are used 
to form the prediction: model 1 it's going to predict at the new value input, and then (as model 2 
has carat variable in this break point), if our input value is bigger than 3, it returns the carat 
number, otherwise it's going to return 0. Below the graph, you can see the prediction from models 1 
and 2. Submit button: as you change the value of the slider, it doesn't rerun. You have to click Submit
and then it reruns. Also, you can show or hide the first line and the second one. "),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderCARAT", "What is the CARAT of the diamond?", 0.1, 5, value = 3),
                        checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
                        checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
                        submitButton("Submit")
                ),
                mainPanel(
                        plotOutput("plot1"),
                        h3("Predicted Price from Model 1:"),
                        textOutput("pred1"),
                        h3("Predicted Price from Model 2:"),
                        textOutput("pred2")
                )
        )
))
# Developing Data Products-Course Project
# server.R file

library(shiny)
library(ggplot2)
library(shinyapps)
shinyServer(function(input, output) {
        diamonds$caratsp <- ifelse(diamonds$carat - 3 > 0, diamonds$carat - 3, 0)
        model1 <- lm(price ~ carat, data = diamonds)
        model2 <- lm(price ~ caratsp + carat, data = diamonds)
        
        model1pred <- reactive({
                caratInput <- input$sliderCARAT
                predict(model1, newdata = data.frame(carat = caratInput))
        })
        
        model2pred <- reactive({
                caratInput <- input$sliderCARAT
                predict(model2, newdata = 
                                data.frame(carat = caratInput,
                                           caratsp = ifelse(caratInput - 3 > 0,
                                                          caratInput - 3, 0)))
        })
        
        output$plot1 <- renderPlot({
                caratInput <- input$sliderCARAT
                
                plot(diamonds$carat, diamonds$price, xlab = "Carat of Diamonds", 
                     ylab = "Price of Diamonds", bty = "n", pch = 16,
                     xlim = c(0.1, 5), ylim = c(0.1, 20000))
                if(input$showModel1){
                        abline(model1, col = "red", lwd = 2)
                }
                if(input$showModel2){
                        model2lines <- predict(model2, newdata = data.frame(
                                carat = 0.1:5, caratsp = ifelse(0.1:5 - 3 > 0, 0.1:5 - 3, 0)
                        ))
                        lines(0.1:5, model2lines, col = "blue", lwd = 2)
                }
                
                legend(3.5, 5000, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
                       col = c("red", "blue"), bty = "n", cex = 1.2)
                points(caratInput, model1pred(), col = "red", pch = 16, cex = 2)
                points(caratInput, model2pred(), col = "blue", pch = 16, cex = 2)
        })
        
        output$pred1 <- renderText({
                model1pred()
        })
        
        output$pred2 <- renderText({
                model2pred()
        })
})
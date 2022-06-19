library(shiny)
library(caret)
library(readr)
library(tidyverse)
library(ggplot2)
library(randomForest)

shinyServer(function(input, output) {

    mdl_rf <- readRDS("mdl.rds")
    
    mdl_rf_pred <- reactive({
        age <- input$age
        sex <- input$sex
        p_class <- input$classStatus
        data_in <- data.frame(Sex = sex, Age = as.numeric(input$age), Pclass = p_class)

        pred <- predict(mdl_rf, newdata = data_in, type = "prob")
        pred2 <- predict(mdl_rf, newdata = data_in)
        data.frame(
            survived = c("Yes", "No"),
            probability = c(pred$yes, pred$no),
            actual = c(
                ifelse(pred2 == "yes", TRUE, FALSE),
                ifelse(pred2 == "no", FALSE, TRUE)
            )
        )
    })
    
    
    output$survived <- renderText({
        ifelse(mdl_rf_pred()$actual[1], "Yes! :)", "No :(")
    })
    
    output$age <- renderText({input$age})
    output$sex <- renderText({input$sex})
    output$pclass <- renderText({input$classStatus})
    output$state <- renderText({
        ifelse(mdl_rf_pred()$actual[1], "would likely", "would likely not")
    })
    output$prob <- renderText({
        ifelse(
            mdl_rf_pred()$actual[1], 
            scales::percent(mdl_rf_pred()$probability[1], accuracy = .1),
            scales::percent(mdl_rf_pred()$probability[2], accuracy = .1)
        )
    })
    output$plt <- renderPlot({
        ggplot(data = mdl_rf_pred(), aes(x="", y=probability, fill=survived)) + 
            geom_bar(width = 1, stat="identity") +
            geom_text(
                aes(x = 1.6, label = scales::percent(probability, accuracy = .1)), 
                position = position_stack(vjust = .5)
            ) +
            coord_polar("y", start = 0)
    })

})

library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Would you have survived the Titantic?"),
    sidebarLayout(
        sidebarPanel(
            h4("Person Data Inputs"),
            p("Input data of a person to see the likelyhood that they would have survived the Titantic disaster"),
            sliderInput(
                "age",
                "How old are you?",
                1,
                80,
                25,
                step = 1
            ),
            radioButtons(
                "sex",
                "Are you Male or Female?",
                choiceNames = c("Male", "Female"),
                choiceValues = c("male", "female")
            ),
            radioButtons(
                "classStatus",
                "What is your socio-economic status?",
                choiceNames = c("Lower", "Middle", "Upper"),
                choiceValues = c("low", "middle", "high")
            )
            
        ),
        mainPanel(
            h2(textOutput("survived")),
            p(
                "A", 
                strong(textOutput("age", inline=T)), 
                "year old", 
                strong(textOutput("sex", inline=T)),
                "with",
                strong(textOutput("pclass", inline=T)),
                " socio-economic status,",
                textOutput("state", inline=T),
                "have survived the Titantic."

            ),
            h4("What is the probability that this is true?"),
            p(
                "There is a", 
                strong(textOutput("prob", inline=T)), 
                "probability that this is true"
            ),
            plotOutput("plt"),
            h4("How is this determined?"),
            p("Using the kaggle.com data set, 'Titantic', a Random Forest model 
            was trained on the 'Sex', 'Age' and 'Socio-Economic' status of 
            each passenger and crew member on the ship. The model outputs the 
            likelyhood of survival based on this data. The model used is very 
            basic, and only has an accuracy have about 81%."),
            br(),
            p("For more information visit: https://www.kaggle.com/competitions/titanic")
            
        )
    )
))

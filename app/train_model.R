set.seed(1234)
data <- read_csv("./train.csv")
data <- data %>%
    drop_na() %>%
    transform(
        Survived = as.factor(Survived),
        Pclass = as.factor(Pclass),
        Sex = as.factor(Sex)
    ) %>% 
    select(Survived, Pclass, Sex, Age)

levels(data$Survived) = c("no", "yes")
levels(data$Pclass) = c("low", "middle", "high")

control <- trainControl(method = "cv", classProbs=TRUE)

mdl_rf <- train(
    Survived ~ ., 
    data = data, 
    method = "rf", 
    preProcess = c("center", "scale"),
    trControl = control
)

saveRDS(mdl_rf, file="./mdl.rds")

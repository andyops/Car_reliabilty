str(myData)

?as.factor

myData$Vehicle_Brand <- as.factor(myData$Vehicle_Brand)
myData$Vehicle_Model <- as.factor(myData$Vehicle_Model)
myData$Type_of_Service <- as.factor(myData$Type_of_Service)

?subset
#EDA
library(ggplot2)
library(dplyr)

summary(myData)

?sample

set.seed(1234)
indexset <- sample( 2 , nrow(myData) ,replace = T , prob = c(0.7, 0.3) )
train <- myData[indexset==1,]
test <- myData[indexset==2,]

?glm

attach(train)
model <- glm(reliability ~ .,data = train , family = 'binomial')

summary(model)


predictions <- predict(model, newdata = test, type = "response")

# Convert probabilities to binary predictions
threshold <- 0.5  # Example threshold
binary_predictions <- ifelse(predictions > threshold, 1, 0)

# Evaluate model performance
accuracy <- mean(binary_predictions == test$reliability)
precision <- sum(binary_predictions & test$reliability) / sum(binary_predictions)
recall <- sum(binary_predictions & test$reliability) / sum(test$reliability)
f1_score <- 2 * precision * recall / (precision + recall)

cat("Accuracy:", accuracy, "\n")
cat("Precision:", precision, "\n")
cat("Recall:", recall, "\n")
cat("F1-score:", f1_score, "\n")


plot(model)

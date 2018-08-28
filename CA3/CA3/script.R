housing_detail <- read.csv("House_Details.csv")
head(housing_detail)
str(housing_detail)
scatter.smooth(x = housing_detail$County, y = housing_detail$X2015, main = "County ~ X2015")
scatter.smooth(x = housing_detail$County, y = housing_detail$X2017, main = "County ~ X2017")
par(mfrow = c(1, 2))
boxplot(housing_detail$X2015, main = "County ~ X2015",
        sub = paste("Outlier rows: ", boxplot.stats(housing_detail$X2015)$out))
boxplot(housing_detail$X2017, main = "County ~ X2017",
        sub = paste("Outlier rows: ", boxplot.stats(housing_detail$X2017)$out))
install.packages("e1071")
library(e1071)
par(mfrow = c(1, 2))
plot(density(housing_detail$X2015), main = "Density Plot: X2015", ylab = "Frequency",
     sub = paste("Skewness:", round(e1071::skewness(housing_detail$X2015), 2)))
polygon(density(housing_detail$X2015), col = "red")
plot(density(housing_detail$X2017), main = "Density Plot: X2017", ylab = "Frequency",
     sub = paste("Skewness:", round(e1071::skewness(housing_detail$X2017), 2)))
polygon(density(housing_detail$X2017), col = "red")
cor(housing_detail$X2015, housing_detail$X2017)
linearMod <- lm(X2015 ~ X2017, data = housing_detail)
print(linearMod)
summary(linearMod)
set.seed(100)
no_of_records <- sample(1:nrow(housing_detail), 0.8 * nrow(housing_detail))
training_data <- housing_detail[no_of_records,]
testing_data <- housing_detail[-no_of_records,]
lr_model <- lm(X2015 ~ X2017, data = training_data)
summary(lr_model)
dist_predicted <- predict(lr_model, testing_data)
actuals_preds <- data.frame(cbind(actuals = testing_data$mortality, predicted = dist_predicted))
actuals_preds
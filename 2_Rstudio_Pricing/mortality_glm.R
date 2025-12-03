setwd("C:/Users/Lenovo/Desktop/Insurance_project")

pricing_data=read.csv("pricing_model_data.csv",stringsAsFactors = TRUE)
head(pricing_data)
summary(pricing_data)

attach(pricing_data)
glm_model_1=glm(Claims~Ins_Age+BMI+Medical_History_1+offset(log(Exposure)),family = poisson(link = "log"),data = pricing_data)
summary(glm_model_1)

#creating a dummy dataset representing the standard customer profile
test_data=data.frame(
  Ins_Age=seq(0,1,by=0.01),   #taking all ages from 0% to 100%
  BMI=mean(pricing_data$BMI),   #taking the mean of original data set for BMI
  Medical_History_1=mean(pricing_data$Medical_History_1),   #taking the mean of the original dataset for Medical_history_1 
  Exposure=1   #the exposure for a standard customer who dies is 1
)

test_data$Predicted_Freq=predict(glm_model_1,newdata = test_data,type = "response")   #using the predict function to predict the values for each age in the test_data
write.csv(test_data,"final_rate_table.csv",row.names = FALSE)
head(test_data)
plot(test_data$Ins_Age,test_data$Predicted_Freq,
     main = "Mortality Curve (GLM Prediction)",
     xlab="Normalised Age",
     ylab = "Predicted Death rate",
     col="red",type = "l",lwd=2)
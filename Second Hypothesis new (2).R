#Factors affecting YOYReturns of IT sector like Investments, NetIncome, EarningsperShare, NetCashFlow, Long.TermDebt, Research and Development.
install.packages(c("Hmisc","dplyr","ggplot2","mice","Amelia","missForest","random","car"))

library(Hmisc)
library(dplyr)
library(ggplot2)
library(mice)
library(Amelia)
library(missForest)
library(random)
library(car)


#Reading file in csv to R:
my_data <- read.csv("Parameters.csv")

#View the table
View(my_data)

#Used to see datatypes of variables
str(my_data)

#runif() used to randomly generate values from my_data
A1 = runif(506)

#Sorting the data
A2 = order(A1)

#Testing and training my_data:
train_data = my_data[A2[1:350],]
test_data = my_data[A2[351:506],]

#Running the model:
model <- lm(YOYReturns ~ Investments + NetIncome + EarningsPerShare + NetCashFlow + Long.TermDebt + ResearchandDevelopment,data = train_data1)
summary(model)
#Confidence intervalusing confint():
confint(model,level=0.95)

#Plotting graph of YOYReturns with each variable:
avPlots(model)

#Finding residual of the model:
model.resid <- resid(model)

#Plotting histogram for residual:
hist(model.resid)

#Plotting model graph using abline():
abline(model,col="red")
plot(model,whcih =2)


#Effect of missing values:
#MNAR:
mis_data = prodNA(my_data, noNA=0.2)
View(mis_data)

#Removing all the rows with '0' in it:
data_zero <- my_data11[apply(my_data11, 1, function(row) all(row !=0 )), ]

#Running the model:
modelmnar <- lm(YOYReturns ~ Investments + NetIncome + EarningsPerShare + NetCashFlow + Long.TermDebt + ResearchandDevelopment,data = data_zero)
summary(modelmnar)

#Plotting:
avPlots(modelmnar)

#MCAR:
mis_data11 <- mis_data

#Impute values randomly:
mis_data11$Investments <- with(mis_data11, impute(Investments,'random'))
mis_data11$NetIncome <- with(mis_data11, impute(NetIncome,'random'))
mis_data11$EarningsPerShare <- with(mis_data11, impute(EarningsPerShare,'random'))
mis_data11$NetCashFlow <- with(mis_data11, impute(NetCashFlow,'random'))
mis_data11$Long.TermDebt <- with(mis_data11, impute(Long.TermDebt,'random'))
mis_data11$ResearchandDevelopment <- with(mis_data11, impute(ResearchandDevelopment,'random'))


#Running the model:
modelmar <- lm(YOYReturns ~ Investments + NetIncome + EarningsPerShare + NetCashFlow +Long.TermDebt + ResearchandDevelopment,data = mis_data11)
summary(modelmar)

#Plotting:
avPlots(modelmar)


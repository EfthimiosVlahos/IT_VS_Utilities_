install.packages(c("dplyr","ggplot2","missForest","mice"))

library(mice)
library(dplyr)
library(ggplot2)
library(missForest)


##loading fundamentals file
NYSE <- read.csv("C:\\Users\\aakas\\OneDrive\\Desktop\\Data\\NYSE\\fundamentals.csv",header=T)

##loading securities file
sectordata <- read.csv("C:\\Users\\aakas\\OneDrive\\Desktop\\Data\\NYSE\\securities.csv",header=T)

##loading prices file
pricedata <- read.csv("C:\\Users\\aakas\\OneDrive\\Desktop\\Data\\NYSE\\prices.csv",header=T)

##merging price and securities data
price_securities <- merge(pricedata,sectordata,by.x = "symbol",by.y = "Ticker.symbol",all.x = TRUE)




##extracting price and sector data for a particular date
data_IT_1 <- filter(price_securities,date=="2016-12-30" & GICS.Sector=="Information Technology")
data_uti_1 <- filter(price_securities,date=="2016-12-30" & GICS.Sector=="Utilities")
data_IT_2 <- filter(price_securities,date=="2015-12-31" & GICS.Sector=="Information Technology")
data_uti_2 <-  filter(price_securities,date=="2015-12-31" & GICS.Sector=="Utilities")



##extracting few columns from the above IT data
s5 <- data_IT_1[,c(1,8,10,11,4)]
a <- c("Symbol","Stock_Name","Sector","Sub_Industry","Close_2016")
colnames(s5) <- a
s6 <- data_IT_2[,c(1,4)]
b <- c("Symbol","Close_2015")
colnames(s6) <- b
m4 <- merge(s5,s6,by.x = "Symbol",by.y = "Symbol",all.x = TRUE)
head(m4)

##entire population of IT
final_IT <- m4
final_IT$returns <- ((final_IT$Close_2016 - final_IT$Close_2015)/final_IT$Close_2015)*100

##extracting few columns from the above Utilities data
s7 <- data_uti_1[,c(1,8,10,11,4)]
f <- c("Symbol","Stock_Name","Sector","Sub_Industry","Close_2016")
colnames(s7) <- f
s8 <- data_uti_2[,c(1,4)]
b <- c("Symbol","Close_2015")
colnames(s8) <- b
m8 <- merge(s7,s8,by.x = "Symbol",by.y = "Symbol",all.x = TRUE)

##entire population of Utilities
final_Utilities <- m8
final_Utilities$returns <- ((final_Utilities$Close_2016 - final_Utilities$Close_2015)/final_Utilities$Close_2015)*100


##mean of the population parameters
h = mean(final_IT$returns)
o = mean(final_Utilities$returns)
h
o

sd(final_IT$returns)
sd(final_Utilities$returns)


##finding outliers in the IT population
boxplot.stats(final_IT$returns)$out
statis_it <- boxplot.stats(final_IT$returns)$out
it_s <- which(final_IT$returns %in% c(statis_it))
it_s
final_IT[it_s,]

##finding outliers in the Utilities population
boxplot.stats(final_Utilities$returns)$out
statis_uti <- boxplot.stats(final_Utilities$returns)$out
uti_s <- which(final_Utilities$returns %in% c(statis_uti))
uti_s
final_Utilities[uti_s,]


##sample size determination considering 5% margin of error for large sample of IT sector
n4 <- (68*(1.96)^2)/((1.96)^2+4*68*(0.05)^2)
n4


##sampling from the population

sampleIT <- final_IT[sample(nrow(final_IT),size=57),]
head(sampleIT)

sampleUtilities <- final_Utilities[sample(nrow(final_Utilities),size=28),]
head(sampleUtilities)

library(e1071)
skewness(sampleIT$returns)
skewness(sampleUtilities$returns)


dm <- density(sampleIT$returns)
dn <- density(sampleUtilities$returns)
plot(dm)
plot(dn)

box_IT_1 <- ggplot(sampleIT,aes(x="",y=returns)) + geom_boxplot(color="black",fill="lightblue",show.legend = FALSE,outlier.shape = NA) + geom_jitter() + coord_cartesian(ylim = c(-55,240))
box_Uti_1 <- ggplot(sampleUtilities,aes(x="",y=returns)) + geom_boxplot(color="black",fill="lightblue",show.legend = FALSE,outlier.shape = NA) + geom_jitter() + coord_cartesian(ylim = c(-50,50))
box_IT_1
box_Uti_1

shapiro.test(sampleIT$returns)
shapiro.test(sampleUtilities$returns)

##performing hypothesis test
wilcox.test(sampleIT$returns,sampleUtilities$returns,alternative = 'greater')



##seeding and simulating data considering the data is missing values randomly.

it_data <- final_IT[4:6]
it_data1 <- prodNA(it_data,noNA = 0.2)
View(it_data1)
summary(it_data1)
it_data1$Sub_Industry <- as.factor(it_data1$Sub_Industry)
summary(it_data1)
imput_it <- mice(it_data1,m=5,method=c("polyreg","pmm","pmm"),maxit = 40)
summary(it_data1$Close_2016)
imput_it$imp$Close_2016
complete_sim_it <- as.data.frame(complete(imput_it,floor(runif(5,min = 1,max = 6))))
it_data2 <- final_IT[1:3]
final_final_it <- data.frame(it_data2,complete_sim_it)
View(final_final_it)
final_final_it$returns <- ((final_final_it$Close_2016 - final_final_it$Close_2015)/final_final_it$Close_2015)*100
head(final_final_it)



uti_data <- final_Utilities[4:6]
uti_data1 <- prodNA(uti_data,noNA = 0.2)
uti_data1$Sub_Industry <- as.factor(uti_data1$Sub_Industry)
summary(uti_data1)
imput_uti <- mice(uti_data1,m=5,method=c("polyreg","pmm","pmm"),maxit = 40)
summary(uti_data1$Close_2016)
imput_uti$imp$Close_2016
complete_sim_uti <- as.data.frame(complete(imput_uti,floor(runif(5,min = 1,max = 6))))
uti_data2 <- final_Utilities[1:3]
final_final_uti <- data.frame(uti_data2,complete_sim_uti)
View(final_final_uti)
final_final_uti$returns <- ((final_final_uti$Close_2016 - final_final_uti$Close_2015)/final_final_uti$Close_2015)*100



samplemissing_it <- final_final_it[sample(nrow(final_final_it),size=57),]
head(samplemissing_it)

samplemissing_uti <- final_final_uti[sample(nrow(final_final_uti),size=28),]
head(samplemissing_uti)


##performing hypothesis test on missing population.
wilcox.test(final_final_it$returns,final_final_uti$returns,alternative = 'greater')


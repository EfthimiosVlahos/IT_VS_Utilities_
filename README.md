# IT_VS_Utilities
Study where we are checking if IT companies have higher returns as compared to the Utility sector companies from years ranging from 2012-2020 using R.
## Project Overview
- Portfolio Managers have long emphasized and have been highly overweight on IT sector stocks in the last decade. It has been commonly perceived that technological advancements have led the massive growth in the IT sector. Even retail investors have been attracted to fancy tech products and have been investing on a large scale in IT-based companies. In comparison to this, Utilities being an essential consumer product have been delivering consistent returns over the years. As financial experts say, IT stocks are the hot stocks, and superior returns are guaranteed. But is this true?
Thereby we have undertaken this study whereby we are checking if IT companies have higher returns as compared to the Utility sector companies.


## Objectives
* The data set is stored as a Microsoft Excel CSV file. In this project, we will use the R language and environment to do statistical computing and graphics work. Before doing hypotheses testing, we need to import the data set file into R and installing of the below mentioned packages:
- H(0) (Null-Hypothesis)= The IT sector has similar returns with the utilities sector
V.S.
H(1) (Alternative Hypothesis)= The IT sector has greater returns than the utilities sector

## Methodology
- Exploratory Data Analysis - `Conducted Shapiro-Wilkinson tests to test for normality, a non-parametric Wilcoxon-test hypothesis test to decide whether to reject or fail to reject the first hypothesis, and MCAR (Missing values completely at random) and MNAR ( Missing values not at random) to gain better understanding of the dataset.`
- Data Visualization - `Used various plots to visualize the data and it's characteristics.`
- Machine Learning Algorithm used - ` We used MLR (Multiple Linear Regression)`

## Conclusions
- First hypothesis: After conducting the Wilcox test, we conclude we don’t have sufficient evidence to reject the null hypothesis. The higher returns from the IT sector turn out to be a result of the few outliers that exist in the data. Thus, we cannot accept the alternative hypothesis that the IT sector does not have higher returns than the utilities sector. And so, the industry perception that the IT sector has been clocking higher returns needs to be looked into further detail and thereby make wise investment decisions.
- Second Hypothesis:  We reject the null hypothesis which states that IT sector YOY Returns dependent on fundamental factors including Investments(X1), Net Income(X2), Earnings per Share(X3), Net Cash Flow(X4), Long Term Debt(X5), Research and Development(X6). We used several methods like multiple linear regression model to predict variables affecting the IT YOY returns.When using multiple linear regression we found that two factors are significant but when we did further analysis based on effects of missing values. We deduce that when infactuated with missing values our results are not the same anymore and this must be further researched. While comparing values we found that earnings per share is the driving force which remains the same across all models but which cannot be said true for other variables. So, we reject the null hypothesis.

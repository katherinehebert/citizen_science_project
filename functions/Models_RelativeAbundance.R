##library(glmer) if mixed-models
library(MASS)
library(RColorBrewer)

rinat <- read.table("/home/andreanne/Git_SummerSchool/citizen_science_project/data/relative_taxa_abundance.csv",header = TRUE,sep=",")

econo <- read.table("/home/andreanne/Git_SummerSchool/citizen_science_project/data/canada_economic_metrics/censusdivisions_econmetrics.csv",header = TRUE,sep=",")
head(econo)

df <- merge(rinat,econo,by="Geo_Code") #merge the two df
head(df)
str(df)

plot(df$Average_Ind_income,df$fungi,pch=19)
hist(log(df$birds))

## scale the explicative variable
df$Average_Ind_income <- df$Average_Ind_income/1000
df$Average_Ind_income <- scale(df$Average_Ind_income, center = TRUE)

mod1 <- glm(log(fungi)~ Average_Ind_income, data=df, family = gaussian)
summary(mod1)
plot(mod1)

df$fitted<-fitted(mod1)
plot(df$Average_Ind_income,df$fitted,type="l",ylim=c(0,20),lwd=4)
points(df$Average_Ind_income,df$fungi,pch=19)

dev.copy2pdf(file="fungi_RelativeAbundance.pdf")
dev.off()


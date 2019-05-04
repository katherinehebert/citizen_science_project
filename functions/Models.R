library(glmer)

Geo_Code	Prov_Name	CD_Name	Geo_Type	GNR	Average_Household_Income	Average_Ind_income	Median_Household_Income	Median_Ind_income	Total_Household_income	Total_Ind_income	Total_pop

mod1 <- glm(var1)

mod2<-glm(var1~Average_Ind_income+, family=binomial, data=rinat)

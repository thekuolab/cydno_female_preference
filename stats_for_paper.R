library(tidyverse)
library(glmmTMB)
library(DHARMa)
library(GGally)
library(MASS)
library(effectsize)
library(merDeriv)
library(oddsratio)

source("HighstatLibV10.R")

# I. One-male experiments

df<-read_csv("cydno_female_1male.csv")

df.vif<-df
df.vif$treatment2<-ifelse(df.vif$treatment=="white",0,1)
df.vif$population2<-ifelse(df.vif$population=="Panama",0,1)

# I.1 Female responses
df2<-df
df2$total_female_response<-df2$response_neg+df2$response_pos

# Checking for multicollinearity
ggpairs(df.vif[,c(9,17,18)])
corvif(df.vif[,c(9,17,18)])

df2b<-subset(df2,subset = df2$total_male_behaviors!=0 & df2$total_female_response!=0)

response_glm1.4<-glmmTMB(cbind(response_pos,response_neg)~treatment+(1|population),data = df2b,family = "binomial")

# additional test for difference in male efforts between treatments
kruskal.test(response_pos+response_neg~treatment,data = df2b)

# Kruskal-Wallis rank sum test
# 
# data:  response_pos + response_neg by treatment
# Kruskal-Wallis chi-squared = 0.24153, df = 1, p-value = 0.6231

# Model validation
plot(E1<-simulateResiduals(response_glm1.4))
plotResiduals(E1,as.factor(df2b$treatment))

# Summary
summary(response_glm1.4)

# Effect size
params_glm_response<-parameters::model_parameters(response_glm1.4)
d<-oddsratio_to_d(params_glm_response$Coefficient,log = TRUE)
interpret<-interpret_cohens_d(d,rules = "gignac2016")
effectsize<-data.frame(cbind(params_glm_response,d,interpret))

# Parameter Coefficient        SE   CI     CI_low   CI_high         z df_error            p
# 1    (Intercept)  -1.0305037 0.7395403 0.95 -2.4799760 0.4189686 -1.393438      Inf 1.634873e-01
# 2 treatmentwhite   0.8176757 0.1853430 0.95  0.4544101 1.1809413  4.411689      Inf 1.025672e-05
# 3 SD (Intercept)   1.0244145        NA 0.95  0.3783081 2.7739956        NA       NA           NA
# Effects      Group   Component          d interpret
# 1   fixed            conditional -0.5681465  moderate
# 2   fixed            conditional  0.4508083  moderate
# 3  random population conditional  0.5647893  moderate

# I.2 Mating outcome

# Checking for multicollinearity
ggpairs(df.vif[,c(9,10,17,18)])
corvif(df.vif[,c(9,10,17,18)])

outcome_glm<-glm(outcome~population+treatment+response_pos+total_male_behaviors,data = df,family = "binomial")

# Model validation 
plot(E<-simulateResiduals(outcome_glm))

par(mfrow=c(1,3))
plotResiduals(E,as.factor(df$population))
plotResiduals(E,as.factor(df$treatment))
plotResiduals(E,df$response_pos)

# summary
summary(outcome_glm)

# II. Two-male experiments

dff<-read_csv("female_choice_red_white_males.csv")
dff2<-subset(dff,subset = is.na(dff$Preference)==FALSE)

nrow(dff2[dff2$Preference %in% c("red","Red"),])

binom.test(10,21)

# III. Male preference
## III.1. Jiggins et al. 2001
jiggins<-read.table("jiggins_data.txt",header = TRUE)
jiggins$num_obs<-jiggins$court_mp+jiggins$court_cp
jiggins$pref_mp<-jiggins$court_mp/jiggins$num_obs

jiggins_meanpref_CP<-sum(jiggins[jiggins$species=="CP",]$court_mp)/sum(jiggins[jiggins$species=="CP",]$num_obs)
jiggins_sderr_CP<-sd(jiggins[jiggins$species=="CP",]$pref_mp,na.rm = TRUE)/sqrt(length(jiggins[jiggins$species=="CP",]$pref_mp))
jiggins_meanpref_MP<-sum(jiggins[jiggins$species=="MP",]$court_mp)/sum(jiggins[jiggins$species=="MP",]$num_obs)
jiggins_sderr_MP<-sd(jiggins[jiggins$species=="MP",]$pref_mp,na.rm = TRUE)/sqrt(length(jiggins[jiggins$species=="MP",]$pref_mp))
jiggins_meanpref<-data.frame(cbind(c(1:2),c(jiggins_meanpref_CP,jiggins_meanpref_MP),c(jiggins_sderr_CP,jiggins_sderr_MP)))
colnames(jiggins_meanpref)<-c("species","mean_pref","stderr")

## Stats and model validation
jiggins_glm<-glm(cbind(court_mp,court_cp)~species+type_experiment,data = jiggins[is.na(jiggins$pref_mp)==FALSE,],family = "binomial")
plot(E<-simulateResiduals(jiggins_glm))
plotResiduals(E,as.factor(jiggins[is.na(jiggins$pref_mp)==FALSE,]$species),rank = FALSE)
plotResiduals(E,as.factor(jiggins[is.na(jiggins$pref_mp)==FALSE,]$type_experiment),rank = FALSE)

# Summary
summary(jiggins_glm)

# Effect size
or_glm(data = jiggins,model = jiggins_glm,incr = list(species="CP"))

#                   predictor oddsratio   ci_low (2.5) ci_high (97.5)          increment
# 1                speciesMP    75.872       27.074        257.457      Indicator variable
# 2 type_experimentreal_wing     1.424        0.482          4.334      Indicator variable

## III.2 Merrill et al. 2019
merrill<-read.table("merrill_data.txt",header = TRUE)
merrill$num_obs<-merrill$court_cp+merrill$court_mp
merrill$pref_mp<-merrill$court_mp/merrill$num_obs

merrill_meanpref_CP<-sum(merrill[merrill$species=="CP",]$court_mp)/sum(merrill[merrill$species=="CP",]$num_obs)
merrill_sderr_CP<-sd(merrill[merrill$species=="CP",]$pref_mp,na.rm = TRUE)/sqrt(length(merrill[merrill$species=="CP",]$pref_mp))
merrill_meanpref_MP<-sum(merrill[merrill$species=="MP",]$court_mp)/sum(merrill[merrill$species=="MP",]$num_obs)
merrill_sderr_MP<-sd(merrill[merrill$species=="MP",]$pref_mp,na.rm = TRUE)/sqrt(length(merrill[merrill$species=="MP",]$pref_mp))
merrill_meanpref<-data.frame(cbind(c(1:2),c(merrill_meanpref_CP,merrill_meanpref_MP),c(merrill_sderr_CP,merrill_sderr_MP)))
colnames(merrill_meanpref)<-c("species","mean_pref","stderr")

## Stats and model validation
merrill_glm<-glmer(cbind(court_mp,court_cp)~species+(1|ID),data = merrill,family = "binomial")
plot(E<-simulateResiduals(merrill_glm))
plotResiduals(E,as.factor(merrill$species),rank = FALSE)

# Summary
summary(merrill_glm)

## Effect size: odds ratio
merrill_glm2<-glmmPQL(cbind(court_mp,court_cp)~species,random = ~1|ID,data = merrill,family = "binomial")
or_glm(data = merrill,model = merrill_glm2,incr = list(species = "CP"))

#    predictor oddsratio ci_low ci_high          increment
# 1  speciesMP    86.275     NA      NA     Indicator variable

# III.3. Present study
kuo<-read.table("chi_data.txt",header = TRUE)
kuo$num_obs<-kuo$court_cp+kuo$court_mp
kuo$pref_mp<-kuo$court_mp/kuo$num_obs

kuo_meanpref_CP<-sum(kuo[kuo$species=="CP",]$court_mp)/sum(kuo[kuo$species=="CP",]$num_obs)
kuo_sderr_CP<-sd(kuo[kuo$species=="CP",]$pref_mp,na.rm = TRUE)/sqrt(length(kuo[kuo$species=="CP",]$pref_mp))
kuo_meanpref_MP<-sum(kuo[kuo$species=="MP",]$court_mp)/sum(kuo[kuo$species=="MP",]$num_obs)
kuo_sderr_MP<-sd(kuo[kuo$species=="MP",]$pref_mp,na.rm = TRUE)/sqrt(length(kuo[kuo$species=="MP",]$pref_mp))
kuo_meanpref<-data.frame(cbind(c(1:2),c(kuo_meanpref_CP,kuo_meanpref_MP),c(kuo_sderr_CP,kuo_sderr_MP)))
colnames(kuo_meanpref)<-c("species","mean_pref","stderr")

## Stats and model validation
kuo_glm<-glmer(cbind(court_mp,court_cp)~species+(1|ID),data = kuo,family = "binomial")
plot(E<-simulateResiduals(kuo_glm))
plotResiduals(E,as.factor(kuo$species),rank = FALSE)

# Summary
summary(kuo_glm)

# Effect size: odds ratio
kuo_glm2<-glmmPQL(cbind(court_mp,court_cp)~species,random = ~1|ID,data = kuo,family = "binomial")
or_glm(data = kuo,model = kuo_glm2,incr = list(species="CP"))

#   predictor oddsratio ci_low ci_high          increment
# 1 speciesMP    20.406     NA      NA    Indicator variable

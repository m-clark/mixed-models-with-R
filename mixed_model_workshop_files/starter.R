load('data/gpa.RData')

# To load all data from text and exercises:
# sapply(paste0('data/', dir('data')), load, .GlobalEnv)

library(lme4)
gpa_mixed = lmer(gpa ~ occasion + (1|student), data=gpa)
summary(gpa_mixed)


gpa_mixed =  lmer(gpa ~ occasion + (1 + occasion|student), data=gpa)
summary(gpa_mixed)
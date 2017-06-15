# load the GPA data
load('data/gpa.RData')

# if you want to load all data, uncomment and run the following
# sapply(paste0('data/', dir('data')), load, .GlobalEnv)

# if you need to install lme4 first
# install.packages('lme4')

# load the lme4 library
library(lme4)

# random intercepts only
gpa_mixed = lmer(gpa ~ occasion + (1|student), data=gpa)
summary(gpa_mixed)

# random slopes
gpa_mixed = lmer(gpa ~ occasion + (1 + occasion|student), data=gpa)
summary(gpa_mixed)

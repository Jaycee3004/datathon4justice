library(tidyverse)
library(patchworks)

motorvehicledata <- read.csv("motorvehicledata.csv")

motorvehicledata.temp <- motorvehicledata %>%
  mutate(Race.Knowledge = ifelse(motorvehicledata$Race == "U", "U", "K"))

#ggplot(motorvehicledata.temp, aes(x = Outcome, fill = Race.Knowledge)) +
#  geom_bar() + 
#  scale_x_discrete(name = "Outcome by Severity",
#                   limits = c(2,3,4,5,7))

motorvehicledata.reduced <- motorvehicledata.temp %>%
  filter(Race != "U")

motorvehicledata.more <- motorvehicledata.reduced %>%
  mutate(Race.WorNW = case_when(Race == "W" ~ "W",
                                Race == "A" | Race == "B" ~ "NW"))
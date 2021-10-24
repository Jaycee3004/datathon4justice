library(tidyverse)

data1 <- read.csv("full.text.2019.column.names.fix2.csv", header = TRUE , sep = ",")
data2 <- read.csv("full.text.2020.csv", header = FALSE, sep = ",")

extra <- data1$Time*0


data1 <- mutate(data1,data1$Time*0)

total <- merge(data1,data2,by=c(data1$Date,data1$Time,data1$Reason.For.Call.Patrol.Officer.Name,
                                data1$Patrol.Officer.Name.Street,data1$Street.Unit,data1$Unit.Car,
                                data1$Car.Race,data1$Race.Gender,data1$Gender.Extra.Information,
                                data1$Other1,data1$Other2))
               
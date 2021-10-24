library(tidyverse)
ft.2019 <- read_csv("full.text.2019.column.names.csv")
ft.2019 <- ft.2019 %>% filter(!is.na(ft.2019$`Reason For Call/Patrol Officer Name`))
ft.2019 <- ft.2019 %>% filter(ft.2019$`Reason For Call/Patrol Officer Name` != "#NAME?")
ft.2019 <- ft.2019 %>% mutate("Officer Name" = 
                                case_when(str_detect(ft.2019$`Reason For Call/Patrol Officer Name`, "SERGEANT") ~ ft.2019$`Reason For Call/Patrol Officer Name`,
                                          str_detect(ft.2019$`Reason For Call/Patrol Officer Name`, "DISPATCHER") ~ ft.2019$`Reason For Call/Patrol Officer Name`,
                                          str_detect(ft.2019$`Reason For Call/Patrol Officer Name`, "CHIEF") ~ ft.2019$`Reason For Call/Patrol Officer Name`,
                                          str_detect(ft.2019$`Reason For Call/Patrol Officer Name`, "PATROLMAN") ~ ft.2019$`Reason For Call/Patrol Officer Name`,
                                          str_detect(ft.2019$`Reason For Call/Patrol Officer Name`, "PATROL") ~ ft.2019$`Reason For Call/Patrol Officer Name`,
                                          TRUE ~ ft.2019$`Patrol Officer Name/Street`))
ft.2019 <- ft.2019 %>% mutate("Reason For Call" = ifelse(ft.2019$`Reason For Call/Patrol Officer Name` == ft.2019$`Officer Name`, NA, ft.2019$`Reason For Call/Patrol Officer Name`))
ft.2019 <- ft.2019 %>% mutate("Street" = 
                                case_when(str_detect(ft.2019$`Patrol Officer Name/Street`, "RD") ~ ft.2019$`Patrol Officer Name/Street`,
                                          str_detect(ft.2019$`Patrol Officer Name/Street`, "AVE") ~ ft.2019$`Patrol Officer Name/Street`,
                                          str_detect(ft.2019$`Patrol Officer Name/Street`, "ST") ~ ft.2019$`Patrol Officer Name/Street`,
                                          str_detect(ft.2019$`Patrol Officer Name/Street`, "TER") ~ ft.2019$`Patrol Officer Name/Street`,
                                          str_detect(ft.2019$`Street/Unit`, "RD") ~ ft.2019$`Street/Unit`,
                                          str_detect(ft.2019$`Street/Unit`, "AVE") ~ ft.2019$`Street/Unit`,
                                          str_detect(ft.2019$`Street/Unit`, "ST") ~ ft.2019$`Street/Unit`,
                                          str_detect(ft.2019$`Street/Unit`, "TER") ~ ft.2019$`Street/Unit`,
                                          TRUE ~ ""))
ft.2019 <- ft.2019 %>% mutate("Unit" =
                                case_when(nchar(ft.2019$`Street/Unit`) < 6 ~ ft.2019$`Street/Unit`,
                                          nchar(ft.2019$`Unit/Car`) < 11 ~ ft.2019$`Unit/Car`,
                                          TRUE ~ ""))
ft.2019 <- ft.2019 %>% mutate("Vehicle" =
                                case_when(ft.2019$`Unit/Car` != ft.2019$Unit ~ ft.2019$`Unit/Car`,
                                          nchar(ft.2019$`Car/Race`) > 1 ~ ft.2019$`Car/Race`,
                                          TRUE ~ ""))

ft.2019 <- ft.2019 %>% mutate("Race" =
                                case_when(nchar(ft.2019$`Car/Race`) < 2 ~ ft.2019$`Car/Race`,
                                          nchar(ft.2019$`Race/Gender`) < 2  ~ ft.2019$`Race/Gender`,
                                          TRUE ~ ""))

ft.2019 <- ft.2019 %>% mutate("Gender" =
                                case_when(ft.2019$`Race/Gender` != ft.2019$Race ~ ft.2019$`Race/Gender`,
                                          nchar(ft.2019$`Gender/Extra Information`) < 3 ~ ft.2019$`Gender/Extra Information`,
                                          TRUE ~ ""))

ft.2019 <- ft.2019 %>% mutate("Extra Information" =
                                case_when(ft.2019$`Gender/Extra Information` != ft.2019$Gender ~ ft.2019$`Gender/Extra Information`,
                                          TRUE ~ ft.2019$...10))

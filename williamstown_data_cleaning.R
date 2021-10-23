library(pdftools)
logs.2019 <- pdf_text("Logs2019OCR.pdf")
logs.2020 <- pdf_text("Logs2020OCR.pdf")

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


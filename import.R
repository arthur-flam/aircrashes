# aviation data
library(data.table)
library(dplyr)
library(ggplot2)
library(stringr)
library(ggvis)


# download data from http://www.ntsb.gov/aviationquery
# sed "s/ \| /|/g" AviationData.txt > AviationData.clean.txt
data=fread("AviationData.clean.txt", header=TRUE, sep="|")
setnames(data,gsub(names(data),replacement="_",pattern=" "))
data$Event_Date = as.Date(data$Event_Date,format="%m/%d/%Y")
data[is.na(data$Total_Fatal_Injuries),]$Total_Fatal_Injuries=0
data[is.na(data$Total_Serious_Injuries),]$Total_Serious_Injuries=0
data[is.na(data$Total_Minor_Injuries),]$Total_Minor_Injuries=0
data[is.na(data$Total_Uninjured),]$Total_Uninjured=0

data = data %>% mutate(Total_Injuries=Total_Fatal_Injuries+Total_Serious_Injuries+Total_Minor_Injuries) %>%
  mutate(Total_Aboard=Total_Fatal_Injuries+Total_Serious_Injuries+Total_Minor_Injuries+Total_Uninjured) %>%
  filter(Event_Date>as.Date("1985-01-01"), Amateur_Built=="No")

# makers don't have a unique name...
data$Make = toupper(data$Make)
data$Make = str_replace_all(string=data$Make, pattern="[[:punct:]]", replacement="")
data$Make=gsub(data$Make,replacement="",pattern=" inc$")
data$Make=gsub(data$Make,replacement="",pattern=" co$")
data$Make=str_trim(data$Make)
data[data$Make=="airbus industrie",]$Make="airbus"
data[data$Make=="douglas",]$Make="mcdonnell douglas"

# only keep 10 deadliest Make
fatalities_by_Make = data %>%
  filter(Total_Fatal_Injuries>0) %>%
  group_by(Make) %>%
  summarise(Total_Fatal_Injuries=sum(Total_Fatal_Injuries)) %>%
  arrange(-Total_Fatal_Injuries)
data[!(data$Make %in% fatalities_by_Make$Make[1:5]),]$Make=""


# only keep 10 deadliest Countries
data[data$Country=="",]$Country=NA
fatalities_by_Country = data %>%
  filter(Total_Fatal_Injuries>0) %>%
  group_by(Country) %>%
  summarise(Total_Fatal_Injuries=sum(Total_Fatal_Injuries)) %>%
  arrange(-Total_Fatal_Injuries) 
data[!(data$Country %in% fatalities_by_Country$Country[1:10]),]$Country="Other"


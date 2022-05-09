# install packages
# install.packages(c("dplyr","lubridate"))
library(dplyr)
library(lubridate)

streamH <- read.csv("/cloud/project/activtiy02/stream_gauge.csv")
siteInfo <- read.csv("/cloud/project/activtiy02/site_info.csv")


Floods <- left_join(streamH, siteInfo, by= "siteID")

Floods$dateF <- ymd_hm(Floods$datetime)  

earlier <- Floods %>%
  group_by(names) %>%
  filter(gheight.ft >= flood.ft) %>%
  summarise(min.date = min(dateF), max.ht = max(gheight.ft))


# Select function

VariableA <- select(Floods, names, gheight.ft, datetime)

VariableB <- select(Floods, gheight.ft:dateF)

VariableC <- select(Floods, -datetime, -siteID)


variableE <- select(Floods, contains("e"), -agency)

variableF <- select(Floods, (!(gheight.ft:dateF)))


# hist function
Fisheating_Creek <- Floods[1:2208,]
hist(Fisheating_Creek$gheight.ft, main="Stream gauge height",
     xlab="Water Height")


# example with referencing rows

NewFlood <- Floods %>% arrange(desc(gheight.ft))

# example with select

Floods_mutated <- mutate(Floods, 
                         stage_meter = gheight.ft * 0.3048)


Floods_mutated <- mutate(Floods,  .before= gheight.ft,
                         stage_meter = gheight.ft * 0.3048,
                         percent_flood = (gheight.ft/major.ft)*100)

VariableB <- select(Floods_mutated, datetime:dateF)

VariableC <- select(Floods, datetime:dateF)
# test

# hist function
Fisheating_Creek <- Floods[1:2208,]

Floods <- Floods[Floods$gheight.ft >= Floods$flood.ft,]

Fisheating_Creek <- Floods[1:2208,]


Fisheasting <- Floods[Floods$names == "FISHEATING CREEK AT PALMDALE",]

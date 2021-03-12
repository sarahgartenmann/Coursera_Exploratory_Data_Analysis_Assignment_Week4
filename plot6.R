# Coursera "Exploratory Data Analysis" Assignment Week 4
# March 2021
# Sarah Gartenmann

############################## Loading R Packages ############################## 
library(tidyverse)

############################## Reading in the Data ############################# 

# set working directory and save the downloaded zip into the working directory
# setwd("G:/My Drive/Coursera/4_Exploratory_Data_Analysis")
list.files()

# unzip downloaded file
unzip("exdata_data_NEI_data.zip", exdir = "./Rawdata_unzipped")
list.files("./Rawdata_unzipped")

# Read in the raw data 
NEI <- readRDS("./Rawdata_unzipped/summarySCC_PM25.rds")
SCC <- readRDS("./Rawdata_unzipped/Source_Classification_Code.rds")

# Look at the data
head(NEI)
summary(NEI)
head(SCC)
summary(SCC)

################################## Question 6 ################################## 
# 6. Compare emissions from motor vehicle sources in Baltimore City with 
# emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over 
# time in motor vehicle emissions?

# tidy the data
BaltLA <- NEI %>%
  filter(fips %in% c("24510", "06037") & type == "ON-ROAD") %>%
  group_by(year, fips) %>%
  summarize(.,Emissions = sum(Emissions))

BaltLA$year <- as.factor(BaltLA$year)
BaltLA$fips <- factor(BaltLA$fips, 
                      levels = c("24510", "06037"), 
                      labels = c("Baltimore City", "Los Angeles County"))

# create the plot
plot6 <- ggplot(BaltLA, aes(x = year, y = Emissions, fill = fips)) +
  geom_bar(stat = "identity", position = "dodge") + 
  labs(x = "Year", y = "PM2.5 Emissions (tons)") +
  ggtitle("PM2.5 Emissions in from Motor Vehicles in \n Baltimore City and Los Angeles County") +
  theme(axis.text.x = element_text(), 
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5), 
        legend.title = element_blank(), 
        legend.position = "bottom",
        axis.ticks = element_blank()) +
  scale_fill_manual(values = c("#E69F00", "#56B4E9"))


plot6

# save plot image to file
ggsave("plot6.png")
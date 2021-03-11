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

################################## Question 3 ################################## 
# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
# 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

# tidy the data
Baltimore2 <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarize(.,Emissions = sum(Emissions))

Baltimore2$year <- as.factor(Baltimore2$year)

# create the plot 
plot3 <- ggplot(Baltimore2, aes(x = year, y = Emissions)) + 
  geom_bar(stat = "identity") +
  facet_grid(. ~type) + 
  labs(x = "Year", y = "PM2.5 Emissions (tons)") +
  ggtitle("PM2.5 Emissions in Baltimore by Type") +
  theme(axis.text.x = element_text(angle = 45), 
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5))

plot3
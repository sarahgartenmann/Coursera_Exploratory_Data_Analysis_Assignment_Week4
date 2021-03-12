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

################################## Question 5 ################################## 
# 5. How have emissions from motor vehicle sources changed from 1999-2008 in
# Baltimore City?

# tidy the data
Baltimore5 <- NEI %>%
  filter(fips == "24510" & type == "ON-ROAD") %>%
  group_by(year) %>%
  summarize(.,Emissions = sum(Emissions))

Baltimore5$year <- as.factor(Baltimore5$year)

# create the plot

plot5 <- ggplot(Baltimore5, aes(x = year, y = Emissions)) +
  geom_bar(stat = "identity", fill = "#E69F00") + 
  labs(x = "Year", y = "PM2.5 Emissions (tons)") +
  ggtitle("PM2.5 Emissions in from Motor Vehicles in Baltimore City") +
  theme(axis.text.x = element_text(), 
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5), 
        axis.ticks = element_blank()) 

plot5

# save plot image to file
ggsave("plot5.png")
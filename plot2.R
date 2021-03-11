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

################################## Question 2 ################################## 
# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

Baltimore <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(.,Emissions = sum(Emissions))

# create the plot 
png(filename = "plot2.png")
with(Baltimore, 
     barplot(Emissions, 
             names.arg = year, 
             xlab = "Year", 
             ylab = "Total PM2.5 Emissions (tons)", 
             main = "Total PM2.5 Emissions in Baltimore"))
dev.off()
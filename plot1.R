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

################################## Question 1 ################################## 
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

yeartotal <- NEI %>%
  group_by(year) %>%
  summarize(.,Emissions = sum(Emissions))

# create the plot 
png(filename = "plot1.png")
plot(yeartotal$year, yeartotal$Emissions, 
     type = "l", 
     main = "Total PM2.5 Emissions in the United States", 
     ylab = "Total PM2.5 Emissions (tons)",
     xlab = "Year")
dev.off()
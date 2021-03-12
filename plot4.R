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

################################## Question 4 ################################## 
# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

# identify all SCC containing the term "Coal"
coal <- SCC[grepl("Coal", SCC$"EI.Sector"),]

# tidy the data
year_coal <- NEI %>%
  filter(SCC %in% coal$SCC) %>%
  group_by(year) %>%
  summarize(.,Emissions = sum(Emissions))

year_coal$year <- as.factor(year_coal$year)

# create the plot

plot4 <- ggplot(year_coal, aes(x = year, y = Emissions)) +
  geom_bar(stat = "identity", fill = "#FF6666") + 
  labs(x = "Year", y = "PM2.5 Emissions (tons)") +
  ggtitle("PM2.5 Emissions in from Coal Sources in the United States") +
  theme(axis.text.x = element_text(), 
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(hjust = 0.5), 
        axis.ticks = element_blank())

plot4

# save plot image to file
ggsave("plot4.png")
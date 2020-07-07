#======================================================================
# Course: Exploratory Data Analysis
# Title: Project 2 - PM2.5 Emissions in US for Coal combustion-related
# Subject: Exploratory Data Analysis from PM2.5
# Name: Expedito P. P. Jr
# File: plot4.R
#====================================================================== 
#Load Library
library(ggplot2)

# Read dataset.
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Merge the two dataset in one by SCC code
dtm <- merge(NEI, SCC, by="SCC")

# Get all SCC Lever Four data that Contains Coal as Source
dt <- subset(dtm, grepl("Coal", dtm$SCC.Level.Four))

# Aggregate by mean all measurements separeted by type of Level Four
agr <- aggregate(dt$Emissions, by=list(dt$year), FUN=mean)
colnames(agr) <- c("year", "PM25")

g <- ggplot(agr, aes(x=year, y=PM25))
myplot <- g + geom_point() + geom_smooth(method = "lm", se=TRUE, aes(group=1)) + labs(x="Year") + labs(y="PM2.5 Emission") + labs(title="PM2.5 Emission in US by Coal Combustion")

# Save as file
png("plot4.png" , width = 800, height = 600)
print(myplot)
dev.off()

#=========================================================
# Course: Exploratory Data Analysis
# Title: Project 2 - PM2.5 Emissions in Baltimore by Types
# Subject: Exploratory Data Analysis from PM2.5
# Name: Expedito P. P. Jr
# File: plot3.R
#========================================================= 
# Load Libraries
library(ggplot2)

# Read dataset.
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Get data from Baltimore City
mBalt <- subset(NEI, NEI$fips == "24510")

# Agregate data in Mean for Emission by Type and Year
agr <- aggregate(mBalt$Emissions, by=list(mBalt$type, mBalt$year), FUN=mean)
# Rename Cols
colnames(agr) <- c("type", "year", "PM25")

# Plot using log10 base to evidence the reduction and normalize the scale
g <- ggplot(agr, aes(x=year, y=log10(PM25), color=type))
myplot <- g + geom_point() + geom_smooth(method = "lm", se=TRUE, aes(group=type)) + labs(x="Year") + labs(y="Log10 PM2.5 Emission") + labs(title="PM2.5 Emission in Baltimore City by Type") + labs(color="type")

# Save as file
png("plot3.png" , width = 800, height = 600)
print(myplot)
dev.off()


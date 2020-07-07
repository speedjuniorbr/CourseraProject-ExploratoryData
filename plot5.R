#==================================================================================
# Course: Exploratory Data Analysis
# Title: Project 2 - PM2.5 Emissions in Baltimore City for Motor Vehicle Emissions
# Subject: Exploratory Data Analysis from PM2.5
# Name: Expedito P. P. Jr
# File: plot5.R
#================================================================================== 
#Load Library
library(ggplot2)

# Read dataset.
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Merge the two dataset in one by SCC code
dtm <- merge(NEI, SCC, by="SCC")

# Get from Baltimore City
dtBalt <- subset(dtm, dtm$fips == "24510")

dtMotor <- subset(dtBalt, grepl("Motor", dtBalt$SCC.Level.Three))
dtVehicle <- subset(dtBalt, grepl("Vehicle", dtBalt$SCC.Level.Three))

# Merge in row Motor and Vehicle found
dt <- rbind(dtMotor, dtVehicle)

# Aggregate Data by year in mean function
agr <- aggregate(dt$Emissions, by=list(dt$year), FUN=mean)
colnames(agr) <- c("year", "PM25")

# Plot data
g <- ggplot(agr, aes(x=year, y=PM25))
myplot <- g + geom_point() + geom_smooth(method ="lm", se=TRUE, aes(group=1)) + labs(x="Year") + labs(y="PM2.5 Emission") + labs(title="PM2.5 Emission in Baltimore City by Motor Vehicle Sources")

# Save as file
png("plot5.png" , width = 800, height = 600)
print(myplot)
dev.off()

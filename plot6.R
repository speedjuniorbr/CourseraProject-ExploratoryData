#==================================================================================
# Course: Exploratory Data Analysis
# Title: Project 2 - PM2.5 Emissions in Baltimore City for Motor Vehicle Emissions
#        comparing with Los Angeles
# Subject: Exploratory Data Analysis from PM2.5
# Name: Expedito P. P. Jr
# File: plot6.R
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

dtMotorBalt <- subset(dtBalt, grepl("Motor", dtBalt$SCC.Level.Three))
dtVehicleBalt <- subset(dtBalt, grepl("Vehicle", dtBalt$SCC.Level.Three))

# Merge in row Motor and Vehicle found
dtBalt <- rbind(dtMotorBalt, dtVehicleBalt)

# Aggregate Data by year in mean function
agrBalt <- aggregate(dtBalt$Emissions, by=list(dtBalt$year, dtBalt$fips), FUN=mean)
colnames(agrBalt) <- c("year", "city", "PM25")


# Get from Baltimore City
dtLA <- subset(dtm, dtm$fips == "06037")

dtMotorLA <- subset(dtLA, grepl("Motor", dtLA$SCC.Level.Three))
dtVehicleLA <- subset(dtLA, grepl("Vehicle", dtLA$SCC.Level.Three))

# Merge in row Motor and Vehicle found
dtLA <- rbind(dtMotorLA, dtVehicleLA)

# Aggregate Data by year in mean function
agrLA <- aggregate(dtLA$Emissions, by=list(dtLA$year, dtLA$fips), FUN=mean)
colnames(agrLA) <- c("year", "city", "PM25")

agr <- rbind(agrBalt, agrLA)
agr$city[agr$city == "24510"] <- "Baltimore City"
agr$city[agr$city == "06037"] <- "Los Angeles"

# Plot data
g <- ggplot(agr, aes(x=year, y=log10(PM25), color=city))
myplot <- g + geom_point() + geom_smooth(method ="lm", se=TRUE, aes(group=city)) + labs(x="Year") + labs(y="PM2.5 Emission (log10)") + labs(title="PM2.5 Emission Baltimore City X Los Angeles by Motor Vehicle Sources")

# Save as file
png("plot6.png" , width = 800, height = 600)
print(myplot)
dev.off()

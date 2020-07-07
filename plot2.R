#================================================
# Course: Exploratory Data Analysis
# Title: Project 2 - PM2.5 Emissions in Baltimore
# Subject: Exploratory Data Analysis from PM2.5
# Name: Expedito P. P. Jr
# File: plot2.R
#================================================ 

# Read dataset.
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Get data from Baltimore City 
dt <- subset(NEI, NEI$fips == "24510")

# Get mean emissions by year
m <- tapply(NEI$Emissions, NEI$year, mean)

# Organize data frame
dt <- data.frame(PM25=m, year=names(m))

# Create Smooth line to get tendence
fit <- lm(PM25~year, data=dt)


# Plot emissions by year in Baltimore City
plot(dt$year, dt$PM25, ylab="Total Emission PM2.5", xlab="Year", main ="PM2.5 Emissions in Baltimore City")
s = smooth.spline(dt$year, dt$PM25, spar = 0.35)
lines(s, col="red")
dev.copy(png, file="plot2.png" , width = 800, height = 600)
dev.off()

#================================================
# Course: Exploratory Data Analysis
# Title: Project 2 - PM2.5 Emissions in US
# Subject: Exploratory Data Analysis from PM2.5
# Name: Expedito P. P. Jr
# File: plot1.R
#================================================ 

# Read dataset.
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Get mean emissions by year
m <- tapply(NEI$Emissions, NEI$year, mean)
dt <- data.frame(PM25=m, year=names(m))
fit <- lm(PM25~year, data=dt)


# Plot mean emissions by year
plot(dt$year, dt$PM25, ylab="Total Emission PM2.5", xlab="Year", main ="PM2.5 Emissions in US")
s = smooth.spline(dt$year, dt$PM25, spar = 0.35)
lines(s, col="red")
dev.copy(png, file="plot1.png" , width = 800, height = 600)
dev.off()

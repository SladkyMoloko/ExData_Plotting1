#read in the data file
electricpc <- read.table("household_power_consumption.txt", sep=";", header = TRUE)
#subset the two days of interest
day1 <- electricpc[electricpc$Date == "1/2/2007",]
day2 <- electricpc[electricpc$Date == "2/2/2007",]
#bind the two days' data into one data table
epc <- rbind(day1,day2)
#Convert the ?s to NAs, and remove them
epc[epc == "?"] = NA
na.omit(epc)

#A function converting factor to numeric
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
#Getting the values we want to plot
GAP <- as.numeric.factor(epc$Global_active_power)

hist(GAP, breaks = 16, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red",  width=480, height=480, cex.axis = 0.7, cex.lab = 0.7, cex.main = 0.9)

#Create the .png file
dev.copy(png, file = "plot1.png")
dev.off()
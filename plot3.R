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

#Getting the appropriate date/time format
epc$DateTime <- paste(epc$Date,epc$Time)
Time <- strptime(epc$DateTime, "%d/%m/%Y %H:%M:%S")

#A function converting factor to numeric
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
#Getting the values we want to plot
Sub1 <- as.numeric.factor(epc$Sub_metering_1)
Sub2 <- as.numeric.factor(epc$Sub_metering_2)
Sub3 <- as.numeric.factor(epc$Sub_metering_3)

plot(Time, Sub1, type = "l", ylab = "Energy sub metering", xlab = "", ylim = c(0, max(Sub1)), width=480, height=480, cex.lab = 0.7)
par(new = TRUE)
plot(Time, Sub2, type = "l", cex.lab = 0.7, ylab = "", xlab = "", ylim = c(0, max(Sub1)), width=480, height=480, col = "red")
par(new = TRUE)
plot(Time, epc$Sub_metering_3, type = "l", cex.lab = 0.7, ylab = "", xlab = "", ylim = c(0, max(Sub1)), width=480, height=480, col = "blue")
legend("topright", col = c("black","red","blue"), lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6, xpd=TRUE)

#Create the .png file
dev.copy(png, file = "plot3.png")
dev.off()


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
GAP <- as.numeric.factor(epc$Global_active_power)
Volt <- as.numeric.factor(epc$Voltage)
GRP <- as.numeric.factor(epc$Global_reactive_power)

#Creating the graph

par(mfrow = c(2,2))

plot(Time, GAP, type="l", ylab="Global Active Power", xlab = "", cex.lab=0.7)

plot(Time, Volt, type="l", ylab="Voltage", xlab="datetime", cex.lab=0.7)

plot(Time, Sub1, type = "l", ylab = "Energy sub metering", xlab = "", ylim = c(0, max(Sub1)), cex.lab = 0.7)
par(new = TRUE)
plot(Time, Sub2, type = "l", cex.lab = 0.7, ylab = "", xlab = "", ylim = c(0, max(Sub1)), col = "red")
par(new = TRUE)
plot(Time, epc$Sub_metering_3, type = "l", cex.lab = 0.7, ylab = "", xlab = "", ylim = c(0, max(Sub1)), col = "blue")
legend("topright", col = c("black","red","blue"), lty = 1, bty="n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6, xpd=TRUE)

plot(Time, GRP, type="l", ylab="Global_reactive_power", xlab="datetime", cex.lab=0.7)

#Create the .png file
dev.copy(png, file = "plot4.png")
dev.off()


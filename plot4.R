## downlod the zip folder, extract, and place the "household_power_consumption.txt" file in the same folder as the script

library(dplyr)
library(lubridate)
data <- read.csv("household_power_consumption.txt", sep = ";")  #reading the data
data$Date <- dmy(data$Date) # converting date into date format
data$Time <- hms(data$Time) # converting time into time format
final <- data %>% filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02")) # filter to get required time frame
final <- final %>% mutate(DateTime = Date + Time) # add new column containing date and time
final$Global_active_power <- sapply(final$Global_active_power,as.numeric) # change values to numeric
final$Sub_metering_1 <- sapply(final$Sub_metering_1,as.numeric) # change values to numeric
final$Sub_metering_2 <- sapply(final$Sub_metering_2,as.numeric) # change values to numeric
final$Sub_metering_3 <- sapply(final$Sub_metering_3,as.numeric) # change values to numeric
final$Voltage <- sapply(final$Voltage,as.numeric) # change values to numeric
final$Global_reactive_power <- sapply(final$Global_reactive_power,as.numeric) # change values to numeric


png(file="plot4.png", width = 480, height = 480) # initialize figure as PNG

par(mfrow = c(2,2))

# plot 1st figure

plot(final$DateTime,final$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n") # set the figure and set its properties
lines(final$DateTime,final$Global_active_power) # plot the data 

# plot 2nd figure

plot(final$DateTime,final$Voltage, xlab = "datetime", ylab = "Voltage", type = "n") # set the figure and set its properties

lines(final$DateTime,final$Voltage) # plot the data

# plot 3rd figure

plot(final$DateTime,final$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n") # create PNG file
lines(final$DateTime,final$Sub_metering_1, col = "black") # plot the data
lines(final$DateTime,final$Sub_metering_2, col = "red") # plot the data
lines(final$DateTime,final$Sub_metering_3, col = "blue") # plot the data
legend("topright", lty = 1, col = c("black","red", "blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")


# plot 4th figure

plot(final$DateTime,final$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n") # set the figure and set its properties

lines(final$DateTime,final$Global_reactive_power) # plot the data

dev.off() # save results to PNG file


## downlod the zip folder, extract, and place the "household_power_consumption.txt" file in the same folder as the script

library(dplyr)
library(lubridate)
data <- read.csv("household_power_consumption.txt", sep = ";")  #reading the data
data$Date <- dmy(data$Date) # converting date into date format
data$Time <- hms(data$Time) # converting time into time format
final <- data %>% filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02")) # filter to get required time frame
final <- final %>% mutate(DateTime = Date + Time) # add new column containing date and time
final$Global_active_power <- sapply(final$Global_active_power,as.numeric) # change values to numeric
hist(final$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power") # plot the figure and set its properties
dev.copy(png,file="plot1.png", width = 480, height = 480) # save figure as PNG
dev.off()

# 
# 
# A script to generate a PNG plot of global active power usage over a two-day
# period, February 1 - 2, 2007, drawn from the UC Irvine Machine Learning
# Repository, Electric Power Consumption data set
# 

require(data.table)

# 
# Read the power consumption data into a data table and extract the subset of
# interest. Initially read columns as character to get around a an fread() bug
# with non-empty NA characters and then convert the columns to their proper
# types.
# 

dataset <- fread("household_power_consumption.txt",
                 sep=";", 
                 na.strings=c("?"),
                 colClasses=c("character"))

powerset <- dataset[dataset[ , ((Date == "1/2/2007") | (Date == "2/2/2007"))]]
powerset[ , `:=` (Global_active_power = as.numeric(Global_active_power),
                 Global_reactive_power = as.numeric(Global_reactive_power),
                 Voltage = as.numeric(Voltage),
                 Global_intensity = as.numeric(Global_intensity),
                 Sub_metering_1 = as.numeric(Sub_metering_1),
                 Sub_metering_2 = as.numeric(Sub_metering_2),
                 Sub_metering_3 = as.numeric(Sub_metering_3),
                 dateTime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))]
                 
rm(dataset)

#
# Let's make a plot! Plot global active power over the two-day period using a line graph.
#

png("plot2.png", width=480, height=480, units="px")
with(powerset, plot(dateTime, Global_active_power, 
                    type="l",
                    ylab="Global Active Power (kilowatts)",
                    xlab=""))
dev.off()

rm(powerset)
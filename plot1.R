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
                 Sub_metering_3 = as.numeric(Sub_metering_3))]
                 
rm(dataset)

#
# Let's make a plot! Plot global active power vs frequency using a histogram
#

png("plot1.png", width=480, height=480, units="px")
with(powerset, hist(Global_active_power, 
                    main="Global Active Power",
                    xlab="Global Active Power (kilowatts)",
                    col="red"))
dev.off()

rm(powerset)
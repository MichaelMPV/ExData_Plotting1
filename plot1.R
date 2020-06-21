data_tabla <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## update the format of date. Use  as.Date
## Filter data in Feb. 1, 2007 to Feb. 2, 2007
## removed unused data
data_tabla$Date <- as.Date(data_tabla$Date, "%d/%m/%Y")
data_tabla <- subset(data_tabla,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data_tabla <- data_tabla[complete.cases(data_tabla),]
dateTime <- paste(data_tabla$Date, data_tabla$Time)

#select data column Date and Time
#Add DateTime column
dateTime <- setNames(dateTime, "DateTime")
data_tabla <- data_tabla[ ,!(names(data_tabla) %in% c("Date","Time"))]
data_tabla <- cbind(dateTime, data_tabla)

## Format dateTime Column
data_tabla$dateTime <- as.POSIXct(dateTime)

# PLOT 1
hist(data_tabla$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
# SAVE PLOT 1
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

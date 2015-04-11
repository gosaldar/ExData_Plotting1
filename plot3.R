# Find energy usage between 1-2 February 2007
file = "household_power_consumption.txt"
i <- grep("^[1-2]/2/2007", readLines(file))
j <- range(i) - 1
rm(i)
# Read data into a dataframe
rskip <- j[1] - 1
rread <- j[2] - rskip
df <- read.table(file, sep = ";", skip = rskip, nrows = rread)
# Field Name
names(df) <- unlist(strsplit(readLines(file, 1), ";"))
# Date & Time
df$Time <- strptime(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Plotting

png("plot3.png", width = 480, height = 480, bg = "transparent")

with(df, {
  plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(Time, Sub_metering_2, type = "l", col = "red")
  lines(Time, Sub_metering_3, type = "l", col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
})

graphics.off()
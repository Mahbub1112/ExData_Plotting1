
#Reading the data
d = read.table("household_power_consumption.txt", sep=";", header = TRUE, colClasses = rep("character",9))

#We'll find "?" and convert it into NAs
d[d == "?"] <- NA

#convertind dates in right format
d$Date <- as.Date(d$Date, format = "%d/%m/%Y")

#subseting required rows
df <- d[d$Date >= as.Date("2007-02-01") & d$Date <= as.Date("2007-02-02"),]

# converting the variable into correct class for plotting
df$Global_active_power <- as.numeric(DT$Global_active_power)

#opening graphics file device : png
png(file = "plot1.png", width = 480, height = 480, units = "px")

#making histogram
hist(df$Global_active_power,
col = "red",
main = "Global Active Power",
xlab = "Global Active Power (kilowatts)")

#closing the graphics device
dev.off()
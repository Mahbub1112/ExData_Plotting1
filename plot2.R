


#Reading the data
d = read.table("household_power_consumption.txt", sep=";", header = TRUE, colClasses = rep("character",9))

#We'll find "?" and convert it into NAs
d[d == "?"] <- NA

#convertind dates in right format
d$Date <- as.Date(d$Date, format = "%d/%m/%Y")

#subseting required rows
df <- d[d$Date >= as.Date("2007-02-01") & d$Date <= as.Date("2007-02-02"),]


#adding a new column in df by joining date and time
df$posix <- as.POSIXct(strptime(paste(df$Date, df$Time, sep = " "),
                                format = "%Y-%m-%d %H:%M:%S"))

# converting the variable into correct class for plotting
df$Global_active_power <- as.numeric(df$Global_active_power)

#opening png graphics device
png(file = "plot2.png", width = 480, height = 480, units = "px")

#making the plot
with(df,
     plot(posix,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

# Closing the png file device
dev.off() 
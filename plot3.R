
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


#opening png graphics devic
png(file = "plot3.png", width = 480, height = 480, units = "px")

#making the plot
with(df,
     plot(posix,
          Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
with(df,
     points(posix,
            type = "l",
            Sub_metering_2,
            col = "red")
)
with(df,
     points(posix,
            type = "l",
            Sub_metering_3,
            col = "blue")
)
legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)


# Close the png file device
dev.off()  
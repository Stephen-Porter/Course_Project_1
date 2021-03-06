#plot4.r
#Please have your current directory set to where you would like the files

# Download and read .zip data file.

# Download data file and unzip into current directory
zipfile <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",zipfile)
unzip(zipfile, files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)
unlink(zipfile)


# Read in file delimited by ; and set any ? to NA values
power <- read.delim("household_power_consumption.txt", header = TRUE, 
                    sep = ";", na.strings = "?", dec = ".")

# convert the Date column's datatype from string to date 
power$Date <- as.Date(power$Date,'%d/%m/%Y') 

#Subest the data to the two days of desired data
power <- subset(power, Date == '2007-02-01' | Date == '2007-02-02') 

#Create a variable dt to hold character values of date and time
power$dt <- paste(as.character(power$Date),  as.character(power$Time))

#Use strip time to create a variable datetime as POSIXlt format
power$datetime <- strptime(power$dt, "%Y-%m-%d %H:%M") # create a datetime object


#plot 4

#open plot4.png with dimensions 480 x 480
png("plot4.png", width = 480, height = 480)
#genrete line plot of Global Active Power over time
par(mfrow = c(2, 2)) #confifure to make 4 plots on one page
with(power, { 
            plot(datetime, Global_active_power, type = "l", 
            xlab = "", ylab = "Global Active Power (kilowatts)") #top left plot
    
            plot(datetime, Voltage, type = "l") #top right plot
    
            plot(datetime, Sub_metering_1, type = "l", #bottom left plot
            xlab = "", ylab = "Energy sub metering")
            lines(datetime, Sub_metering_2, col = "red")
            lines(datetime, Sub_metering_3, col = "blue")
            legend("topright", col = c("black","blue", "red"), lty = c(1,1,1), 
                   legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

            plot(datetime, Global_reactive_power, type = "l") # bottom right plot
}) 

#close file
dev.off()





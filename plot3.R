### Need this to get correct day names
Sys.setlocale("LC_TIME", "English")

### Load and prepare Data

## load only  nessesary lines (checked before)
power <- read.csv2("household_power_consumption.txt", 
                   stringsAsFactors = FALSE,
                   skip = 66637,
                   nrow = 2880,
                   header = F)
titles <- read.csv2("household_power_consumption.txt", 
                    stringsAsFactors = FALSE,
                    nrow = 1, 
                    header = F)
names(power) <- titles[1,]

power$Time <- as.POSIXct(paste(power$Date, power$Time), format="%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, '%d/%m/%Y')

## we have loaded only correct lines but lets check it anyway
ld <- as.Date('2007-02-01')
hd <- as.Date('2007-02-02')
power <- power[power$Date >= ld & power$Date <= hd, ]

suppressWarnings(power$Global_active_power <- as.numeric(power$Global_active_power))

### Plot 3
### ==========================

png(filename = "plot3.png", 
    width = 480, 
    height = 480, 
    units = "px")

plot(power$Time, 
     power$Sub_metering_1,
     type= 'l',
     main = "",
     xlab = "",
     ylab = "Energy sub metering")

points(power$Time, 
       power$Sub_metering_2, 
       type = 'l', 
       col = "blue")

points(power$Time, 
       power$Sub_metering_3, 
       type = 'l', 
       col = "red")

legend("topright", 
       pch = 1, 
       col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
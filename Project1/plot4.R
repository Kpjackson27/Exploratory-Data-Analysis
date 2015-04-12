##Read Data from files
##Add header
##Specify NA values
inputData <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

##
inputData$Date <- as.Date(inputData$Date, format="%d/%m/%Y")

## Subsetting the data
##Check to see if Date is within specified range
##Utilized http://stackoverflow.com/questions/14790943/subset-a-data-by-date-to-create-the-summary-in-r 
##For subsetting help
dataSubset <- subset(inputData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Convert date values using the time
dataTime <- paste(as.Date(dataSubset$Date), dataSubset$Time)
dataSubset$Datetime <- as.POSIXct(dataTime)

##Display multiple plots
par(mfrow=c(2,2))
##Create multiplte plots
  plot(dataSubset$Global_active_power~dataSubset$Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(dataSubset$Voltage~dataSubset$Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(dataSubset$Sub_metering_1~dataSubset$Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  lines(dataSubset$Sub_metering_2~dataSubset$Datetime,col='Red')
  lines(dataSubset$Sub_metering_3~dataSubset$Datetime,col='Blue')
 ##Legend for plots
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(dataSubset$Global_reactive_power~dataSubset$Datetime, type="l", 
       ylab="Global_rective_power",xlab="datetime")


##Print plot to PNG file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
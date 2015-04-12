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

## Create histogram plot
##Heading : Global Active Power
## y axis: Frequency
## x axis: Global Active Power in kilowatts
hist(dataSubset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

##Save Plot to a file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
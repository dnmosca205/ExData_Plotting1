getData <- function(doPlot){
    
    print("prepare required packages")
    install.packages("downloader")
    require(downloader)
    
    url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    print("test existence of zip file")
    if (!file.exists("power_data.zip")) {
    
         print("zip file doesnt exist")
         
         print("download zip file")
         download(url,destfile="power_data.zip", mode="wb")
         
         print("unzip file")
         unzip("power_data.zip")      
    }
     
    print("read power consumption file and put to power_data variable")
    power_data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")
    
    print("subset power data")
    power_data <- subset(power_data, Date == "1/2/2007" | Date == "2/2/2007")

    power_data$DateTime <- strptime(paste(power_data$Date, power_data$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")
          
    doPlot(power_data)
     
}

plotData <-function(power_data){

   print("set png device channel")
   png(filename="plot4.png", width=480, height=480)

   print("draw plot")

   par(mfcol=c(2,2))
   with(power_data,
   { plot(DateTime, Global_active_power, type="l",col="black", xlab="", ylab="Global Active Power (kilowatts)")
     plot(DateTime, Sub_metering_1, type="l",col="black", xlab="", ylab="Energy sub metering")
     lines(DateTime, Sub_metering_2, col="red")
     lines(DateTime, Sub_metering_3, col="blue")
     legend("topright", lwd=1, lty=1, col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(DateTime, Voltage, type="l",col="black", xlab="datetime", ylab="Voltage")
     plot(DateTime, Global_reactive_power, type="l",col="black", xlab="datetime", ylab="Global_reactive_power")
   })   

   print("close png device channel")
   dev.off()


}

print("begin plot4")
getData(plotData)

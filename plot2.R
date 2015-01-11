getData <- function(doPlot){
    
    print("prepare  required packages")
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
   png(filename="plot2.png", width=480, height=480)

   print("draw plot")
   plot(power_data$DateTime, power_data$Global_active_power, type="l",col="black", xlab="", ylab="Global Active Power (kilowatts)")

   print("close png device channel")
   dev.off()

}

print("begin plot2")
getData(plotData)
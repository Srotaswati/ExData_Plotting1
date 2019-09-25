##Reading the file
if (!file.exists("getdata2.zip")){
  fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl,"getdata2.zip",method="curl")
}
if (!file.exists("household_power_consumption.txt")) { 
  unzip("getdata2.zip",exdir="./data") 
}

## Reading the table only for specific dates
library(data.table)
data<-fread("./data/household_power_consumption.txt",select = 1,sep = ";")
row1<-min(grep("1/2/2007",data$Date))
row2<-max(grep("^2/2/2007",data$Date))
data<-read.table("./data/household_power_consumption.txt",sep=";",skip=row1,nrows = row2-row1+1)

##Preparing the dataset
names(data)<-c("Date","dateime","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

##Plot 1
png(filename = "plot1.png",width = 480,height = 480,units = "px")
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
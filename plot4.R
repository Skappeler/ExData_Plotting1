#COURSE PROJECT 1, EXPLORATORY DATA ANALYSIS

#Getting and cleaning the data
#*******************************
# !!! First, download the data from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and save the text file "household_power_consumption.txt" in your working directory

#read from the working directory in R
data<-read.table("household_power_consumption.txt", header=TRUE,sep=";")

#Add a variable "DataTime" to the dataframe (from the variable "Date" and "Time")
data$Date<-as.character(data$Date)
data$Time<-as.character(data$Time)
library(dplyr)
data2<-mutate(data,DateTime=paste(data$Date,data$Time))
#Convert the variable "DataTime" into "POSIXlt" "POSIXt"
data2$DateTime<-strptime(data2$DateTime,"%d/%m/%Y %H:%M:%S")


#subsetting the data
start<-as.Date("2007-02-01")
end<-as.Date("2007-02-02")
dataset<-subset(data2,(as.Date(data2$DateTime)>=start & as.Date(data2$DateTime)<=end))

#convert factors to numeric
dataset$Global_active_power<-as.numeric(as.character(dataset$Global_active_power))
dataset$Sub_metering_1<-as.numeric(as.character(dataset$Sub_metering_1))
dataset$Sub_metering_2<-as.numeric(as.character(dataset$Sub_metering_2))
dataset$Sub_metering_3<-as.numeric(as.character(dataset$Sub_metering_3))
dataset$Voltage<-as.numeric(as.character(dataset$Voltage))
dataset$Global_reactive_power<-as.numeric(as.character(dataset$Global_reactive_power))


#Making Plots
#*******************************
#examine how household energy usage varies over a 2-day period in February, 2007.


#PLOT 4
png(file="plot4.png",width = 480, height = 480)
opar <- par() #save a copy of the actual par setting
par(mfrow=c(2,2))
#plot 1,1
plot(dataset$DateTime,dataset$Global_active_power,type="n",ylab="Global Active Power",xlab=NA)
lines(dataset$DateTime,dataset$Global_active_power)

#plot 1,2
plot(dataset$DateTime,dataset$Voltage,type="n",ylab="Voltage",xlab="datetime")
lines(dataset$DateTime,dataset$Voltage)

#plot 2,1
plot(dataset$DateTime,dataset$Sub_metering_1,type="n",ylab="Energy Sub Metering",xlab=NA)
lines(dataset$DateTime,dataset$Sub_metering_1)
lines(dataset$DateTime,dataset$Sub_metering_2,col="red")
lines(dataset$DateTime,dataset$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty="n")

#plot 2,2
plot(dataset$DateTime,dataset$Global_reactive_power,type="n",ylab="Global_reactive_power",xlab="datetime")
lines(dataset$DateTime,dataset$Global_reactive_power)

dev.off()
options(warn=-1) #avoid the warning message by the par restablishment
par(opar) #restablish the saved par setting 
options(warn=-0) 
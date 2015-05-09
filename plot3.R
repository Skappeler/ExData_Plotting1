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
dataset$Sub_metering_1<-as.numeric(as.character(dataset$Sub_metering_1))
dataset$Sub_metering_2<-as.numeric(as.character(dataset$Sub_metering_2))
dataset$Sub_metering_3<-as.numeric(as.character(dataset$Sub_metering_3))


#Making Plots
#*******************************
#examine how household energy usage varies over a 2-day period in February, 2007.


#PLOT 3
png(file="plot3.png",width = 480, height = 480)
plot(dataset$DateTime,dataset$Sub_metering_1,type="n",ylab="Energy Sub Metering",xlab=NA)
lines(dataset$DateTime,dataset$Sub_metering_1)
lines(dataset$DateTime,dataset$Sub_metering_2,col="red")
lines(dataset$DateTime,dataset$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
dev.off()

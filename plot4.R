# Read in the data
setwd("C:\\Users\\Chris\\Desktop\\Coursera EDA")
dat <- read.csv("household_power_consumption.txt",sep=";")

#We want to choose only certain dates.  Convert all the date information
# using as.Date, and then select only those records on the desired
# dates using a boolean vector.
thedates <- as.Date(dat$Date,"%d/%m/%Y")
selectdates <- thedates == "2007-02-01" | thedates == "2007-02-02"
selectdata <- dat[selectdates,]

#At this point we have the desired records.  Next let's create
# plot 2.
#First let's get our times and dates sorted out.
times <- paste(selectdata$Date,selectdata$Time,sep=" ")
times <- strptime(times,format="%m/%d/%Y %H:%M:%S")
#Next we convert our measurements to numbers
gap <- as.numeric(as.character(selectdata$Global_active_power))
gap <- gap[!is.na(gap)]
vol <- as.numeric(as.character(selectdata$Voltage))
vol <- vol[!is.na(vol)]
sm1 <- as.numeric(as.character(selectdata$Sub_metering_1))
sm2 <- as.numeric(as.character(selectdata$Sub_metering_2))
sm3 <- as.numeric(as.character(selectdata$Sub_metering_3))
sm1 <- sm1[!is.na(sm1)]
sm2 <- sm2[!is.na(sm2)]
sm3 <- sm3[!is.na(sm3)]
grp <- as.numeric(as.character(selectdata$Global_reactive_power))
grp <- grp[!is.na(grp)]

# Looking ahead, we need to label the horizontal axis.  The challenge
# here is that we don't know exactly when Friday starts.  So we look for Friday.
fridaystartindex <- match("2007-02-02 00:00:00",times)

# Now make the plot.
# First set up the subplots
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
# Upper left plot
plot(gap,type="l",lty=1,main="",axes=FALSE,xlab="",ylab="")
title(ylab="Global Active Power (kilowatts)")
axis(1,at=c(0,fridaystartindex,length(times)),labels=c("Thu","Fri","Sat"))
axis(2,at=c(0,2,4,6), labels=c(0,2,4,6))
box()
# Upper right plot
plot(vol,type="l",lty=1,main="",axes=FALSE,xlab="",ylab="")
title(xlab="datetime",ylab="Voltage")
axis(1,at=c(0,fridaystartindex,length(times)),labels=c("Thu","Fri","Sat"))
axis(2,at=seq(from=234,to=246,by=4))
box()
# Lower left plot
plot(sm1,type="l",col="black",lty=1,main="",axes=FALSE,xlab="",ylab="",ylim=range(sm1,sm2,sm3))
par(new=T)
plot(sm2,type="l",col="red",lty=1,main="",axes=FALSE,xlab="",ylab="",ylim=range(sm1,sm2,sm3))
par(new=T)
plot(sm3,type="l",col="blue",lty=1,main="",axes=FALSE,xlab="",ylab="",ylim=range(sm1,sm2,sm3))
par(new=F)
title(ylab="Energy sub metering")
axis(1,at=c(0,fridaystartindex,length(times)),labels=c("Thu","Fri","Sat"))
axis(2,at=seq(from=0,to=30,by=10))
box()
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black","red","blue"),bty="n")
# Lower left plot
plot(grp,type="l",lty=1,main="",axes=FALSE,xlab="",ylab="")
title(xlab="datetime",ylab="Global_reactive_power")
axis(1,at=c(0,fridaystartindex,length(times)),labels=c("Thu","Fri","Sat"))
axis(2,at=seq(from=0.0,to=0.5,by=0.1))
box()
dev.off()

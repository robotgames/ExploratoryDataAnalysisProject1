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
cdata <- as.character(selectdata$Global_active_power)
ndata <- as.numeric(cdata)
kwdata <- ndata[!is.na(ndata)]
times <- times[!is.na(ndata)]

# Looking ahead, we need to label the horizontal axis.  The challenge
# here is that we don't know exactly when Friday starts (and we don't
# want to assume it begins halfway through the data, because we may have
# removed some records if the data was "?").  So we look for Friday.
fridaystartindex <- match("2007-02-02 00:00:00",times)

# Now make the plot.
png("plot2.png", width=480, height=480)
plot(kwdata,type="l",lty=1,main="",axes=FALSE,xlab="",ylab="")
title(ylab="Global Active Power (kilowatts)")
axis(1,at=c(0,fridaystartindex,length(times)),labels=c("Thu","Fri","Sat"))
axis(2,at=c(0,2,4,6), labels=c(0,2,4,6))
box()
dev.off()

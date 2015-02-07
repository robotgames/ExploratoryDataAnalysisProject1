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
# plot 1.
cdata <- as.character(selectdata$Global_active_power)
ndata <- as.numeric(cdata)
ndata <- ndata[!is.na(ndata)]
png("plot1.png", width=480, height=480)
hist(ndata,col="red",main="",xlab="",breaks=seq(from=0, to=7.5,by=0.5),axes=FALSE)
title(main = "Global Active Power",xlab="Global Active Power (kilowatts)")
axis(1,at=c(0,2,4,6), labels=c(0,2,4,6))
axis(2,at=seq(from=0, to=1200, by=200), labels=seq(from=0, to=1200, by=200))
dev.off()

#plot-2 Energy Sub metering for all three
#sub_metering_1 : black
#sub_metering_2 : red
#sub_metering_3 : blue

#data download and unzip
zipfileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipfileURL,"data.zip")
unzip(zipfile = "data.zip",exdir = "data")

# dates to be examined for household energy
reqdDates<-as.Date(c("2007-02-01","2007-02-02"),format="%Y-%m-%d")

#read the data from the .txt file
df<-read.table("data/household_power_consumption.txt",header = TRUE,sep=";")
df[,1]<-as.Date(df[,1],format = "%d/%m/%Y")
df<-df[df$Date==reqdDates[1] | df$Date==reqdDates[2],]

#subset the two day required data
df[,3]<-as.numeric(df[,3])
df$Time<-as.POSIXlt(paste(df$Date,df$Time),format="%Y-%m-%d %H:%M:%S")

#generate the png file of the required plot
png(filename = "./plots/plot4.png",width = 480,height = 480)

par(mfrow=c(2,2),)

#row: 1 ; col: 1
plot(df$Time,df$Global_active_power,type = "l",ylab = "Global Active Power",xlab="")

#row: 1 ; col: 2
plot(df$Time,df$Voltage,type = "l",ylab = "Voltage",xlab="datetime")

#row: 2 ; col: 1
plot(df$Time,df$Sub_metering_1,type="n",ylab="Energy Sub Metering",xlab = "")
points(df$Time,df$Sub_metering_1,type="l",col="black")
points(df$Time,df$Sub_metering_2,type="l",col="red")
points(df$Time,df$Sub_metering_3,type="l",col="blue")
legend("topright",lty = c(1,1,1),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),bty="n",cex = 0.5)

#row: 2 ; col: 2
plot(df$Time,df$Global_reactive_power,type = "l",ylab = "Global_reactive_power",xlab="datetime")

dev.off()
#plot-2 continuous plot of Global Active Power(kilowatts) for a two day period
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
png(filename = "./plots/plot2.png",width = 480,height = 480)
plot(df$Time,df$Global_active_power,type = "l",ylab = "Global Active Power(kilowatts)",xlab="")
dev.off()
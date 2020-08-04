#plot-1 Global Active Power : Frequency ~ Global Active Power
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

#generate the png file of the required plot
png(filename = "./plots/plot1.png",width = 480,height = 480)
hist(df$Global_active_power,col="red",xlab = "Global Active Power(kilowatts)",ylab = "Frequency",main = "Global Active Power")
dev.off()
#download dataset and unzip
filename <- "dataviz_proj1data.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
}  

if (!file.exists("dataviz_proj1data")) { 
  unzip(filename) 
}

#load all txt files in zip 
list.files("./household_power_consumption.txt")

#define path
path = file.path("household_power_consumption.txt")

#read table
whole_table <- read.table(path, header = TRUE, sep = ";")

#narrowing down to 2007 data
new_table <- subset(whole_table, whole_table$Date == "1/2/2007" | whole_table$Date=="2/2/2007")

#duplicate just in case
table2 <- new_table 

#coercing date and time
table2$Date <- as.Date(table2$Date, tryFormats = c("%d/%m/%Y")) #date
table2$Time <- strptime(table2$Time, format = "%T") #now includes date in current locale too. 
table2[1:1440,"Time"] <- format(table2[1:1440,"Time"],"2007-02-01 %H:%M:%S") #remove date in current locale
table2[1441:2880,"Time"] <- format(table2[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#plot graph (top left)
plot(table2$Time,as.numeric(as.character(table2$Global_active_power)), type = "l" , xlab = "",ylab = "Global Active Power (kilowatts)")

#plot graph (top right)
plot(table2$Time,as.numeric(as.character(table2$Voltage)),type="l",xlab="datetime",ylab="Voltage") 

#plot graph (bottom left)
par(mfrow = c(1,1))
plot(table2$Time, table2$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering") 
with(table2, lines(Time, as.numeric(as.character(Sub_metering_1)), col = "black")) 
with(table2, lines(Time, as.numeric(as.character(Sub_metering_2)), col = "red"))
with(table2, lines(Time, as.numeric(as.character(Sub_metering_3)), col = "blue"))
#add legend
leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
col.txt <- c("black", "red","blue")
legend("topright", lty = 1, col = col.txt, legend = leg.txt)

#plot graph (bottom right)
plot(table2$Time,as.numeric(as.character(table2$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power") 

#initiate multiple base plots 
par(mfrow = c(2, 2))

#add 4 plots to canvas 
with(table2, {
  plot(table2$Time,as.numeric(as.character(table2$Global_active_power)), type = "l" , xlab = "",ylab = "Global Active Power (kilowatts)")
  plot(table2$Time,as.numeric(as.character(table2$Voltage)),type="l",xlab="datetime",ylab="Voltage") 
  plot(table2$Time, table2$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering") 
  with(table2, lines(Time, as.numeric(as.character(Sub_metering_1)), col = "black"))
  with(table2, lines(Time, as.numeric(as.character(Sub_metering_2)), col = "red"))
  with(table2, lines(Time, as.numeric(as.character(Sub_metering_3)), col = "blue"))
  legend("topright", lty = 1, col = col.txt, legend = leg.txt, cex = 0.5) #make legend box smaller
  plot(table2$Time,as.numeric(as.character(table2$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power") 
})

#export png
dev.copy(png, file = "plot4.png")
dev.off()

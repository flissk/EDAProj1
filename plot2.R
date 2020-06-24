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

#plot graph 
par(mfrow = c(1,1))
plot(table2$Time,as.numeric(as.character(table2$Global_active_power)), type = "l" , xlab = "",ylab = "Global Active Power (kilowatts)")

#export png
dev.copy(png, file = "plot2.png")
dev.off()

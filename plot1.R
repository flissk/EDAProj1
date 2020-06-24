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

#basic plot
library(datasets)

#plot graph
par(mfrow = c(1,1))
hist(as.numeric(as.character(new_table$Global_active_power)), col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power") 

#export png
dev.copy(png, file = "plot1.png")
dev.off()
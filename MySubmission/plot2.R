library(dplyr)
library(lubridate)
#download the file and read it into R
if(!file.exists("./data")){
    dir.create("./data")
}
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(url, destfile = "./data/UncleanedData.zip", mode = "wb")
unclean <- "./data/UncleanedData.zip"
if(!file.exists("household_power_consumption.txt")){
    unzip(unclean, "household_power_consumption.txt")
}
stuff <- "household_power_consumption.txt"
unclean1 <- read.table(stuff, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")

#subset the data
unclean1$Date <- gsub("/", "-", unclean1$Date)
unclean1$Date <- as.Date(unclean1$Date, format = "%d-%m-%Y")
unclean1["Date"] <- format(unclean1["Date"], "%m-%d-%Y")
clean <- filter(unclean1, Date == "02-01-2007"| Date == "02-02-2007")

#plotting png2
clean$Date <- as.character(clean$Date)
clean$DateTime <- strptime(paste(clean$Date, clean$Time, sep = " "), format = "%m-%d-%Y %H:%M:%S")
clean$Global_active_power <- as.numeric(clean$Global_active_power)

plot(clean$DateTime, clean$Global_active_power, 
     type = "l",
     xlab = " ",
     ylab = "Global Active Power (killowatts)")


#plotting it as a .png
dev.copy(png, file = "plot2.png")
dev.off()
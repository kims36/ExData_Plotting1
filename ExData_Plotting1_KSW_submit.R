###Coursera4_Assignment_ExData_Plotting1_KSW_submit
# Written by Sun Wook Kim
# 

###Criteria
# 
# Was a valid GitHub URL containing a git repository submitted?
# Does the GitHub repository contain at least one commit beyond the original fork?
# Please examine the plot files in the GitHub repository. Do the plot files appear to be of the correct graphics file format?
# Does each plot appear correct?
# Does each set of R code appear to create the reference plot?
# 
### <DO>
# 
# Review the source code.
# Keep an open mind and focus on the positive.???/li>
#      When in doubt, err on the side of giving too many points, rather than giving too few.
# Ask yourself if a plot might answer a question for the person who created it.
# Remember that not everyone has the same statistical background and knowledge.
# 

#### <DON'T:>
# 
# Deduct just because you disagree with someone's statistical methods.
# Deduct just because you disagree with someone's plotting methods.
# Deduct based on aesthetics.


##### 0. PREP

## Preparation
library(data.table)

##1_download a zipfile
if (!file.exists("data")) {
     dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./Data/Dataset.zip")

##2_Unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

##3_Save data
hpc <- read.table("./data/household_power_consumption.txt",
                                        header = TRUE,
                                        sep = ";", comment.char="%", stringsAsFactors=FALSE, na.strings="?")

##4_Subset data
hpc <- subset(hpc,hpc$Date=="1/2/2007"|hpc$Date=="2/2/2007")
comb_date_time <- strptime(paste(hpc$Date, hpc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")



##### 1. PLOT1

##1_create plot1.png 
plot1 <- hist(hpc$Global_active_power,
              col="red",
              xlab="Global Active Power(kilowatts)",
              ylim = c(0, 1200),
              xlim = c(0, 6),
              main="Global Active Power")

##2_Copy my plot to a PNG file
dev.copy(png, file="plot1.png", width=480, height=480) 
dev.off()

##3_Print plot1
plot1()



##### 2. PLOT2

##1_create plot2.png 
plot2 <- plot(x = comb_date_time,
              hpc$Global_active_power,
              xlab="",
              ylab="Global Active Power(kilowatts)",
              type = "l")

##2_Copy my plot to a PNG file
dev.copy(png, file="plot2.png", width=480, height=480) 
dev.off()

##3_print plot2
plot2()



##### 3. PLOT3

##1_create plot3.png 
plot3 <- with(hpc, plot(x = comb_date_time,
               hpc$Global_active_power,
               xlab="",
               ylab="Energy sub metering",
               ylim = c(0, 30),
               type = "l"))

##2_Submetering lines with a legend
with(hpc, lines(comb_date_time, hpc$Sub_metering_1, col = "black"))
with(hpc, lines(comb_date_time, hpc$Sub_metering_2, col = "red"))
with(hpc, lines(comb_date_time, hpc$Sub_metering_3, col = "blue"))

#op <- par(cex = 0.5)
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##3_Copy my plot to a PNG file
dev.copy(png, file="plot3.png", width=480, height=480) 
dev.off()

##4_print plot3
plot3()



##### 4. PLOT4

##1_arrange four plots by mfrow
par(mfrow = c(2, 2))

##2_create plot4.png 
plot4 <- with(hpc,{
                      #TopLeft (plot2)
                      plot(x = comb_date_time, hpc$Global_active_power, xlab="", ylab="Global Active Power", type = "l")
                      #TopRight
                      plot(x = comb_date_time, hpc$Voltage, xlab="datetime", ylab="Voltage", type = "l")
                      #BottomLeft (plot3)
                      with(hpc, plot(x = comb_date_time,
                                     hpc$Global_active_power,
                                     xlab="",
                                     ylab="Energy sub metering",
                                     ylim = c(0, 30),
                                     type = "l"))
                      with(hpc, lines(comb_date_time, hpc$Sub_metering_1, col = "black"))
                      with(hpc, lines(comb_date_time, hpc$Sub_metering_2, col = "red"))
                      with(hpc, lines(comb_date_time, hpc$Sub_metering_3, col = "blue"))
                      # par(cex = 1.0)
                      legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), cex = 0.2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                      #BottomRight
                      plot(x = comb_date_time, hpc$Global_active_power, xlab="datetime", ylab="Global Active Power", type = "l")
                outer = TRUE})

##3_Copy my plot to a PNG file
dev.copy(png, file="plot4.png", width=480, height=480) 
dev.off()

##4_print plot4
plot4()


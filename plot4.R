## Step1: Getting and Cleaning data
        ## Reading Data from txt file
        preprocesseddata<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
        ## Select only entries occurred on the date of 2/1/2007 and 2/2/2007
        data_selected<-subset(preprocesseddata,preprocesseddata[,1]== "1/2/2007" | preprocesseddata[,1]=="2/2/2007" )
        data_addition<-subset(preprocesseddata,preprocesseddata[,1]== "3/2/2007" & preprocesseddata[,2]== "00:00:00")
        data_selected<-rbind(data_selected,data_addition)
        ## Coercing the date and time variables into one datetime column
        data_selected$datetime<-parse_date_time(paste(data_selected$Date,data_selected$Time),"%d%m%Y %H%M%S")
        ## Convert all the other variables to "numeric" class
        for (i in 3:9){
                data_selected[,i]<-as.numeric(as.character(data_selected[,i]))
        }
        data<-data_selected
        
##Step2: Plot 4
        ## Selecting graphic parameters
        par(mfcol=c(2,2))
        ## First Plot on the topleft
        plot(data[,3]~data[,10],xaxt="n",xlab="",ylab="Global Active Power",type="l") 
        a<-range(data$datetime)
        axis.POSIXct(side=1,at=seq(a[1],a[2],by="days"),format="%a")
        ## Second Plot on the bottomleft
        plot(data[,7]~data[,10],xaxt="n",col="black",type="l",ylab="Energy sub metering",xlab="")
        lines(data[,8]~data[,10],xaxt="n",col="red",type="l")    
        lines(data[,9]~data[,10],xaxt="n",col="blue",type="l")
        axis.POSIXct(side=1,at=seq(a[1],a[2],by="days"),format="%a")
        ## Create legend at the topright
        legend("topright",lty=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),bty="n")
        
        
        ## Third Plot on the topright
        plot(data[,5]~data[,10],xaxt="n",xlab="datetime",ylab="Voltage",type="l")
        axis.POSIXct(side=1,at=seq(a[1],a[2],by="days"),format="%a")
       
        ## Forth plot on the bottomright
        plot(data[,4]~data[,10],xaxt="n",xlab="datetime",ylab="Global_reactive_power",type="l")
        axis.POSIXct(side=1,at=seq(a[1],a[2],by="days"),format="%a")
        
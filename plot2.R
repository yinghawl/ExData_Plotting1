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
        
##Step2: Plot 2
        png("plot2.png",490,350)
        plot(data[,3]~data[,10],xaxt="n",ylab="Global Active Power (kilowatts)",xlab="",type="l")
        a<-range(data$datetime)
        axis.POSIXct(side=1,at=seq(a[1],a[2],by="days"),format="%a")
        dev.off()
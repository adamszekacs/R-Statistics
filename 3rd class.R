rp<-rpois(10000,4)
hist(rp)

plot(dpois(1:100,10), col='red',type="l")
par(new=TRUE)
plot(dpois(1:100,2), col='green',type="l")

?mtcars

library(ggplot2)
ggplot(mtcars, aes(x = carb)) + geom_bar()

ggplot(mtcars, aes(x = carb)) + geom_bar()+facet_grid(.~am)
#need factor - as this is numeric varible
ggplot(mtcars, aes(x = carb, fill=factor(am))) + geom_bar()

#update to factor in mtcars
mtcars$am <- factor(mtcars$am)
ggplot(mtcars, aes(x = carb, fill=am)) + geom_bar()

ggplot(mtcars, aes(x = carb, fill=am)) + geom_bar(position='dodge',binwidth=10)

#need to covert carb to factor type from numeric
ggplot(mtcars, aes(x = factor(carb), y=hp)) + geom_boxplot()

ggplot(mtcars, aes(x = hp, y=wt, col=factor((carb)))) + geom_point()

ggplot(mtcars, aes(x = hp, y=wt, col=factor((carb)))) + geom_point()+geom_smooth(method='lm', se=FALSE)



ggplot(mtcars, aes(x = hp)) + geom_bar()

ggplot(mtcars, aes(x = carb, y=hp))  + geom_boxplot()

ggplot(mtcars, aes(x = carb, y=hp))  + geom_boxplot()

ggplot(mtcars, aes(x = carb, =wt, z=hp))  + geom_line()

#install XML package
library(XML)

#need to convert strings from facotr
df<-readHTMLTable(readLines("https://en.wikipedia.org/wiki/FTSE_100_Index"),which = 2, header=TRUE, stringsAsFactors=FALSE)
str(df)
#fix name - remove pound sign
names(df)[4]<-'Cap'
#update to numeric
df$Cap<-as.numeric(df$Cap)
#replace commas with empty string, and update
df$Employees<-as.numeric(gsub(',','',df$Employees))
str(df)

# descriptive statistics
min(df$Employees)
mean(df$Employees)
#number of emp per sector
aggregate(Employees~Sector, FUN=mean, data = df)
aggregate(Employees~Sector, FUN=min, data = df)
aggregate(Employees~Sector, FUN=range, data = df)
#number of companies per sector ...
aggregate(Company~Sector, FUN=length, data = df)
#filtering
subset(df, Employees<1000 & Cap<5)

#powerful way to maipulate, summarize and analize data.
#install data.table
library(data.table)

#install hfligths for data set -> large!
library(hflights)
str(hflights)

dt<-data.table(hflights)
str(dt)

dt[i,j] #i - what rows, j which cols

subset(dt,Dest=='LAX')
#data filtering
dt[Dest=='LAX', list(Dest, DepTime, ArrTime)]

#number of flights cancelled
dt[,sum(Cancelled)]
#number of rows
dt[,.N]

#number of 
dt[,.N,by=Dest]
#total of cancelled fli per dest, specify column name for cancelled flights by list
dt[,list(cancelled =sum(Cancelled)),by=Dest]

dt[,.(cancelled =sum(Cancelled),.N,sum(ArrDelay)),by=Dest]
#na.rm - dont care about missing values
dt[,.(cancelled =sum(Cancelled),.N,sum(ArrDelay, na.rm = TRUE)),by=Dest]

dt[ArrDelay > 0,.(cancelled =sum(Cancelled),.N,sum(ArrDelay, na.rm = TRUE)),by=Dest]
#chain brackets
dt[ArrDelay > 0][,.(cancelled =sum(Cancelled))]

#order by N
dta<-dt[ArrDelay > 0,.(cancelled =sum(Cancelled),.N,sum(ArrDelay, na.rm = TRUE)),by=Dest]
setorder(dta, N)
dta
#decreasing order
setorder(dta, -N)
#multiple index order
setorder(dta, -N, cancelled)

dta<-dt[ArrDelay > 0,.(cancelled =sum(Cancelled),.N,sum(ArrDelay, na.rm = TRUE)),by=.(Dest,DayOfWeek)]
dta
setorder(dta, -N, DayOfWeek)
dta
#elso, utolso sor
dta[c(1,.N)]

#new data set
library(nycflights13)
str(flights)
str(airports)
#convert to data table
flights<-data.table(flights)
#create date column, cool assignmnet operator, do in place assignment, dont copy data like <-
flights[,date := as.Date(paste(year, month, day, sep="-"))]
#create day of week col
flights[,weekday := weekdays(date)]

#join data based on airport code (faa)
newflights<-merge(flights, airports, by.x ="dest", by.y="faa")
newflights[,.N]

newflights<-merge(flights, airports, by.x ="dest", by.y="faa", all.x = TRUE, all.y = FALSE)
str(newflights)
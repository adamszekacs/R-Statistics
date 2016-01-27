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


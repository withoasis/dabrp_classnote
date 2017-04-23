Sys.setlocale("LC_ALL","ko_KR.UTF-8")

if(TRUE){print(1)}
print(2)

if(c(T,F,F,F)){print(1)}
print(2)

x<-1
if ( x > 0 ){
  print(1)
}


x<-c()
if(identical(x,c())){print("x has no data.")}
print("if part done.")

options(stringsAsFactors = F)

y<-c(1,2,3)
z<-c(1,2,3)
if(length(y)==length(z)){
  tem<-data.frame(y,z)
  print(tem)
}
print("if part done.")

if(TRUE){
  print(1)
} else {
  print(3)
}
print(2)

x<-1

if(x<0){
  print(1)
} 
if(x>10) {
  print(3)
} else {
  print(2)
}
print(4)

library(readr)
sd<-read_csv("./제3회 Big Data Competition-분석용데이터-05.멤버십여부.txt")
names(sd)[1]<-"고객번호"
sd<-data.frame(sd)

str(sd)
summary(sd)

sd$"최근고객"<-ifelse(sd$"가입년월">mean(sd$"가입년월"),"최근","최근아님")
head(sd)


noObj
print(1)
## Error in try(noObj) : object 'noObj' not found

try(noObj)
print(1)

err<-try(noObj)
err
class(err)

x<-1
repeat(
  if(x>10){
    break
  } else {
    print(x)
    x<-x+1
  }
)

x<-1
while(x<10){
  print(x)
  x<-x+1
}

x<-1
repeat(
  if(x<10){
    print(x)
    x<-x+1
  } else {
    break
  }
)

for(x in 1:9){
  print(x)
}


data<-head(sd$"고객번호")
for(cNum in data){
  print(sd[sd$"고객번호"==cNum,])
}

data<-head(sd$"고객번호")
for(cNum in data){
  if(sd[sd$"고객번호"==cNum,"최근고객"]=="최근"){next}
  print(sd[sd$"고객번호"==cNum,])
}

X<-as.data.frame(matrix(1:64, ncol=4, dimnames=list(seq(1:16), c("a", "b", "c", "d"))))

X$a[c(1,3,10)]<-0


for (i in 1:nrow(X)){
  if (X$a[i]==0) {
    X$e[i]<-(-999) 
  } else {
    X$e[i]<-X$b[i]/X$c[i]
  }
}
X

library(ggplot2)
library(dplyr)
library(tidyr)

times<-c(100,1000,10000,30000,50000,100000)
tData<-c()
for(tm in times){
  
  X<-as.data.frame(matrix(1:tm, ncol=4, dimnames=list(seq(1:(tm/4)), c("a", "b", "c", "d"))))
  
  X$a[c(1,3,10)]<-0
  
  forTime<-system.time(
    for (i in 1:nrow(X)){
      if (X$a[i]==0) {
        X$e[i]<-(-999) 
      } else {
        X$e[i]<-X$b[i]/X$c[i]
      }
    }
  )
  ifelseTime<-system.time(X$e <- ifelse(X$a == 0, -999, X$b/X$c))
  
  forTime<-cbind(data.frame(tm,cate="forTime"),t(as.matrix(forTime)))
  ifelseTime<-cbind(data.frame(tm,cate="ifelseTime"),t(as.matrix(ifelseTime)))
  tData<-rbind(tData,forTime,ifelseTime)
  
}

tData<-tData %>% select(tm:elapsed) %>% gather(tm,cate)
names(tData)<-c("iter","cate","timeName","time")
ggplot(tData,aes(x=iter,y=time,fill=cate,color=cate)) + geom_point(stat="identity")

tm<-1000000
X<-as.data.frame(matrix(1:tm, ncol=4, dimnames=list(seq(1:(tm/4)), c("a", "b", "c", "d"))))
ifelseTime<-system.time(X$e <- ifelse(X$a == 0, -999, X$b/X$c))
ifelseTime


set.seed(1)
( myMat <- matrix(round(rnorm(16,10),2),4,4) )

mean(myMat[,1])
mean(myMat[,2])
mean(myMat[,3])
mean(myMat[,4])

for(i in 1:4){
  mean(myMat[,i])
}

myMean <- c(
  mean(myMat[,1]),
  mean(myMat[,2]),
  mean(myMat[,3]),
  mean(myMat[,4])
)
myMean

myMean <- c()
for(i in 1:4){
  myMean<-c(myMean,mean(myMat[,i]))
}
myMean

myLoop <- function(somemat) {
  myMean <- c()
  for(i in 1:ncol(somemat)){
    myMean<-c(myMean,mean(myMat[,i]))
  }
  return(myMean)
}

myLoop(myMat)

apply(myMat, 2, mean)

identical(myLoop(myMat),apply(myMat, 2, mean))

apply(mymat,2,class)
apply(mymat,2,sum) 
apply(mymat,2,quantile) 

myMat[1,4]<-NA
apply(myMat,2,sum)
apply(myMat,2,sum, na.rm = TRUE)

naSum <- function(x){
  return(sum(x,na.rm = TRUE))
}

apply(myMat,2,naSum)
apply(myMat,2,function(x) sum(x,na.rm = TRUE))


(listData <- list(a = 1, b = 1:3, c = 10:100) )
lapply(listData, length) 
lapply(listData, sum)

(listData <- list(a = 1, b = 1:3, c = 10:100) )
unlist(lapply(listData, length))
unlist(lapply(listData, sum))

(listData <- list(a = 1, b = 1:3, c = 10:100) )
sapply(listData, length)
sapply(listData, sum)
    
    
if (!require("data.table")) {install.packages("data.table") }
if (!require("DBI")){devtools::install_github("rstats-db/DBI")}
if (!require("RMySQL")){devtools::install_github("rstats-db/RMySQL")}
library(RMySQL)

options(stringsAsFactors = F)

dir.create("./bankData")
test<-"http://scgailabs.duckdns.org/oc/index.php/s/3YQuCOH39HbI1nW/download"
download.file(test,destfile="./bankData/test_ver2.csv",mode='wb')
train<-"http://scgailabs.duckdns.org/oc/index.php/s/0ow1ZJId93uSgfc/download"
download.file(train,destfile="./bankData/train_ver2.csv",mode='wb')

con <- dbConnect(RMySQL::MySQL(), dbname = "bank", user = "root") 

dbGetQuery(con, "show processlist")
dbGetQuery(con, "show variables like 'character_set_%'")
rs<-dbSendQuery(con, 'set character set utf8')
dbGetQuery(con, "show variables like 'character_set_%'")

## if mac user
# Sys.setlocale("LC_ALL","ko_KR.UTF-8")

dbListTables(con)
dbWriteTable(con, "mtcars", mtcars, overwrite=T)
dbListTables(con)
dbReadTable(con, "mtcars")

dbRemoveTable(con,"mtcars")
dbListTables(con)

dbWriteTable(con, "train", "./bankData/train_ver2.csv",row.names=F)

dbGetQuery(con,"select TABLE_ROWS from information_schema.tables where table_name = 'train'")
dbGetQuery(con,"select count(*) from train")

query <- dbSendQuery(con, "select * from train limit 10")
query

dbColumnInfo(query)
dbGetStatement(query)
dbGetRowCount(query)
dbHasCompleted(query)

train <- dbFetch(query)
query

dbColumnInfo(query)
dbGetStatement(query)
dbGetRowCount(query)
dbHasCompleted(query)

train

dbClearResult(query)
query

dbColumnInfo(query)
dbGetStatement(query)
dbGetRowCount(query)
dbHasCompleted(query)


query <- dbSendQuery(con, "select * from train where renta=0")
train <- dbFetch(query, n=100)

dbColumnInfo(query)
dbGetStatement(query)
dbGetRowCount(query)
dbHasCompleted(query)

train
dbClearResult(query)

query <- dbSendQuery(con, "select * from train where renta=0")
while (!dbHasCompleted(query)) {
  chunk <- dbFetch(query, 100000)
  print(paste0(nrow(chunk)," / ",dbGetRowCount(query)))
}

dbClearResult(query)
dbDisconnect(con)


library(readr)
library(data.table)
# recomt<-"http://scgailabs.duckdns.org/oc/index.php/s/fk6gISGj9wKLUbq/download"
# download.file(recomt,destfile="./recom/transection.txt",mode='wb')
# 
# chennel<-read_csv("./recom/chennel.txt")
# competitor<-read_csv("./recom/competitor.txt")
# customer<-read_csv("./recom/customer.txt")
# item<-read_csv("./recom/item.txt")
# membership<-read_csv("./recom/membership.txt")
# tran<-fread("./recom/transection.txt")
# 
# names(chennel)<-c("cusID","partner","useCnt")
# names(competitor)<-c("cusID","partner","competitor","useDate")
# names(customer)<-c("cusID","sex","age","area")
# names(item)<-c("partner","cate_1","cate_2",'cate_3',
#                "cate_2_name","cate_3_name")
# names(membership)<-c("cusID","memberShip","regDate")
# names(tran)<-c("partner","receiptNum","cate_1","cate_2","cate_3",
#                "cusID","storeCode","date","time","amount")
# 
# write_csv(chennel,"./recomen/chennel.csv")
# write_csv(competitor,"./recomen/competitor.csv")
# write_csv(customer,"./recomen/customer.csv")
# write_csv(item,"./recomen/item.csv")
# write_csv(membership,"./recomen/membership.csv")
# fwrite(tran,"./recomen/tran.csv")

recoment<-"http://scgailabs.duckdns.org/oc/index.php/s/jISrPutj4ocLci2/download"
download.file(recoment,destfile="./recomen/tran.csv",mode='wb')

con <- dbConnect(RMySQL::MySQL(), dbname = "bank", user = "root") 

dbListTables(con)

dbWriteTable(con, "chennel", "./recomen/chennel.csv",row.names=FALSE,overwrite=TRUE)
dbWriteTable(con, "competitor", "./recomen/competitor.csv",row.names=FALSE,overwrite=TRUE)
dbWriteTable(con, "customer", "./recomen/customer.csv",row.names=FALSE,overwrite=TRUE)
dbWriteTable(con, "item","./recomen/item.csv",row.names=FALSE,overwrite=TRUE)
dbWriteTable(con, "membership","./recomen/membership.csv",row.names=FALSE,overwrite=TRUE)
dbWriteTable(con, "tran","./recomen/tran.csv",row.names=FALSE,overwrite=TRUE)

dbListTables(con)

dbGetQuery(con, "select * from chennel limit 10")
dbGetQuery(con, "select * from competitor limit 10")
dbGetQuery(con, "select * from customer limit 10")
dbGetQuery(con, "select * from item limit 10")
dbGetQuery(con, "select * from membership limit 10")
dbGetQuery(con, "select * from tran limit 10")

query <- dbSendQuery(con, "select * from membership as a 
                     inner join customer as b on
                     a.cusID = b.cusID")
join1 <- dbFetch(query)

dim(join1)
str(join1)
summary(join1)

query <- dbSendQuery(con, "select * from customer as a 
                     left join membership as b on
                     a.cusID = b.cusID")
join2 <- dbFetch(query)

dim(join2)
str(join2)
summary(join2)


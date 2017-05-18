if (!require("data.table")) {install.packages("data.table") }
if (!require("DBI")){devtools::install_github("rstats-db/DBI")}
if (!require("RMySQL")){devtools::install_github("rstats-db/RMySQL")}
library(RMySQL)

# set data frame options
options(stringsAsFactors = F)

dir.create("./bankData")

# download bank data named test 105MB
test<-"http://rcoholic.duckdns.org/oc/index.php/s/3YQuCOH39HbI1nW/download"
download.file(test,destfile="./bankData/test_ver2.csv",mode='wb')

# download bank data named train 2.1GB
train<-"http://rcoholic.duckdns.org/oc/index.php/s/0ow1ZJId93uSgfc/download"
download.file(train,destfile="./bankData/train_ver2.csv",mode='wb')

# connect mysql
con <- dbConnect(RMySQL::MySQL(), dbname = "bank", user = "root",password="xxx")

# check number of connections
dbGetQuery(con, "show processlist")

# check encoding setting
dbGetQuery(con, "show variables like 'character_set_%'")

# if not like below, please try next line.
# this set is for windows 10
# mac might be not necessary.
# Variable_name                                              Value
# 1     character_set_client                                               utf8
# 2 character_set_connection                                               utf8
# 3   character_set_database                                               utf8
# 4 character_set_filesystem                                             binary
# 5    character_set_results                                               utf8
# 6     character_set_server                                             latin1
# 7     character_set_system                                               utf8
# 8       character_sets_dir C:\\Program Files\\MariaDB 10.1\\share\\charsets\\

dbSendQuery(con, 'set character set utf8')

# check again.
dbGetQuery(con, "show variables like 'character_set_%'")

# if mac user, try next line for encoding setting.
Sys.setlocale("LC_ALL","ko_KR.UTF-8")

# check db tables
dbListTables(con)

# write table to db
dbWriteTable(con, "mtcars", mtcars, overwrite=T)
dbListTables(con)

# get table data
dbReadTable(con, "mtcars")

# remove
dbRemoveTable(con,"mtcars")
dbListTables(con)

# you can write table from file directly.
system.time(dbWriteTable(con, "train", "./bankData/train_ver2.csv",row.names=F))
# 사용자  시스템 elapsed 
# 0.68    7.36  391.80 

# check table row number approximately. It's fast.
dbGetQuery(con,"select TABLE_ROWS from information_schema.tables where table_name = 'train'")
# check table row number correctly. It's super slow.
dbGetQuery(con,"select count(*) from train")

# dbSendQuery function just send query.
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

dim(train)
head(train)

dbClearResult(query)
query

dbColumnInfo(query)
dbGetStatement(query)
dbGetRowCount(query)
dbHasCompleted(query)

dim(train)
head(train)
rm(train)

query <- dbGetQuery(con, "select * from train where nomprov='MALAGA'")
dim(query)
head(query)
str(query)
summary(query)

rm(query)

dbDisconnect(con)


library(readr)
library(data.table)

## preprocessing data
# recomt<-"http://rcoholic.duckdns.org/oc/index.php/s/fk6gISGj9wKLUbq/download"
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

# download processed data named tran 1.4GB
recoment<-"http://rcoholic.duckdns.org/oc/index.php/s/jISrPutj4ocLci2/download"
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

# inner join
query <- dbGetQuery(con, "select * from membership as a 
                     inner join customer as b on
                     a.cusID = b.cusID")
join1 <-query

dim(join1)
str(join1)
summary(join1)

# left join (please compare between join1 and join2)
query <- dbSendQuery(con, "select * from customer as a 
                     left join membership as b on
                     a.cusID = b.cusID")
join2 <- dbFetch(query)

dim(join2)
str(join2)
summary(join2)

dbDisconnect(con)

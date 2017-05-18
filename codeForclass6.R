library(tidyverse)
if (!require("DBI")){devtools::install_github("rstats-db/DBI")}
if (!require("RMySQL")){devtools::install_github("rstats-db/RMySQL")}
library(RMySQL)
options(stringsAsFactors = F)

sql_db = src_mysql(dbname="bank",user = "root")
chen = tbl(sql_db, 'chennel')
comp = tbl(sql_db, 'competitor')
cust = tbl(sql_db, 'customer')
item = tbl(sql_db, 'item')
memb = tbl(sql_db, 'membership')
tran = tbl(sql_db, 'tran')

Sys.setlocale("LC_ALL","ko_KR.UTF-8")

data<-chen %>% filter(useCnt>10)
collect(data)

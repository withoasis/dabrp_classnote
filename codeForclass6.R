library(tidyverse)
if (!require("DBI")){devtools::install_github("rstats-db/DBI")}
if (!require("RMySQL")){devtools::install_github("rstats-db/RMySQL")}
library(RMySQL)
options(stringsAsFactors = F)

con <- dbConnect(RMySQL::MySQL(), dbname = "bank", user = "root",password="xxx")

dbListTables(con)
system.time(dbWriteTable(con, "train", "./bankData/train_ver2.csv",row.names=F))
# 사용자  시스템 elapsed 
# 0.68    7.36  391.80 
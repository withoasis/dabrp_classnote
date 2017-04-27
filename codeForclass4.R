# install.packages("data.table")
# install.packages("RMySQL")
# library(data.table)
library(RMySQL)

# tem<-fread("./bank/train_ver2.csv")
con <- dbConnect(dbDriver("MySQL"), dbname = "bank", user = "root", 
                 password = "XXXXX") 

dbListTables(con)
dbWriteTable(con, "mtcars", mtcars)
dbListTables(con)

dbListFields(con, "train")
dbReadTable(con, "mtcars")

query <- dbSendQuery(con, "select * from train limit 10")
train10 <- dbFetch(query)
train10

dbClearResult(query)

dbDisconnect(con)




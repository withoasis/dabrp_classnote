install.packages("data.table")
install.packages("RMySQL")
library(data.table)
library(RMySQL)

# tem<-fread("./bank/train_ver2.csv")
con <- dbConnect(dbDriver("MySQL"), dbname = "bank", user = "root", 
                 password = "XXXXXX")

query.result <- dbSendQuery(con, "SELECT * FROM train limit 10")
test.table <- fetch(query.result)
test.table

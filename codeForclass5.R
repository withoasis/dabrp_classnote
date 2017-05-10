library(tidyverse)
library(nycflights13)
flights

filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))
filter(flights, month = 1)


filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))

rename(flights, tail_num = tailnum)
select(flights, time_hour, air_time, everything())


flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)


(x <- 1:10)
lag(x)
lead(x)


summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

daily %>% 
  ungroup() %>% 
  summarise(flights = n())


flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
popular_dests

popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)


table1
table2
table3
table4a
table4b

table4a
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

table2
spread(table2, key = type, value = count)

table3
table3 %>% 
  separate(rate, into = c("cases", "population"))

table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

table5 %>% 
  unite(new, century, year)

table5 %>% 
  unite(new, century, year, sep = "")

airlines
airports
planes
weather


flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

flights2 %>%
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

flights2 %>%
  select(-origin, -dest) %>% 
  mutate(name = airlines$name[match(carrier, airlines$carrier)])

flights2 %>% 
  left_join(weather)

flights2 %>% 
  left_join(planes, by = "tailnum")


flights2 %>% 
  left_join(airports, c("dest" = "faa"))

flights2 %>% 
  left_join(airports, c("origin" = "faa"))



library(dplyr)
library(RSQLite)
library(RMySQL)
sqlite_db = src_sqlite('sqlite_db.sqlite3', create = T)
copy_to(sqlite_db, mtcars)

src_tbls(sqlite_db)
tbl(sqlite_db, 'mtcars')
tbl(sqlite_db, sql('SELECT * FROM mtcars'))

iris_db = tbl(sqlite_db, 'mtcars')
iris_db %>% filter(mpg > 20)

sql_db = src_mysql(dbname="bank",user = "root",password = "XXXXX")
sql_db


library(data.table)
url<-"https://github.com/arunsrinivasan/flights/wiki/NYCflights14/flights14.csv"
dir.create("./data",showWarnings = F)
download.file(url,destfile = "./data/flights14.csv")
system.time(flights <- read.csv("./data/flights14.csv"))
system.time(flights <- fread("./data/flights14.csv"))
flights
dim(flights)

ans <- flights[origin == "JFK" & month == 6L]
head(ans)

ans <- flights[1:2]
ans

ans <- flights[order(origin, -dest)]
head(ans)

ans <- flights[, arr_delay]
head(ans)

ans <- flights[, .(arr_delay, dep_delay)]
head(ans)

ans <- flights[, .(delay_arr = arr_delay, delay_dep = dep_delay)]
head(ans)

flights[, sum((arr_delay + dep_delay) < 0)]

flights[origin == "JFK" & month == 6L,
        .(m_arr = mean(arr_delay), m_dep = mean(dep_delay))]

flights[origin == "JFK" & month == 6L, length(dest)]

flights[, .(.N), by = .(origin)]

flights[carrier == "AA", .N, by = origin]

flights[carrier == "AA", .N, by = .(origin,dest)]

flights[carrier == "AA", .N, by = .(origin, dest)][order(origin, -dest)][1:10,]

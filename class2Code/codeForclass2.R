
x <- 1
class(1)
class(x)
class("x")

TRUE
class(TRUE)
T
class(T)
FALSE
class(FALSE)
F
class(F)

test <- TRUE
is.logical(test)
is.logical(TRUE)
is.logical("test")

test <- "1"
is.logical(test)

2
class(2)
is.numeric(2)

2.5
class(2.5)
is.numeric(2.5)

2L
class(2L)
is.numeric(2L)
is.integer(2L)

"2"
class("2")
is.numeric("2")
is.character("2")

is.character("한글")

"'"
is.character("'")
'"'
is.character('"')

vec_char <- c("a","b","c")
vec_char
class(vec_char)
is.vector(vec_char)
is.character(vec_char)

vec_num <- c(1,2,3,4,5)
vec_num
class(vec_num)
is.vector(vec_num)
is.numeric(vec_num)

vec_logi <- c(T,T,T,F,F,T)
vec_logi
class(vec_logi)
is.vector(vec_logi)
is.logical(vec_logi)

vec_test1 <- c(1,2,3,"test")
vec_test1
class(vec_test1)

vec_ind <- c("b","a","ab","b","o","ab")
vec_ind[1]

blood_type1 <- c(bob = "A", sam = "B", john="O",jim="AB",tom="A")
blood_type1
names(blood_type1)

blood_type2 <- c("A","B","O","AB","A")
blood_type2
names(blood_type2)
blood_type2_name <- c("bob", "sam", "john", "jim", "tom")
blood_type2_name
names(blood_type2) <- blood_type2_name
blood_type2
names(blood_type2)

blood_type1 <- c(bob = "A", sam = "B", john="O",jim="AB",tom="A")
blood_type1[bob]

blood_type1 <- c(bob = "A", sam = "B", john="O",jim="AB",tom="A")
blood_type1["bob"]

blood_type1 <- c(bob = "A", sam = "B", john="O",jim="AB",tom="A")
blood_type1[c("bob","john")]

blood_type1 <- c(bob = "A", sam = "B", john="O",jim="AB",tom="A")
blood_type1["bob","john"]

matrix(1:6, nrow = 2)
matrix(1:6, ncol = 3)
matrix(1:6, nrow = 2, byrow = TRUE)

matrix(1:3, nrow = 2, ncol = 3)
matrix(1:4, nrow = 2, ncol = 3)

cbind(1:3, 1:3)
rbind(1:3, 1:3)

m <- matrix(1:6, byrow = TRUE, nrow = 2)
m
rbind(m, 7:9)
cbind(m, c(10, 11))

m <- matrix(1:6, byrow = TRUE, nrow = 2)
m
rownames(m)
rownames(m) <- c("row1", "row2")
m
colnames(m)
colnames(m) <- c("col1", "col2", "col3")
m

m <- matrix(1:6, byrow = TRUE, nrow = 2,
            dimnames = list(c("row1", "row2"),
                            c("col1", "col2", "col3")))
m

num <- matrix(1:8, ncol = 2)
char <- matrix(LETTERS[1:6], nrow = 4, ncol = 3)
cbind(num, char)

m <- matrix(sample(1:15, 12), nrow = 3)
m
m[1,3]
m[3,2]

m[3,]
m[,3]

m[4]
m[9]

m[2, c(2, 3)]
m[c(1, 2), c(2, 3)]
m[c(1, 3), c(1, 3, 4)]

rownames(m) <- c("r1", "r2", "r3")
colnames(m) <- c("a", "b", "c", "d")
m
m[2,3]
m["r2","c"]
m[2,"c"]
m[3, c("c", "d")]

blood <- c("B", "AB", "O", "A", "O", "O", "A", "B")
blood
str(blood)
blood_factor <- factor(blood)
blood_factor

str(blood_factor)

blood_factor2 <- factor(blood,
                        levels = c("O", "A", "B", "AB"))
blood_factor2
str(blood_factor2)
str(blood_factor)

blood <- c("B", "AB", "O", "A", "O", "O", "A", "B")
blood_factor <- factor(blood)
blood_factor

levels(blood_factor) <- c("BT_A", "BT_AB", "BT_B", "BT_O")
blood_factor
factor(blood, labels = c("BT_A", "BT_AB", "BT_B", "BT_O"))

blood <- c("B", "AB", "O", "A", "O", "O", "A", "B")
blood_factor <- factor(blood)
blood_factor[1] < blood_factor[2]

tshirt <- c("M", "L", "S", "S", "L", "M", "L", "M")
tshirt_factor <- factor(tshirt, ordered = TRUE,
                        levels = c("S", "M", "L"))
tshirt_factor

tshirt_factor[1] < tshirt_factor[2]

c("Rsome times", 190, 5)
list("Rsome times", 190, 5)
song <- list("Rsome times", 190, 5)
is.list(song)

song[3]
class(song[3])

song[[3]]
class(song[[3]])

song <- list("Rsome times", 190, 5)
names(song) <- c("title", "duration", "track")
song

song <- list(title = "Rsome times",
             duration = 190,
             track = 5)
str(song)

similar_song <- list(title = "R you on time?",
                     duration = 230)

song <- list(title = "Rsome times",
             duration = 190, track = 5,
             similar = similar_song)

str(song)

library(N2H4)
url<-"http://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=100&oid=437&aid=0000152054"
tem<-getComment(url)
str(tem)

similar_song <- list(title = "R you on time?",
                     duration = 230)
song <- list(title = "Rsome times",
             duration = 190, track = 5,
             similar = similar_song)
song
song[1]
song[[1]]

song[c(1, 3)]

song[[c(1, 3)]]
song[[1]][[3]]

song[[3]][[1]]
song[[c(4, 1)]]

song[["duration"]]
song["duration"]
song[c("duration", "similar")]

song$duration
friends <- c("Kurt", "Florence", "Patti", "Dave")
song$sent <- friends
song
song[["sent"]] <- friends
song$similar$reason <- "too long"
song

name <- c("Anne", "Pete", "Frank", "Julia", "Cath")
age <- c(28, 30, 21, 39, 35)
child <- c(FALSE, TRUE, TRUE, FALSE, TRUE)
df <- data.frame(name, age, child)
df

names(df)
names(df) <- c("Name", "Age", "Child")
df
df <- data.frame(Name = name, Age = age, Child = child)
df
str(df)

data.frame(name[-1], age, child)

df <- data.frame(name, age, child, 
                 stringsAsFactors = FALSE)
str(df)

name <- c("Anne", "Pete", "Frank", "Julia", "Cath")
age <- c(28, 30, 21, 39, 35)
child <- c(FALSE, TRUE, TRUE, FALSE, TRUE)
people <- data.frame(name, age, child, stringsAsFactors = FALSE)
people
people[3,2]
people[3,"age"]
people[3,]
people[,"age"]
people[c(3, 5), c("age", "child")]
people[2]
people$age
people[["age"]]
people[[2]]
people["age"]
people[2]

height <- c(163, 177, 163, 162, 157)
people$height <- height
people[["height"]] <- height
people

weight <- c(74, 63, 68, 55, 56)
cbind(people, weight)

tom <- data.frame("Tom", 37, FALSE, 183)
rbind(people, tom)

tom <- data.frame(name = "Tom", age = 37,
                  child = FALSE, height = 183)
rbind(people, tom)

sort(people$age)
ranks <- order(people$age)
ranks
people$age

ranks <- order(people$age)
ranks

people[ranks, ]

people[order(people$age, decreasing = TRUE), ]

dates <- c("2016/01/01","2016/02/01","2016/03/01","2016/04/01","2016/05/01","2016/06/01")
dates
class(dates)
trans.dates <- as.Date(dates)
trans.dates
class(trans.dates)

trans.dates[303]-trans.dates[301]

dates2 <- c("2016-01-01","2016-02-01","2016-03-01","2016-04-01","2016-05-01","2016-06-01")
trans.dates2 <- as.Date(dates2)
trans.dates2
class(trans.dates2)

as.Date("2016년 4월 5일")

as.Date("2016년 4월 5일", format="%Y년 %m월 %d일")

# 양식 참고
# http://www.stat.berkeley.edu/classes/s133/dates.html

as.Date(34519, origin="1900-01-01")

as.POSIXct("2017-04-12 12:00:00")
as.POSIXlt("2017-04-12 12:00:00")

library(lubridate)

ymd("2017-05-05")
ymd("170505")
ymd("20170505")
dmy("17-05-15")
ymd("2017년 5월 5일")
dmy("5일5월2017년")

dates <- c("2017-05-05","170505","20170505","17-05-15","2017년 5월 5일")
ymd(dates)

data <- ymd("2017-05-05")
data

year(data)
month(data)
month(data, label=T)
week(data)
yday(data)
mday(data)
wday(data)
wday(data, label=T)
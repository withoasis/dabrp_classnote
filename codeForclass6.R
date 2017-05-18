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

# for mac
Sys.setlocale("LC_ALL","ko_KR.UTF-8")

data<-chen %>% filter(useCnt>10)
collect(data)
chenr<-collect(chen)

ggplot(chenr,aes(partner)) + geom_histogram(stat="count")

custr<-collect(cust)
summary(custr)





## korean map

## UTM / UTM-K / GPS
# https://mrchypark.wordpress.com/2014/10/23/%EC%A2%8C%ED%91%9C%EA%B3%84-%EB%B3%80%ED%99%98-proj4-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC/

if (!require("mapdata")){install.packages("mapdata")}
if (!require("mapproj")){install.packages("mapproj")}
library(mapdata)
library(mapproj)
world<-map_data("worldHires")
korea<-world[grep("Korea$", world$region),]

p<-ggplot(korea,aes(x=long,y=lat,group=group))
p+geom_polygon(fill="white",color="black") + coord_map()


if (!require("Kormaps")){devtools::install_github("cardiomoon/Kormaps")}
if (!require("tmap")){install.packages("tmap")}
if (!require("cartogram")){devtools::install_github("sjewo/cartogram")}
library(Kormaps)
library(tmap)
library(cartogram)

qtm(kormap1)
qtm(korpopmap1,"총인구_명")+tm_layout(fontfamily="NanumGothic")
qtm(korpopmap2,"총인구_명")+tm_layout(fontfamily="NanumGothic")


kor <- fortify(korpopmap1, region = "id")
kordf <- merge(kor, korpopmap1@data, by = "id")

ggplot(kordf, aes(x=long.x, y=lat.x, group=group.x, fill=`총인구_명`)) + 
  geom_polygon(color="black") + coord_map() +
  scale_fill_gradient(high = "#132B43", low = "#56B1F7") +
  theme(title=element_text(family="NanumGothic",face="bold"))

kordfs <- kordf %>% select(id:여자_명) %>% gather(성별,인구,-(id:총인구_명))

ggplot(kordfs, aes(x=long.x, y=lat.x, group=group.x, fill=`인구`)) + 
  geom_polygon(color="black") + coord_map() +
  scale_fill_gradient(high = "#132B43", low = "#56B1F7") +
  theme(text=element_text(family="NanumGothic",face="bold")) +
  facet_grid(.~ 성별)

# ggmap
devtools::install_github("dkahle/ggmap")
library(ggmap)
long = 127.064471
lat = 37.666028
get_googlemap("서울",maptype = "roadmap",markers = data.frame(long,lat)) %>% ggmap()



## extra
## https://www.ggplot2-exts.org/

# ggsci
# https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html
devtools::install_github("road2stat/ggsci")
library(ggsci)
library(gridExtra)
data("diamonds")

p1 = ggplot(subset(diamonds, carat >= 2.2),
            aes(x = table, y = price, colour = cut)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "loess", alpha = 0.05, size = 1, span = 1) +
  theme_bw()

p2 = ggplot(subset(diamonds, carat > 2.2 & depth > 55 & depth < 70),
            aes(x = depth, fill = cut)) +
  geom_histogram(colour = "black", binwidth = 1, position = "dodge") +
  theme_bw()

p1_aaas = p1 + scale_color_aaas()
p2_aaas = p2 + scale_fill_aaas()
grid.arrange(p1_aaas, p2_aaas, ncol = 2)


# ggExtra
# https://github.com/daattali/ggExtra
devtools::install_github("daattali/ggExtra")
library(ggExtra)
df1 <- data.frame(x = rnorm(500, 50, 10), y = runif(500, 0, 50))
(p1 <- ggplot(df1, aes(x, y)) + geom_point() + theme_bw())
ggMarginal(p1, type = "histogram")

# ggthemes
devtools::install_github("jrnold/ggthemes")
library("ggthemes")

dtemp <- data.frame(months = factor(rep(substr(month.name,1,3), 4), levels = substr(month.name,1,3)),
                    city = rep(c("Tokyo", "New York", "Berlin", "London"), each = 12),
                    temp = c(7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6,
                             -0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5,
                             -0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0,
                             3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8))

ggplot(dtemp, aes(x = months, y = temp, group = city, color = city)) +
  geom_line() +
  geom_point(size = 1.1) + 
  ggtitle("Monthly Average Temperature") +
  theme_hc() +
  scale_colour_hc()

ggplot(dtemp, aes(x = months, y = temp, group = city, color = city)) +
  geom_line() + 
  geom_point(size = 1.1) + 
  ggtitle("Monthly Average Temperature") +
  theme_hc(bgcolor = "darkunica") +
  scale_fill_hc("darkunica")

# ggally
# http://ggobi.github.io/ggally/index.html
devtools::install_github("ggobi/ggally")
if (!require("network")){install.packages("network")}
if (!require("sna")){install.packages("sna")}
library(network)
library(sna)
library(GGally)
airports <- read.csv("http://datasets.flowingdata.com/tuts/maparcs/airports.csv", header = TRUE)
rownames(airports) <- airports$iata

# select some random flights
set.seed(1234)
flights <- data.frame(
  origin = sample(airports[200:400, ]$iata, 200, replace = TRUE),
  destination = sample(airports[200:400, ]$iata, 200, replace = TRUE)
)

# convert to network
flights <- network(flights, directed = TRUE)

# add geographic coordinates
flights %v% "lat" <- airports[ network.vertex.names(flights), "lat" ]
flights %v% "lon" <- airports[ network.vertex.names(flights), "long" ]

# drop isolated airports
delete.vertices(flights, which(degree(flights) < 2))

# compute degree centrality
flights %v% "degree" <- degree(flights, gmode = "digraph")

# add random groups
flights %v% "mygroup" <- sample(letters[1:4], network.size(flights), replace = TRUE)

# create a map of the USA
usa <- ggplot(map_data("usa"), aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), color = "grey65",
               fill = "#f9f9f9", size = 0.2)

delete.vertices(flights, which(flights %v% "lon" < min(usa$data$long)))
delete.vertices(flights, which(flights %v% "lon" > max(usa$data$long)))
delete.vertices(flights, which(flights %v% "lat" < min(usa$data$lat)))
delete.vertices(flights, which(flights %v% "lat" > max(usa$data$lat)))

# overlay network data to map
ggnetworkmap(usa, flights, size = 4, great.circles = TRUE,
             node.group = mygroup, segment.color = "steelblue",
             ring.group = degree, weight = degree)



# ggrepel
# https://github.com/slowkow/ggrepel/blob/master/vignettes/ggrepel.md
devtools::install_github("slowkow/ggrepel")
library(ggrepel)

ggplot(mtcars) +
  geom_point(aes(wt, mpg), color = 'red') +
  geom_text(aes(wt, mpg, label = rownames(mtcars))) +
  theme_classic(base_size = 16)

ggplot(mtcars) +
  geom_point(aes(wt, mpg), color = 'red') +
  geom_text_repel(aes(wt, mpg, label = rownames(mtcars))) +
  theme_classic(base_size = 16)


# ggfortify
# https://github.com/sinhrks/ggfortify
devtools::install_github('sinhrks/ggfortify')
library(ggfortify)

res <- lapply(c(3, 4, 5), function(x) kmeans(iris[-5], x))
autoplot(res, data = iris[-5], ncol = 3)

autoplot(lm(Petal.Width ~ Petal.Length, data = iris), data = iris,
         colour = 'Species', label.size = 3)

if (!require("dlm")){install.packages("dlm")}
library(dlm)
form <- function(theta){
  dlmModPoly(order = 1, dV = exp(theta[1]), dW = exp(theta[2]))
}

model <- form(dlmMLE(Nile, parm = c(1, 1), form)$par)
filtered <- dlmFilter(Nile, model)

autoplot(filtered)


# gganimate
# http://www.gapminder.org/world/
devtools::install_github("dgrtwo/gganimate")
if (!require("gapminder")){install.packages("gapminder")}
if (!require("magick")){install.packages("magick")}
library(magick)
library(gapminder)
library(gganimate)

# for mac
# brew install ghostscript imagemagick
# for ubuntu
# sudo apt-get install ghostscript imagemagick
# for windows
# http://www.imagemagick.org/script/binary-releases.php
# https://www.ghostscript.com/download/gsdnld.html

p <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent, frame = year)) +
  geom_point() +
  scale_x_log10()
p
gganimate(p,interval = .2)

gganimate(p, "output.gif")
gganimate(p, "output.mp4")
gganimate(p, "output.swf")
gganimate(p, "output.html")

# ggiraph
# http://davidgohel.github.io/ggiraph/
devtools::install_github("davidgohel/ggiraph")
library(ggiraph)
g <- ggplot(mpg, aes( x = displ, y = cty, color = hwy) ) + theme_minimal()
g + geom_point(size = 2) 

gdtools::sys_fonts()
# if data NUll try below for mac
# brew install cairo

my_gg <- g + geom_point_interactive(aes(tooltip = model), size = 2) 
ggiraph(code = print(my_gg), width = .7)


# ggedit
install.packages("ggedit")
library(ggedit)
p <- ggplot(mtcars, aes(x = hp, y = wt)) + geom_point() + geom_smooth()
ggedit(p)


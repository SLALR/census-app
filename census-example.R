library(maps)
library(mapproj)
source("census-app/helpers.R")
counties <- readRDS("census-app/data/counties.rds")
percent_map(counties$white, "darkgreen", "% White")
percent_map(counties$black, "black", "% Black")
percent_map(counties$hispanic, "Orange", "% Hispanic")

library(ggplot2)

barchart_crazy <- function(din, var){
  # var = sym(var)
  # var = rlang::data_sym(var)
  var <- enquo(var)
  ggplot(data = din, aes(x = {{var}})) +
    geom_bar()
    
}

barchart_crazy(counties, "white")

barchart_crazy_eg2 <- function(din, var){
  ggplot(data = din, aes(x = .data[[var]])) +
    # ggplot(data = din, aes(x = .data$var)) +
    geom_bar()
  
}

barchart_crazy_eg2(counties, "white")

barchart_crazy_eg3 <- function(indata){
  ggplot(data = indata, aes(x = .data[[names(indata)]])) +
    # ggplot(data = din, aes(x = .data$var)) +
    geom_bar()
  
}

barchart_crazy_eg3(counties["white"])

counties["white"] # returns a data frame
counties$white  # returns a vector


# Investigating object types
str(counties)

library(dplyr)
cc <- counties |> select(white) 
str(cc)
class(cc)

bb <- counties["white"]
str(bb)
class(bb)

setdiff(cc, bb)

# lets see if setdiff picks up on different data frames
hh <- counties["hispanic"]
setdiff(cc, hh)

hhh <- counties[c("white", "hispanic")]
setdiff(cc, hhh)

arsenal::comparedf(cc, hhh)

# returning a vector
dd <- counties |> pull(white)
str(dd)
class(dd)
mean(dd, na.rm = TRUE)

ee <- counties |> select(white) |> as.vector()
str(ee)
class(ee)

mean(ee, na.rm = TRUE)

class(ee) <- "numeric"

eee <- counties |> select(white) 
mean(eee$white, na.rm = TRUE)



# methods(mean)


ddd <- counties |> pull(-2)
str(ddd)

ddd <- counties |> pull(white, name) |> as.data.frame(col.names = names(counties))


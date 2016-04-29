#############################################
# Plot functions for all analysis in project#
#############################################

getStockTimeSeries <- function(filePath, title) {
  stock <- read.csv(filePath) %>%
    mutate(date=as.Date(Date), price=Close) %>%
    filter(year(date) >= 2005) %>%
    select(date, price)
  return(mutate(stock, title=rep(title, nrow(stock))))
}

#use path that ends with /
getStocksAverageTimeSeries <- function(folderPath, title) {
  files <- list.files(folderPath)
  stock <- read.csv(paste(folderPath, files[1], sep=""))
  print(files)
  for (i in 2:length(files)) {
    print(files[i])
    stock <- rbind(stock, read.csv(paste(folderPath, files[i], sep="")))
  }
  stock <- stock %>%
    mutate(date=as.Date(Date)) %>%
    group_by(date) %>%
    summarise(price=mean(Close)) %>%
    filter(year(date) >= 2005) %>%
    select(date, price)
  return(mutate(stock, title=rep(title, nrow(stock))))
}

plotSingleTimeSeries <- function(timeSeries) {
  ggplot(timeSeries, aes(x=date, y=price)) + 
    geom_line(color="blue")
}

plotMultipleTimeSeries <- function(timeSeriesList) {
  tbl <- timeSeriesList[[1]]
  for (i in 2:length(timeSeriesList)) {
    tbl <- rbind(tbl, timeSeriesList[[i]])
  }
  ggplot(tbl, aes(x=date, y=price, color=title)) + 
    geom_line()
}













###############################################
# Data preparation for all analysis in project#
###############################################

library(DataComputing)
library(XML)
workPath <- "~/Desktop/proj/"
dataPath <- "~/Desktop/proj/data/"

downloadSymbols <- function(symbolList, pathID) {
  for (s in symbolList) {
    url <- paste("http://finance.yahoo.com/q/hp?s=", s, sep="");
    doc <- htmlParse(url);
    links <- xpathSApply(doc, "//a/@href");
    dir.create(paste(dataPath, pathID, sep=""));
    download.file(links[grepl("csv", links)][[1]], destfile=paste(dataPath, pathID, "/", "history_", s, ".csv",sep=""));
  }
}

####################################################################
# download history prices of each stock according to ChinaStockInUS#
####################################################################

# part 1.1: download all China tech company US Stocks history prices
ChinaStockInUS <- read.csv(paste(dataPath, "ChinaStockInUS.csv", sep=""))
ChinaTechInUS <- ChinaStockInUS %>%
  filter(Sector=="Technology")
downloadSymbols(ChinaTechInUS$Symbol, "ChinaTechInUS")

# part 1.2: download all China tech US Stock ETF history prices
downloadSymbols(c("CQQQ", "QQQC", "KWEB"), "ChinaTechUSETF")

# part 2: download top 10 US tech ETF history prices
url <- "http://etfdb.com/etfdb-category/technology-equities/"
doc <- htmlParse(url)
tables <- readHTMLTable(doc)
Top10ETF <- head(tables[[1]]$Symbol, 10)
downloadSymbols(Top10ETF, "USTechETF")

# part 3.1: download China tech stock index history prices
downloadSymbols(c("000915.SS"), "ChinaTechIndex")

# part 3.2: download China tech stocks history prices





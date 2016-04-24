###############################################
# Data preparation for all analysis in project#
###############################################

library(DataComputing)
library(XML)
workPath <- "~/Desktop/proj/"
dataPath <- "~/Desktop/proj/data/"

downloadSymbols <- function(symbolList, pathID) {
  dir.create(paste(dataPath, pathID, sep=""));
  for (s in symbolList) {
    url <- paste("http://finance.yahoo.com/q/hp?s=", s, sep="");
    doc <- htmlParse(url);
    if (is.null(doc) == FALSE) {
      links <- xpathSApply(doc, "//a/@href");
      links <- links[grepl("csv", links)];
      if (length(links) > 0) {
        download.file(links[[1]], destfile=paste(dataPath, pathID, "/", "history_", s, ".csv",sep=""));
      }
    }
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

# part 3.1: download China tech stocks history prices in informaition software subsector
dir.create(paste(dataPath, "ChinaTech", sep=""));
for (i in 1:5) {
  StockList <- read.csv(paste(dataPath, "ChinaTech", i, ".csv", sep=""))
  Symbols <- vector('character')
  for (s in StockList$代码) {
    symbol <- toString(s)
    len <- nchar(symbol)
    if (len < 6) {
      for (j in 1:(6-len)) {
        symbol <- paste(0, symbol, sep="")
      }
    }
    if (substring(symbol,1,1) == "6") {
      Symbols <- append(Symbols, paste(symbol,".SS", sep=""))
    } else {
      Symbols <- append(Symbols, paste(symbol,".SZ", sep=""))
    }
    downloadSymbols(Symbols, "ChinaTech/Software")
  }
}

# part 3.2: download China tech stocks history prices in electrical hardware subsector
for (i in 6:13) {
  StockList <- read.csv(paste(dataPath, "ChinaTech", i, ".csv", sep=""))
  Symbols <- vector('character')
  for (s in StockList$代码) {
    symbol <- toString(s)
    len <- nchar(symbol)
    if (len < 6) {
      for (j in 1:(6-len)) {
        symbol <- paste(0, symbol, sep="")
      }
    }
    if (substring(symbol,1,1) == "6") {
      Symbols <- append(Symbols, paste(symbol,".SS", sep=""))
    } else {
      Symbols <- append(Symbols, paste(symbol,".SZ", sep=""))
    }
    downloadSymbols(Symbols, "ChinaTech/Hardware")
  }
}





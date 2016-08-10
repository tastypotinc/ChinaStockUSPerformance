# China Companies in US Exchange Stock Performance Analysis
## Author: Jack Ye, Zhang Qin

## File Contents:
* `data` folder contains all pre-downloaded data and data created with `data_prepare.R`
* All analysis are done in the file `group_project.Rmd`
* Plot util functions in `plots.R`
* presentation slides in `slide` folder, written with R `slidify` package

## Path Config:
* project folder placed in Desktop as default in all R scripts
* data default download to proj/data folder


## References:

* `data/ChinaStockInUS.csv` downloaded from http://www.nasdaq.com/screening/companies-by-region.aspx?region=Asia&country=China

* `data/NASDAQ.csv`, `NYSE.csv`, `AMEX.csv` downloaded from http://www.nasdaq.com/screening/company-list.aspx  

* all `data/ChinaTechX.csv` downloaded from http://quote.eastmoney.com/center/list.html#28002737_0_2 and http://quote.eastmoney.com/center/list.html#28002459_0_2, the file #1-5 are in information software subsector and #6-13 are in electrical hardware subsector

* all `data/TYPE_OF_STOCK/history_STOCK_SYMBOL.csv` downloaded from http://finance.yahoo.com/q/hp?s=STOCK_SYMBOL (for Shanghai Stock Exchange and Shenzhen Stock Exchange, STOCK_SYMBOL is replaced by STOCK_CODE.SS/SZ)

* Source for Top 10 US Technology ETF at http://etfdb.com/etfdb-category/technology-equities/#overview&page=1

* Source for China US Exchange ETF at http://www.etf.com/sections/features/22712-3-etfs-for-hot-chinese-tech-sector.html?nopaging=1

* Source for China tech sector index at http://finance.yahoo.com/q?s=000915.SS&ql=0

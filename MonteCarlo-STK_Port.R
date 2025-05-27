library(quantmod)
library(tidyquant)
library(data.table)
library(ggplot2)
library(xts)
library(magrittr)

#Retrieve ticker data (stocks)
getSymbols("NVDA")
getSymbols("META")
getSymbols("UBER")
getSymbols("AMC")
getSymbols("AAPL")

#Retrieve ticker data (crypto)
eth <- tq_get("ETH-USD")
btc <- tq_get("BTC-USD")
avax <- tq_get("AVAX-USD")

#Convert crypto data to xts
eth_xts <- xts(eth$adjusted, order.by = eth$date)
colnames(eth_xts) <- "ETH"

btc_xts <- xts(btc$adjusted, order.by = btc$date)
colnames(btc_xts) <- "BTC"

avax_xts <- xts(avax$adjusted, order.by = avax$date)
colnames(avax_xts) <- "AVAX"

#generate return
NVDA_ret <- dailyReturn(Ad(NVDA), type = "log")
colnames(NVDA_ret) <- "NVDA"

META_ret <- dailyReturn(Ad(META), type = "log")
colnames(META_ret) <- "META"

UBER_ret <- dailyReturn(Ad(UBER), type = "log")
colnames(UBER_ret) <- "UBER"

AMC_ret <- dailyReturn(Ad(AMC), type = "log")
colnames(AMC_ret) <- "AMC"

AAPL_ret <- dailyReturn(Ad(AAPL), type = "log")
colnames(AAPL_ret) <- "AAPL"

eth_ret <- dailyReturn(eth_xts, type = "log")
colnames(eth_ret) <- "ETH"

btc_ret <- dailyReturn(btc_xts, type = "log")
colnames(btc_ret) <- "BTC"

avax_ret <- na.omit(avax_ret)
avax_ret <- dailyReturn(avax_xts, type = "log")
colnames(avax_ret) <- "AVAX"

all_ret <- NVDA_ret %>% 
  merge(META_ret, join = "inner") %>% 
  merge(UBER_ret, join = "inner") %>% 
  merge(AMC_ret, join = "inner") %>% 
  merge(AAPL_ret, join = "inner") %>% 
  merge(eth_ret, join = "inner") %>% 
  merge(btc_ret, join = "inner") %>% 
  merge(avax_ret, join = "inner")

#Create weighted return (85:15 - Stocks:Crypto) vector for simulation
weights <- c(0.17, 0.17, 0.17, 0.17, 0.17, 0.05, 0.05, 0.05)
colnames(all_ret)
ret <- as.numeric(all_ret %*% weights)
ret <- ret[!is.na(ret) & is.finite(ret)]
ret <- pmax(pmin(ret, 0.05), -0.05)

#monte carlo sim
set.seed(0)
ndays <- 1000
paths <- replicate(n = 100, expr = (sample(ret, ndays, replace = TRUE)))
paths <- apply(paths, 2, function(x) cumprod (1+x))

#prepare 
paths <- data.table(paths)
paths$days <- 1: nrow(paths)
paths <- melt(paths, id.vars = "days")

#visualize
ggplot(paths,aes(x = days, y = (value - 1) * 100, col = variable)) +
geom_line() +
theme_bw() +
theme (legend.position = "none") +
  xlab("Days Invested") + ylab("Portfolio Return (%)")

#converts day 1000 values into % return
summary((paths$value[paths$days == ndays] - 1) * 100)

#calculates probability of loss
mean((paths$value [paths$days == ndays] - 1) * 100 < 0)
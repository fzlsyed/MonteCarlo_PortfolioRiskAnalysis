# 📉 Monte Carlo Simulation for Stock & Crypto Portfolio Risk Analysis

## Overview

This project explores how a mixed portfolio of **stocks** and **cryptocurrencies** might behave over the long term using a **Monte Carlo simulation** approach. I ran this simulation to understand the **risk** I’d be taking on before investing my own money.

Rather than looking at just average returns or volatility, this model simulates 100 different 1,000-day futures to help answer questions like:

- How bad could it get?
- How good can it get?
- What are the odds of losing money?

If you're curious about financial risk modeling or how compounding works under uncertainty, you're in the right place.

---

## Purpose

I created this tool while evaluating a portfolio I was seriously considering. I didn’t just want to know historical averages. I wanted to **see the range of possible outcomes** based on actual past behavior; especially given how unpredictable crypto markets can be.

This project gave me a clearer sense of:

- Potential losses during extended downtrends
- How much return volatility affects long-term outcomes
- What kind of growth paths are most common vs. rare

---

## Methodology

Here's what the simulation does under the hood:

- Uses daily **log returns** from adjusted close prices for each asset
- Allocates capital with a fixed weighting: **85% stocks / 15% crypto**
- Caps daily return outliers at ±5% to avoid skew from black swan events
- Runs **100 simulation paths**, each over **1,000 days**, using bootstrapped historical returns
- Compounds returns over time using `cumprod(1 + x)` and visualizes with `ggplot2`

---

## Portfolio Assets

### 🧾 Stocks:
- NVIDIA (NVDA)
- Meta Platforms (META)
- Uber (UBER)
- AMC Entertainment (AMC)
- Apple (AAPL)

### 🪙 Crypto:
- Ethereum (ETH)
- Bitcoin (BTC)
- Avalanche (AVAX)

---

## Outputs

- 📈 **Simulated Growth Chart**: [MC_STK-Port.png](MC_STK-Port.png)  
  A visual of all 100 simulated portfolio paths across 1,000 days

- 📊 **Final Return Summary**  
  Min: −77.08%  
  Max: +637.08%  
  Median: ~380%  

- ❗ **Probability of Loss**: 49%  
  Nearly half of the paths resulted in a net loss, even with strong average returns. Risk is real.

---

## Key Takeaways

- Most return paths landed well above the starting point, but the **tail risk** on both ends is significant.
- The **median return was very strong**, but nearly **half the simulations ended below zero**, showing how compounding and volatility interact.
- Crypto assets introduce major upside potential, but they also drive a lot of the downside risk.

---

## Tech Stack

Built entirely in **R** using the following packages:

- `quantmod`
- `tidyquant`
- `xts`
- `data.table`
- `ggplot2`
- `magrittr`

---

## Files Included

- `monte_carlo_portfolio.R` — Main simulation script
- `MC_STK-Port.png` — Output chart of simulated paths
- `README.md` — Project summary (this file)

---

## Ideas for Future Improvements

- Add Sharpe Ratio or Sortino Ratio analysis
- Incorporate correlation-adjusted return sampling
- Compare Monte Carlo results to actual historical drawdowns
- Add interactive Shiny dashboard

---

> ⚠️ This was built as a personal risk analysis tool and is for educational purposes only. Nothing here is financial advice.

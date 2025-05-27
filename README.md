# Monte Carlo Simulation for Stock & Crypto Portfolio Risk Analysis

## 📈 Overview

This project simulates the long-term performance of a diversified portfolio consisting of both **equities** (NVDA, META, UBER, AMC, AAPL) and **cryptocurrencies** (ETH, BTC, AVAX) using a **Monte Carlo simulation** approach. The goal was to evaluate the **risk profile and probability of loss** before committing capital to this investment strategy.

## 🎯 Purpose

I built this model to assess the **risk and return dynamics** of a portfolio I was actively considering. Instead of relying solely on historical summary statistics, I wanted to simulate **1,000-day future outcomes** by randomly sampling historical daily returns—providing insight into:

- **Worst-case and best-case scenarios**
- **Distribution of final portfolio returns**
- **Probability of incurring a loss**
- The effect of return volatility on cumulative growth

## 🧪 Methodology

- Historical daily **log returns** were computed using adjusted close prices for each asset.
- A portfolio weighting of **85% stocks / 15% crypto** was applied using matrix multiplication.
- Return outliers were clipped to ±5% to avoid extreme skewing in simulations.
- A **Monte Carlo simulation** was run with 100 paths, each simulating 1,000 days of compounded returns via `cumprod(1 + x)`.
- Results were visualized using `ggplot2`, and the **distribution of final returns** was summarized statistically.

## 📊 Key Outputs

- A **line plot** showing 100 simulated growth paths over 1,000 days
- A **summary of final returns** across all simulations
- A calculated **probability of loss** after 1,000 days

## 🧠 Insights

This approach helped me quantify not just expected returns, but also the **range and likelihood of outcomes**, especially in a portfolio with **volatile crypto exposure**. The simulation revealed how compounding and tail risk could influence performance—and gave me a probabilistic view of downside scenarios.

## 🔧 Tech Stack

- **Language**: R
- **Libraries**: `quantmod`, `tidyquant`, `xts`, `data.table`, `ggplot2`, `magrittr`

## 📂 Files

- `monte_carlo_portfolio.R`: Main simulation script
- `README.md`: Project documentation (you’re here)

## 🚀 Future Improvements

- Add Sharpe/Sortino ratio calculations
- Introduce correlation-aware return sampling
- Compare with historical drawdowns

---

> *This project was developed as a practical tool for my own investment risk assessment and is intended for educational purposes only.*

library(forecast)
library(ggplot2)
library(tseries)

nz_data <- read.csv("NZ.csv")

visitor_ts <- ts(nz_data$Visitors, start = c(1991, 1), frequency = 12)

# 1. Exploratory Analysis

# Original Series Plot
autoplot(visitor_ts) +
  ggtitle("Monthly NZ Visitors to Australia (Jan 1991 – Mar 2025)") +
  ylab("Visitors") + xlab("Year")

# Log-Transformation
log_visitor_ts <- log(visitor_ts)

# Plot Log-Transformed Series
autoplot(log_visitor_ts) +
  ggtitle("Log-Transformed Visitor Series") +
  ylab("log(Visitors)") + xlab("Year")

# Decomposition of Log Series
log_decomp <- decompose(log_visitor_ts)
plot(log_decomp)

# ADF test on log-transformed series
adf.test(visitor_ts)  # p = 0.03 → stationary in trend

# Seasonal differencing only (D = 1)
log_seasonal_diff <- diff(log_visitor_ts, lag = 12)

# Plot Seasonal Differenced Series
plot(log_seasonal_diff, main = "Seasonally Differenced Series (D = 1)")

# ADF Test on Seasonally Differenced Series
adf.test(log_seasonal_diff)

# ACF & PACF on Seasonally Differenced Series
par(mfrow = c(1, 2))
acf(log_seasonal_diff, lag.max = 100, main = "ACF (D = 1)")
pacf(log_seasonal_diff, lag.max = 100, main = "PACF (D = 1)")
par(mfrow = c(1, 1))

# Fit SARIMA models (Box-Cox handled inside Arima) 
# Data are back-transformed automatically later

model_orders <- list(
  list(order = c(0,0,1), seasonal = c(1,1,0)),
  list(order = c(1,0,0), seasonal = c(0,1,1)),
  list(order = c(1,0,1), seasonal = c(1,1,0)),
  list(order = c(1,0,1), seasonal = c(0,1,1)),
  list(order = c(0,0,1), seasonal = c(0,1,1))
)

# Fit models, store AIC and BIC
models <- list()
aic_vals <- numeric(length(model_orders))
bic_vals <- numeric(length(model_orders))

#Looping through each candidate model
for (i in 1:length(model_orders)) {
  
  # Extracting non-seasonal and seasonal
  order <- model_orders[[i]]$order
  seasonal <- model_orders[[i]]$seasonal
  
  #Fitting sarina model and log transforming the original data and back transforming
  fit <- Arima(visitor_ts, order = order, seasonal = seasonal, lambda = 0)
  models[[i]] <- fit      # Storing the fitted models
  aic_vals[i] <- AIC(fit) #Saving AIC and BIC values for model comparison
  bic_vals[i] <- BIC(fit)
  
  #Printing model details and corresponding AIC/BIC scores
  cat("Model", i, ": ARIMA(", order[1], ",", order[2], ",", order[3], ")(",
      seasonal[1], ",", seasonal[2], ",", seasonal[3], ")[12]\n")
  cat("  AIC =", round(aic_vals[i], 2), "\n")
  cat("  BIC =", round(bic_vals[i], 2), "\n\n")
}

#Identify model with the lowest AIC
best_index <- which.min(aic_vals)
best_model <- models[[best_index]]
cat("Selected Model:", best_index, "AIC =", round(aic_vals[best_index], 2), "BIC =", round(bic_vals[best_index], 2), "\n")


# Residual Diagnostics 

checkresiduals(best_model)   # should show white-noise residuals
shapiro.test(residuals(best_model)) # Normality test



# 3-Year Forecast (Jan-2021 – Dec-2023) 
# biasadj = TRUE ensures forecast is back-transformed to visitor counts

future_fc <- forecast(best_model, h = 36, biasadj = TRUE)


# 3-year forecasting with the best model
autoplot(future_fc) +
  ggtitle("NZ Visitors — SARIMA(1,0,1)(0,1,1)[12] Forecast (2026-2028)") +
  ylab("Visitors") + xlab("Year") +
  theme_minimal() +
  guides(colour = guide_legend(title = "Series"))


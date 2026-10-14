# Forecasting New Zealand Visitor Arrivals to Australia Using SARIMA

## Project Overview

This project uses time series analysis to forecast monthly short-term visitor arrivals from New Zealand to Australia. Historical data from the Australian Bureau of Statistics (ABS), covering January 1991 to March 2025, was analysed to identify long-term trends, seasonal patterns, and changes in visitor arrivals.

A Seasonal Autoregressive Integrated Moving Average (SARIMA) model was used to generate forecasts for January 2026 to December 2028. The project demonstrates the application of statistical modelling, time series diagnostics, and forecasting to a real-world tourism planning problem.

## Objectives

- Analyse historical monthly visitor arrivals from New Zealand to Australia.
- Explore long-term trends, seasonal patterns, and changes in the time series.
- Prepare the data for time series modelling using transformation and stationarity testing.
- Develop and compare candidate SARIMA models.
- Evaluate model performance using information criteria and residual diagnostics.
- Generate forecasts to support tourism planning and decision-making.

## Dataset

**Source:** Australian Bureau of Statistics (ABS)

**Publication:** *Overseas Arrivals and Departures, Australia* — Table 5

**Time period:** January 1991 – March 2025

**Frequency:** Monthly

The original ABS dataset contains short-term visitor arrival information for multiple countries. For this project, the date column and monthly visitor counts for New Zealand were extracted and saved as a separate CSV file for analysis in R.

The dataset was examined for historical trends, seasonal variation, and unusual changes in visitor arrivals.

**Data source:** [Australian Bureau of Statistics – Overseas Arrivals and Departures, Australia](https://www.abs.gov.au/statistics/industry/tourism-and-transport/overseas-arrivals-and-departures-australia)

## Methodology

### 1. Exploratory Data Analysis

The historical time series was visualised to examine its underlying characteristics. The analysis identified a long-term upward trend, recurring seasonal patterns, and a sharp decline in visitor arrivals around March 2020, coinciding with the COVID-19 pandemic and associated travel restrictions.

### 2. Data Transformation

A logarithmic transformation was applied to help stabilise the variance and make the series more suitable for time series modelling.

### 3. Time Series Decomposition

Classical time series decomposition was used to examine the trend, seasonal component, and irregular variation separately. This helped improve understanding of the structure of the data and its seasonal behaviour.

### 4. Stationarity Testing

The Augmented Dickey-Fuller (ADF) test was used to assess stationarity. Differencing requirements were considered as part of the modelling process.

### 5. SARIMA Model Selection

Autocorrelation Function (ACF) and Partial Autocorrelation Function (PACF) plots were examined to guide the selection of candidate model orders.

Multiple SARIMA specifications were compared using the Akaike Information Criterion (AIC) and Bayesian Information Criterion (BIC) to identify a suitable model.

### 6. Model Diagnostics

The selected model was assessed using residual diagnostics, including checks for residual autocorrelation and normality, to evaluate whether the model adequately captured the patterns in the historical series.

### 7. Forecasting

The selected SARIMA model was used to forecast monthly visitor arrivals from January 2026 to December 2028.

The resulting forecasts can help illustrate potential future visitor demand and support planning for tourism services and related infrastructure.

## Tools and Techniques

- **R / RStudio** — statistical analysis and time series modelling
- **SARIMA** — seasonal time series forecasting
- **ADF test** — stationarity assessment
- **ACF and PACF** — model identification
- **AIC and BIC** — candidate model comparison
- **Log transformation** — variance stabilisation
- **Classical decomposition** — trend and seasonal analysis
- **Residual diagnostics** — model adequacy assessment
- **Data visualisation** — exploration of historical patterns and forecasts

## Key Findings and Outputs

The analysis explored several important characteristics of New Zealand visitor arrivals to Australia:

- A long-term upward trend in historical visitor arrivals.
- Recurring seasonal patterns in monthly visitor numbers.
- A pronounced decline around March 2020 during the COVID-19 period.
- The use of transformation and stationarity testing to prepare the series for modelling.
- Comparison of candidate SARIMA models using AIC and BIC.
- Forecasts of monthly visitor arrivals for the three-year period from January 2026 to December 2028.

*Note: The final model specification, numerical forecast results, and diagnostic findings can be added here once the corresponding results from the analysis are included.*

## Project Structure

The repository is intended to contain the following files:

```text
nz-australia-visitor-forecasting/
├── README.md
├── forecast_analysis.R
├── data/
│   └── nz_visitor_arrivals.csv
└── plots/
    ├── historical_visitor_arrivals.png
    ├── log_transformed_series.png
    ├── time_series_decomposition.png
    └── visitor_arrivals_forecast.png
```

The file and folder names above are suggested examples. Update them to match the files actually included in the repository.

## How to Run the Project

1. Install R and, optionally, RStudio.
2. Clone or download this repository.
3. Place the CSV dataset in the appropriate data directory.
4. Open `forecast_analysis.R` in RStudio.
5. Check that the dataset path in the script matches the local file location.
6. Install any R packages required by the script.
7. Run the analysis to reproduce the data exploration, model fitting, diagnostics, and forecasts.

## Limitations and Future Improvements

- The COVID-19 period represents an unusual disruption that may affect the model's ability to capture future structural changes.
- Forecast reliability depends on the quality of the historical data and the suitability of the selected model.
- Future work could compare SARIMA forecasts with alternative methods, evaluate out-of-sample forecast accuracy, and investigate the effects of major travel disruptions or policy changes.

## Author's Note

This project was completed as an applied time series analysis exercise, demonstrating the use of statistical modelling and forecasting techniques to investigate a real-world tourism dataset.

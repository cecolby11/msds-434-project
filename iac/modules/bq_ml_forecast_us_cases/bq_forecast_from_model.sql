#standardSQL
SELECT
 *
FROM
 ML.FORECAST(MODEL latest_nyt_dev.forecast_cases_by_state,
             STRUCT(7 AS horizon, 0.9 AS confidence_level))

-- helpful resources: 
-- https://cloud.google.com/bigquery-ml/docs/arima-multiple-time-series-forecasting-tutorial#step_eight_use_your_model_to_forecast_multiple_time_series_simultaneously

CREATE OR REPLACE MODEL msds_434_project.forecast_cases_by_state
OPTIONS
  (model_type = 'ARIMA_PLUS',
   time_series_timestamp_col = 'date',
   time_series_data_col = 'num_cases',
   time_series_id_col = 'state_name',
   auto_arima_max_order = 5
  ) AS
SELECT
    date, state_name, SUM(confirmed_cases) AS num_cases
FROM `bigquery-public-data.covid19_nyt.us_states`
GROUP BY state_name, date

-- helpful resources learning to create time series models in big query: 
-- https://cloud.google.com/bigquery-ml/docs/arima-multiple-time-series-forecasting-tutorial#step_eight_use_your_model_to_forecast_multiple_time_series_simultaneously

For now, I have done the model creation and forecasting from the model in the console. I might go back and terraform or script the Big Query ML components once I have an MVP working but that isn't a priority for the time being. 

Workflow
- run the query in `bq_create_model.sql` to create the model from the NYT public dataset of case numbers per day by state (historical)
- create a scheduled query job to 
  - run the query in `bq_forecast_from_model.sql` to create a forecast over N time periods from the model every X time period 
  - overwrite the results in a big query table

- GAE app phase 2
  - show the cumulative number of cases per state on a map. Have a slider that lets you adjust it to the forecasted number of cases in 1 week?

- GAE app phase 2
  - the forecasting runs as a scheduled query every 7 days and spits out the next 7 days 
  - input a state in the GAE query params or the path 
  - GAE returns a graph of the historical data that the model was trained on 
  - and shows the forecasted data and displays the actuals from the ETL table (that weren't part of model training?)



also serve up the probability you'll encounter someone in a mask, because that is cool data
https://www.luumichael.com/post/covid19_mask_usage/


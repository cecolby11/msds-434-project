const { BigQuery } = require('@google-cloud/bigquery');
const logger = require('../utils/logger');
const bq = new BigQuery();

module.exports = {

    async forecastCumulativeCases(state) {
        logger.info('getting weekly forecast for', state);
        try {
            const forecastCumulativeCases = `SELECT forecast_timestamp, forecast_value
            FROM \`latest_nyt_dev.covid19_weekly_cases_forecast_by_state\`
            WHERE LOWER(state_name) = '${state.toLowerCase()}' AND
            forecast_timestamp > CURRENT_TIMESTAMP() AND forecast_timestamp < TIMESTAMP_ADD(CURRENT_TIMESTAMP, INTERVAL 7 DAY)`;

            // For all options, see https://cloud.google.com/bigquery/docs/reference/rest/v2/jobs/query
            const options = {
                query: forecastCumulativeCases,
                // Location must match that of the dataset(s) referenced in the query.
                location: 'US',
            };
        
            const [rows] = await bq.query(options);

            return rows;
        } catch (err) {
            logger.error('AN ERROR OCCURRED');
            logger.error(err);
            return err;
        }
    },
};

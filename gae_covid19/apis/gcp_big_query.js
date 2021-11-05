const { BigQuery } = require('@google-cloud/bigquery');
const bq = new BigQuery();

module.exports = {

    async forecastCumulativeCases(state) {
        console.log('getting weekly forecast for', state);
        try {
            const forecastCumulativeCases = `SELECT forecast_timestamp, forecast_value
            FROM \`msds_434_project.nyt_weekly_forecast_by_state\`
            WHERE LOWER(state_name) = @state AND
            forecast_timestamp > CURRENT_TIMESTAMP() AND forecast_timestamp < TIMESTAMP_ADD(CURRENT_TIMESTAMP, INTERVAL 7 DAY)`;

            // For all options, see https://cloud.google.com/bigquery/docs/reference/rest/v2/jobs/query
            const options = {
                query: forecastCumulativeCases,
                // Location must match that of the dataset(s) referenced in the query.
                location: 'US',
                params: { state: state.toLowerCase() },
            };
        
            const [rows] = await bq.query(options);

            return rows;
        } catch (err) {
            console.error('AN ERROR OCCURRED');
            console.error(err);
            return err;
        }
    },
};

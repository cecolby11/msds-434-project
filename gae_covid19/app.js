// NOTE: You do not need to include the node_modules folder when you manually upload code as a .zip file—you can successfully deploy your function without the the node_modules folder.
const express = require('express');
const monitoring = require('@google-cloud/monitoring');
const bq = require('./apis/gcp_big_query');
const logger = require('./utils/logger');
  
// Create an Express object and routes (in order)
const app = express();
const client = new monitoring.MetricServiceClient();

app.get('/', (req, res) => {
    res.send(`<h4>Welcome</h4>
    <p>Visit /api/v1/{your state name}/cumulative/forecast 
    to see the forecasted number of cumulative cases for your state`
    )
});

app.get('/api/v1/:state/cumulative/forecast', async (req, res) => {
    try {
        const rows = await bq.forecastCumulativeCases(req.params.state);
        if (rows.length === 0) {
            logger.error(`Returning 404 for ${req.params.state}`, {
                httpRequest: {
                    status: 404,
                    requestUrl: req.url,
                    requestMethod: req.method,
                    remoteIp: req.connection.remoteAddress,
                    // etc.
                },
                state: req.params.state,
            });
            return res.status(404).json({
                error: {
                    code: 404,
                    message: 'no predictions found for state'
                }
            });
        }
        const results = {
            state: req.params.state,
            results: rows,
        };
        logger.info(`Returning results for ${req.params.state}`, {
            httpRequest: {
                status: 200,
                requestUrl: req.url,
                requestMethod: req.method,
                remoteIp: req.connection.remoteAddress,
                // etc.
            },
            state: req.params.state,
        });
        return res.json(results);
    } catch (err) {
        logger.error(`Returning 500 for ${req.params.state}`, {
            httpRequest: {
                status: 500,
                requestUrl: req.url,
                requestMethod: req.method,
                remoteIp: req.connection.remoteAddress,
                // etc.
            },
            state: req.params.state
        });
        return res.status(500).json({
            error: {
                code: 500,
                message: 'no predictions found for state'
            }
        });
    }
});


// Start the server
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  logger.info(`App listening on port ${PORT}`);
  logger.info('Press Ctrl+C to quit.');
});

module.exports = app;

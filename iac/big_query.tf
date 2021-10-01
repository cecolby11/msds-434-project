resource "google_bigquery_dataset" "nyt" {
  dataset_id                  = "latest_nyt_dataset"
  friendly_name               = "nyt_latest"
  description                 = "This is a test description"
  location                    = "US"

  labels = {
    env = "default"
    terraform = true
  }
}

resource "google_bigquery_table" "nyt" {
  dataset_id = google_bigquery_dataset.nyt.dataset_id
  table_id   = "county_cases_deaths"

  labels = {
    env = "default"
    terraform = true
  }

# date,county,state,fips,cases,deaths
  schema = <<EOF
[
  {
    "name": "date",
    "type": "DATE",
    "mode": "NULLABLE"
  },
  {
    "name": "county",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "fips",
    "type": "STRING",
    "mode": "NULLABLE"
  },  
  {
    "name": "cases",
    "type": "INTEGER",
    "mode": "NULLABLE"
  },
  {
    "name": "deaths",
    "type": "INTEGER",
    "mode": "NULLABLE"
  }
]
EOF

}

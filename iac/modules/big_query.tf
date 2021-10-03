resource "google_bigquery_dataset" "nyt" {
  dataset_id    = "latest_nyt_${var.env}"
  friendly_name = "nyt_latest_${var.env}"
  description   = "This is a test description"
  location      = "US"

  labels = local.labels
}

resource "google_bigquery_table" "nyt" {
  dataset_id = google_bigquery_dataset.nyt.dataset_id
  table_id   = "county_cases_deaths-${var.env}"

  labels = local.labels
  # NOTE: : On newer versions of the provider, you must explicitly set deletion_protection=false (and run terraform apply to write the field to state) in order to destroy an instance. 
  # It is recommended to not set this field (or set it to true) until you're ready to destroy.
  deletion_protection = false // # @TODO: flip this to true once I have the infra how I want it 


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

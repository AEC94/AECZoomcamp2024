# New York Taxi Data Ingestion Project

This project facilitates the ingestion of New York taxi data into a PostgreSQL database using a Docker container. The data is sourced from public datasets provided by the city of New York.

## Requirements

- [Docker](https://www.docker.com/)
- [Python](https://www.python.org/) (for ingestion scripts)

## Usage Instructions

### Step 1: Build Docker Image

```bash
docker build -t taxi_ingest:v001 .
```
### Step 2: Run Data Ingestion
Green Taxi Data Ingestion

URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"

```bash
if docker run -it \
  --network=aeczoomcamp2024_default \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=pgdatabase \
    --port=5432 \
    --db=ny_taxi \
    --table_name=green_taxi_trips \
    --url=${URL}; then
  echo "Ingestion of green taxi data successful"
else
  echo "Error in green taxi data ingestion"
  exit 1
fi
```

Taxi zones Ingestion

URL="https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv"
```bash
if docker run -it \
  --network=aeczoomcamp2024_default \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=pgdatabase \
    --port=5432 \
    --db=ny_taxi \
    --table_name=taxi_zones \
    --url=${URL}
  echo "Ingestion of taxi zones successful"
else
  echo "Error in taxi zones ingestion"
  exit 1
fi
```
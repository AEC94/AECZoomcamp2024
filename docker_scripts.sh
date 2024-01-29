URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"

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

URL="https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv"

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
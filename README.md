## Requirements

- google-cloud-storage
- gcloud

## Usage Instructions

### Step 1: Upload data to GCS

```bash
python web_to_gcs.py
```
### Step 2: Run queries

### External table
```sql
CREATE OR REPLACE EXTERNAL TABLE `zoomcamp2024-412721.ny_taxi.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://homework-week3-aec/*']
);
```

This query creates an external table named external_green_tripdata pointing to Parquet files stored in a Google Cloud Storage (GCS) bucket.

### Materialized table
```sql
CREATE OR REPLACE TABLE `zoomcamp2024-412721.ny_taxi.green_tripdata` AS
SELECT * FROM `zoomcamp2024-412721.ny_taxi.external_green_tripdata`;
```

This query creates a materialized table named green_tripdata by selecting all data from the external table external_green_tripdata.

### Question 1:
```sql
SELECT COUNT(*) FROM `zoomcamp2024-412721.ny_taxi.external_green_tripdata`;
```
This query counts the total number of records in the external table external_green_tripdata.

### Question 2:
```sql
SELECT COUNT(DISTINCT PULocationID) FROM `zoomcamp2024-412721.ny_taxi.external_green_tripdata`; --0B

SELECT COUNT(DISTINCT PULocationID) FROM `zoomcamp2024-412721.ny_taxi.green_tripdata`; --6.41MB

```
The first query counts the distinct number of PULocationIDs in the external table external_green_tripdata, and the second query counts the same in the materialized table green_tripdata.

### Question 3:
```sql
SELECT COUNT(*)
FROM `zoomcamp2024-412721.ny_taxi.green_tripdata`
WHERE fare_amount = 0;
```
This query counts the number of records in the materialized table green_tripdata where the fare amount is 0.

### Question 4:
```sql
CREATE OR REPLACE TABLE `zoomcamp2024-412721.ny_taxi.green_tripdata_optimized`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM `zoomcamp2024-412721.ny_taxi.external_green_tripdata`;
```
This query creates a partitioned and clustered table named green_tripdata_optimized by selecting all data from the external table external_green_tripdata.

### Question 5:
```sql
SELECT DISTINCT PUlocationID
FROM `zoomcamp2024-412721.ny_taxi.green_tripdata`
WHERE lpep_pickup_datetime BETWEEN '2022-06-01' AND '2022-06-30';

SELECT DISTINCT PUlocationID
FROM `zoomcamp2024-412721.ny_taxi.green_tripdata_optimized`
WHERE lpep_pickup_datetime BETWEEN '2022-06-01' AND '2022-06-30';
```
The first query selects distinct PULocationIDs within a specific date range from the materialized table green_tripdata, and the second query does the same from the partitioned and clustered table green_tripdata_optimized.
-- External table
CREATE OR REPLACE EXTERNAL TABLE `zoomcamp2024-412721.ny_taxi.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://homework-week3-aec/*']
);

-- Materialized table
CREATE OR REPLACE TABLE `zoomcamp2024-412721.ny_taxi.green_tripdata` AS
SELECT * FROM `zoomcamp2024-412721.ny_taxi.external_green_tripdata`;

-- Ex 1
SELECT COUNT(*) FROM `zoomcamp2024-412721.ny_taxi.external_green_tripdata`;

-- Ex 2
SELECT COUNT(DISTINCT PULocationID) FROM `zoomcamp2024-412721.ny_taxi.external_green_tripdata`; --0B
SELECT COUNT(DISTINCT PULocationID) FROM `zoomcamp2024-412721.ny_taxi.green_tripdata`; --6.41MB

-- Ex 3
SELECT COUNT(*)
FROM `zoomcamp2024-412721.ny_taxi.green_tripdata`
WHERE fare_amount = 0;

-- Ex 4
CREATE OR REPLACE TABLE `zoomcamp2024-412721.ny_taxi.green_tripdata_optimized`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM `zoomcamp2024-412721.ny_taxi.external_green_tripdata`;

-- Ex 5
SELECT DISTINCT PUlocationID
FROM `zoomcamp2024-412721.ny_taxi.green_tripdata`
WHERE lpep_pickup_datetime BETWEEN '2022-06-01' AND '2022-06-30';

SELECT DISTINCT PUlocationID
FROM `zoomcamp2024-412721.ny_taxi.green_tripdata_optimized`
WHERE lpep_pickup_datetime BETWEEN '2022-06-01' AND '2022-06-30';


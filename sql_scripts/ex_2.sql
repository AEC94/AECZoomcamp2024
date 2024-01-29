SELECT COUNT(*)
FROM green_taxi_trips
WHERE DATE(lpep_pickup_datetime) = '2019-09-18' AND DATE(lpep_dropoff_datetime) = '2019-09-18'
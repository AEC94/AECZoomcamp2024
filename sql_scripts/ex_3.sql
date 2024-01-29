SELECT DATE(lpep_pickup_datetime) AS pickup_date, MAX(trip_distance) AS max_trip_distance
FROM green_taxi_trips
GROUP BY pickup_date
ORDER BY max_trip_distance DESC
LIMIT 1

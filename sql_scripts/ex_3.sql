SELECT DATE(lpep_pickup_datetime),MAX(trip_distance)
FROM green_taxi_trips
GROUP BY DATE(lpep_pickup_datetime)
ORDER BY MAX(trip_distance) DESC
LIMIT 1
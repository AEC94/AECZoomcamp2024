SELECT tz_dropoff."Zone",MAX(gt.tip_amount)
FROM green_taxi_trips gt
LEFT JOIN taxi_zones tz_pickup ON gt."PULocationID"  = tz_pickup."LocationID"
LEFT JOIN taxi_zones tz_dropoff ON gt."DOLocationID"  = tz_dropoff."LocationID"
WHERE extract(month from gt.lpep_pickup_datetime) = 09
AND extract(year from gt.lpep_pickup_datetime) = 2019
AND tz_pickup."Zone" = 'Astoria'
GROUP BY tz_dropoff."Zone"
ORDER BY MAX(gt.tip_amount) DESC
LIMIT 1

SELECT tz."Borough",SUM(gt.total_amount)
FROM green_taxi_trips gt
LEFT JOIN taxi_zones tz ON gt."PULocationID"  = tz."LocationID"
WHERE DATE(gt.lpep_pickup_datetime) = '2019-09-18' AND tz."Borough" <> 'Unknown'
GROUP BY tz."Borough"
HAVING SUM(gt.total_amount) > 50000
ORDER BY SUM(gt.total_amount) DESC
# Data Engineering Notebook Readme

## Overview
This Jupyter Notebook showcases various data engineering tasks using PySpark, a powerful analytics engine for large-scale data processing. It includes data loading, processing, and analysis tasks using NYC taxi trip data.

## Setup
To run this notebook, make sure you have the required dependencies installed. The notebook uses PySpark version 3.3.2, Findspark, and Pyngrok. You can install these dependencies using pip:

```bash
!pip install pyspark==3.3.2
!pip install findspark
!pip install pyngrok
```

## Configuration
After installing the dependencies, configure the environment. The notebook sets up an Ngrok tunnel to expose the Spark UI to view execution details:

```python
from pyngrok import ngrok, conf
import getpass

conf.get_default().auth_token = getpass.getpass()

ui_port = 4040
public_url = ngrok.connect(ui_port).public_url
print(f" * ngrok tunnel \"{public_url}\" -> \"http://127.0.0.1:{ui_port}\"")
```

## Data Loading
The notebook loads NYC FHV trip data for October 2019 and taxi zone lookup data. It defines schemas for both datasets and loads them into Spark DataFrames:

```python
# Loading FHV trip data
schema_fhv = ...
df_fhv = spark.read \
    .option("header", "true") \
    .schema(schema_fhv) \
    .csv('/content/fhv_tripdata_2019-10.csv')
df_fhv.write.parquet('fhv/2019/10/')
df_fhv.registerTempTable('fhv_tripdata')

# Loading taxi zone data
zones_schema = ...
df_zones = spark.read \
    .option("header", "true") \
    .schema(zones_schema) \
    .csv('/content/taxi_zone_lookup.csv')
df_zones.registerTempTable('zones_data')
```

Data Analysis
The notebook performs various data analysis tasks on the loaded datasets. It calculates the number of trips and maximum trip duration, and performs SQL queries to analyze trip distribution by zone:

```python
# Count trips on a specific date
df_fhv.where(F.to_date('pickup_datetime')=='2019-10-15').count()

# Calculate maximum trip duration
df_fhv.withColumn('diff_hours',(F.col("dropoff_datetime").cast("long") - F.col('pickup_datetime').cast("long"))/F.lit(3600)).agg(F.max('diff_hours')).show()

# Analyze trip distribution by zone
spark.sql("""
SELECT
    Zone,
    count(*) AS trips
FROM
    fhv_tripdata
LEFT JOIN
    zones_data ON PULocationID = LocationID
GROUP BY 
    Zone
ORDER BY trips
""").show()
```

## Conclusion
This notebook demonstrates key data engineering tasks such as data loading, processing, and analysis using PySpark. It serves as a comprehensive guide for handling large-scale datasets and deriving valuable insights.
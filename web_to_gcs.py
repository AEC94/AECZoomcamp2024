import io
import os
import requests
import pandas as pd
from google.cloud import storage

"""
Pre-reqs: 
1. `pip install pandas pyarrow google-cloud-storage`
2. Set GOOGLE_APPLICATION_CREDENTIALS to your project/service-account key
3. Set GCP_GCS_BUCKET as your bucket or change default value of BUCKET
"""

init_url = 'https://d37ci6vzurychx.cloudfront.net/trip-data'
BUCKET = os.environ.get("GCP_GCS_BUCKET", "homework-week3-aec")


def upload_to_gcs(bucket, object_name, local_file):

    client = storage.Client()
    bucket = client.bucket(bucket)
    blob = bucket.blob(object_name)
    blob.upload_from_filename(local_file)


def web_to_gcs(year, service):
    for i in range(12):
        
        # sets the month part of the file_name string
        month = '0'+str(i+1)
        month = month[-2:]

        # csv file_name
        file_name = f"{service}_tripdata_{year}-{month}.parquet"

        # download it using requests via a pandas df
        request_url = f"{init_url}/{file_name}"
        r = requests.get(request_url)
        open(f"data/{file_name}", 'wb').write(r.content)
        print(f"Local: {file_name}")

        # # upload it to gcs 
        upload_to_gcs(BUCKET, f"data/{file_name}", file_name)
        print(f"GCS: {file_name}")


web_to_gcs('2022', 'green')
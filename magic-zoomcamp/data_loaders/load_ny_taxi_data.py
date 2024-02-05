import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    """
    Template code for loading data from any source.

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """

    years_to_load = [2020]
    months_to_load = [10,11,12]

    base_url =  'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata'
    compression_type = '.csv.gz'

    # Specify your data loading logic here
    taxi_dtypes = {
        'VendorID': pd.Int64Dtype(),
        'passenger_count': pd.Int64Dtype(),
        'trip_distance': float,
        'RatecodeID': pd.Int64Dtype(),
        'store_and_fwd_flag': str,
        'PULocationID': pd.Int64Dtype(),
        'DOLocationID': pd.Int64Dtype(),
        'payment_type': pd.Int64Dtype(),
        'fare_amount': float,
        'extra': float,
        'mta_tax': float,
        'tip_amount': float,
        'tolls_amount': float,
        'improvement_surcharge': float,
        'total_amount': float,
        'congestion_surcharge': float 
    }

    parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    result_df = pd.DataFrame()

    for year in years_to_load:
        for month in months_to_load:
            url = f'{base_url}_{year}-{month}{compression_type}'
            print(f'Fetching data from {url}')
            file_compression = 'gzip' if compression_type == '.csv.gz' else 'csv'
            
            print(f'Reading data for {year}-{month}')
            
            df_chunk = pd.read_csv(url, sep=",", compression=file_compression, dtype=taxi_dtypes, parse_dates=parse_dates)
            
            result_df = pd.concat([result_df, df_chunk], ignore_index=True)
    
    return result_df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *
  from {{ source('staging','fhv_tripdata') }}
  where  EXTRACT(YEAR FROM cast(pickup_datetime as timestamp)) = 2019
)
select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['pickup_datetime', 'pulocationid','dolocationid']) }} as fhv_id,
    {{ dbt.safe_cast("pulocationid", api.Column.translate_type("integer")) }} as pickup_locationid,
    {{ dbt.safe_cast("dolocationid", api.Column.translate_type("integer")) }} as dropoff_locationid,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    {{ dbt.safe_cast("SR_Flag", api.Column.translate_type("integer")) }} as shared_trip,

    -- base info
    dispatching_base_num AS dispatch_base,
    affiliated_base_number AS affiliated_base
from tripdata
import inflection
import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here

    data = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)]
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    data.columns = [inflection.underscore(col) for col in data.columns]

    return data


@test
def test_output(output, *args) -> None:
    assert output is not None, 'The output is undefined'

@test
def test_passenger_count(output, *args) -> None:
    assert (output['passenger_count'] > 0).all(), 'passenger_count should be greater than 0'

@test
def test_trip_distance(output, *args) -> None:
    assert (output['trip_distance'] > 0).all(), 'trip_distance should be greater than 0'

@test
def test_vendor_id(output, *args) -> None:
    assert output['vendor_id'].isin([1, 2]).all(), 'Invalid vendor_id values'
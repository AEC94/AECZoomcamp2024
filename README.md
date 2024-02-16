## Requirements

- dlt
- duckdb


## Data Talks Club Data Engineering Zoomcamp: Data Loading Workshop
Welcome to the Data Talks Club Data Engineering Zoomcamp's Data Loading Workshop! In this workshop, we will be practicing data loading techniques using Python generators and DuckDB, focusing on best practices in data engineering.

### Exercise 1: Using a Generator

```python
def square_root_generator(limit):
    n = 1
    while n <= limit:
        yield n ** 0.5
        n += 1

# Example usage:
limit = 13
generator = square_root_generator(limit)

sum = 0
for sqrt_value in generator:
    sum = sqrt_value + sum
    print(sqrt_value)
```
### Exercise 2: Appending a Generator to a Table

### External table
```python
def people_1():
    for i in range(1, 6):
        yield {"ID": i, "Name": f"Person_{i}", "Age": 25 + i, "City": "City_A"}

def people_2():
    for i in range(3, 9):
        yield {"ID": i, "Name": f"Person_{i}", "Age": 30 + i, "City": "City_B", "Occupation": f"Job_{i}"}

```

### Exercise 3: Merging a Generator
```python
import dlt
import duckdb

data = [people_1,people_2]

pipeline = dlt.pipeline(destination='duckdb', dataset_name='people')


info = pipeline.run(data[0],table_name="people",write_disposition="replace",primary_key="record_hash")

print(info)

info = pipeline.run(data[1],table_name="people",write_disposition="append",primary_key="record_hash")

print(info)

conn = duckdb.connect(f"{pipeline.pipeline_name}.duckdb")

conn.sql(f"SET search_path = '{pipeline.dataset_name}'")
print('Loaded tables: ')
display(conn.sql("show tables"))


print("\n\n\n People:")
people_1 = conn.sql("SELECT * FROM people").df()
display(people_1)

print("\n\n\n Age Syn")
age = conn.sql("SELECT SUM(age) FROM people").df()
display(age)


pipeline2 = dlt.pipeline(destination='duckdb', dataset_name='people')

print('Loaded tables: ')
display(conn.sql("show tables"))



info = pipeline2.run(data[0],table_name="people_merged",write_disposition="replace",primary_key="id")

print(info)

info = pipeline2.run(data[1],table_name="people_merged",write_disposition="merge",primary_key="id")

conn2 = duckdb.connect(f"{pipeline2.pipeline_name}.duckdb")
conn2.sql(f"SET search_path = '{pipeline2.dataset_name}'")

print("\n\n\n People Merged:")
people_1 = conn.sql("SELECT * FROM people_merged").df()
display(people_1)

print("\n\n\n Age Syn")
age = conn.sql("SELECT SUM(age) FROM people_merged").df()
display(age)
```

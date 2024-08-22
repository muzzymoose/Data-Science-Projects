# From Raw Data to PostgreSQL Database
- This framework uses python scripts which allow CSV files to be imported to PostgreSQL Database with less hassle.
- Less error when setting column data types and manual query in SQL, 
### Step 1 - Create New Database in PostgreSQL via pgadmin
- Standardize database naming 

### Step 2 - Edit File names and Column Names
- Using python scripts to remove $, %, /, (, ), white spaces, - in file names and column names

### Step 3 - Match CSV data types with SQL data types
- Using python scripts to map object -> VARCHAR etc
- 'object' : 'varchar',
    'float64' : 'float',
    'int64' : 'int',
    'datetime64' : 'timestamp',
    'timedelta64[ns]' : 'varchar'

### Step 4 - Connect to PostgreSQL Database 
- Using python scripts to connect to SQL database

### Step 5 - Remove same table names
- Using python scripts to remove any tables of the same name
- To ensure no error when importing tables

### Step 6 - Create table in Database
- Using python scripts to write SQL queries to
- CREATE TABLE table_name ()

### Step 7 - Disconnect from PostgreSQL Database
- Using python scripts to disconnect from Database

### Step 8 - Setup PK, FK, References in SQL
- This is the only manual part
- Use Dbvisualizer to visualize schema
- ![](https://github.com/muzzymoose/Data-Science-Projects/blob/main/My%20framework/Import%20CSV%20to%20PostgreSQL/dbvisualizer%20schemas.png)

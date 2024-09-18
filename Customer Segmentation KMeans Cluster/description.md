## About Dataset
Data set taken from : https://archive.ics.uci.edu/dataset/502/online+retail+ii <br>

Dataset contains information about an online retailer's customers transactions. The online retailer is based in the UK. Segmenting customers based on their purchase behavior will help the online retailer plan strategies to approach different customers.

## <u>Customer Segmentation using KMeans Cluster</u>
![](https://www.corporatevision-news.com/wp-content/uploads/2022/10/Customer-Segmentation.jpg)

## Data Description<a id='dd'></a>


|Variable Name |	Role	|Type	|Description	|Units	|Missing Values|
|--------------|------------|-------|---------------|-------|--------------|
|Invoice|Feature	| numerical	|  unique identifier for each invoice number	| -	|no|
|StockCode|Feature|numerical|  unique identifier for each stock information | -	|no|
| Description |Feature	| nominal | infromation on item sold 	| -	|yes|
| Quantity|Feature	| numerical | number of item sold	| -	|no|
| InvoiceDate |Feature	| date	| invoice issue date	| -	|no|
| Price|Feature	| numerical	| price of item | british pound |no|
| Customer_ID |Feature	| numerical	| customer's ID | -	|yes|
|Country |Feature	| nominal	| customer's origin country  | -	|no|

Refer to .pynb file in this repos for more info

## Summary Results
![](https://github.com/muzzymoose/Data-Science-Projects/blob/main/Customer%20Segmentation%20KMeans%20Cluster/segmented_cluster.png?raw=true)

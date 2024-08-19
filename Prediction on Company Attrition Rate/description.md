## About Dataset

InnovateIQ Corporation is a technology company specializing in medical instrument based in New 
York. Attrition is a significant concern for InnovateIQ Corporation as it can lead to a loss of valuable 
talent and increased recruitment costs. As a data scientist at InnovateIQ Corporation, your task is to 
generate a machine learning model to predict attrition of employees using historical data, including 
employee demographic information and job-related details, and evaluate the model's performance using 
appropriate metrics. Dataset is available at project_dataset.csv

## <u>Exploratory Data Analysis & Machine Learning on Company Attrition Rate</u>
![](https://www.callcentrehelper.com/images/stories/2022/05/attrition-760.jpg)

## Data Description<a id='dd'></a>


|Variable Name |	Role	|Type	|Description	|Units	|Missing Values|
|--------------|------------|-------|---------------|-------|--------------|
|EmployeeID|Feature	| numerical	|  unique identifier for each employee	| -	|no|
|Age|Feature|numerical|  Age of the employee | years	|no|
| BusinessTravel |Feature	|ordinal|  represents the frequency of travel required for an employee job 	| -	|no|
| MonthlyIncome|Feature	| numerical | income earned per month by an employee	| US dollar	|no|
| JobSatisfaction |Feature	| ordinal	| level of employee satisfaction with their job (higher is better)	| -	|no|
| Bonus|Feature	| numerical	| Additional financial compensation as reward given to employee | US dollar |no|
| Department|Feature	| nominal	| division of an organization that an employee works for | -	|no|
|DistanceFromHome |Feature	| numerical	|variable representing distance of employee's home to office  | km	|no|
|Education |Feature	| numerical	| level of education of employee  | -	|no|
|EducationField |Feature	| nominal	|  field of study in which employee was educated | -	|no|
|EnvSatisfaction |Feature	| numerical	|  | -	|no|
|Gender |Feature	| nominal	| employee's gender  | -	|no|
|JobRole |Feature	|nominal 	| role of the employee within the company  | -	|no|
| MaritalStatus|Feature	| nominal	|  employee's marital status | -	|no|
|PerformanceRating |Feature	| numerical	| employee's performance evaluation rating  | -	|no|
| TrainingTimeLastYear|Feature	|numerical 	|  number of training hours employee received last year | -	|no|
| YearsAtCompany|Feature	| numerical	| number of years employee has worked at company  | -	|no|
|YearsSinceLastPromotion |Feature	|numerical 	| number of years since employee's last promotion  | -	|no|
|Overtime |Feature	| binary	| whether or not employee works overtime  | yes/no	|no|
|Attrition |Target	| binary	|  whether or not employee left the company | yes/no	|no|

Refer to .pynb file in this repos for more info

## Summary Results
![](https://github.com/muzzymoose/Data-Science-Projects/blob/main/EDA%20&%20ML%20predictions%20on%20Medical%20Cost%20Billed%20by%20Health%20Insurance/regressioncomparison.png?raw=true)

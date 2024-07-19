# Exploratory Data Analysis on Impact of HbAlc Measurement on Hospital Readmission Rates

Data source : 

Hindawi Publishing Corporation
BioMed Research International
Volume 2014, Article ID 781670, 11 pages
http://dx.doi.org/10.1155/2014/781670

Research Article
Impact of HbA1c Measurement on Hospital Readmission Rates:
Analysis of 70,000 Clinical Database Patient Records

Management of hyperglycemia in hospitalized patients has a significant bearing on outcome, in terms of both morbidity and
mortality. However, there are few national assessments of diabetes care during hospitalization which could serve as a baseline for
change. This analysis of a large clinical database (74 million unique encounters corresponding to 17 million unique patients) was
undertaken to provide such an assessment and to find future directions which might lead to improvements in patient safety. Almost
70,000 inpatient diabetes encounters were identified with sufficient detail for analysis. Multivariable logistic regression was used to
fit the relationship between the measurement of HbA1c and early readmission while controlling for covariates such as demographics,
severity and type of the disease, and type of admission. Results show that the measurement of HbA1c was performed infrequently
(18.4%) in the inpatient setting. The statistical model suggests that the relationship between the probability of readmission and the
HbA1c measurement depends on the primary diagnosis. The data suggest further that the greater attention to diabetes reflected in
HbA1c determination may improve patient outcomes and lower cost of inpatient care.
<br>

|Feature name |	Type	|Description	|
|-------------|---------|---------------|
|Encounter ID|	Numeric	|Unique identifier of an encounter 	|
|Patient number|	Numeric	|  Unique identifier of a patient	|
|Race|	Nominal	|  Values: Caucasian, Asian, African American, Hispanic, and other	|
|Gender|	Nominal	|  Values: male, female, and unknown/invalid	|
|Age|	Nominal	| Grouped in 10-year intervals: [0, 10), [10, 20), ..., [90, 100)	|
|Weight|	Numeric	| Weight in pounds.	|
|Admission type|	Nominal	| Integer identifier corresponding to 9 distinct values, for example, emergency, urgent, elective, newborn, and not available	|
|Discharge disposition|	Nominal	|  Integer identifier corresponding to 29 distinct values, for example, discharged to home, expired, and not available	|
|Admission source|	Nominal	|  Integer identifier corresponding to 21 distinct values, for example, physician referral, emergency room, and transfer from a hospital	|
|Time in hospital|	Numeric	|  Integer number of days between admission and discharge	|
|Payer code|	Nominal	|  Integer identifier corresponding to 23 distinct values, for example, Blue Cross\Blue Shield, Medicare, and self-pay	|
|Medical specialty|	Nominal	| Integer identifier of a specialty of the admitting physician, corresponding to 84 distinct values, for example, cardiology, internal medicine, family\general practice, and surgeon	|
|Number of medication|	Nominal	| Number of distinct generic names administered during the encounter	|
|Alc test results|	Nominal	| Indicates the range of the result or if the test was not taken. Values: “>8” if the result was greater than 8%, “>7” if the result was greater than 7% but less than 8%, “normal” if the result was less than 7%, and “none” if not measured.	|
|Readmitted|	Nominal	| Days to inpatient readmission. Values: “<30” if the patient was readmitted in less than 30 days, “>30” if the patient was readmitted in more than 30 days, and “No” for no record of readmission.	|
<br>

## Tools
* Programming tool : Python
* Packages : pandas, numpy, seaborn, scipy, matplotlib

## Main Tasks
(1) Clean improper data format / irrelevant data using pandas <br>
(2) Explore data using Exploratory Data Analysis <br>
(3) Identify the relationship between HbAlc measurement levels of patient with readmission rates <br>





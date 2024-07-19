# Exploratory Data Analysis on Impact of HbAlc Measurement on Hospital Readmission Rates
![](https://www.dietvsdisease.org/wp-content/uploads/2017/12/hba1c-diabetes-control-chart.jpg)

## Tools
* Programming tool : Python
* Packages : pandas, numpy, seaborn, scipy, matplotlib, scikit.learn

Data Structure & Objectives
--------
The dataset contains a total of 101,763 samples combined both male and female from different races. Out of all the samples, only 17,018 samples contain HbAlc measurement. 15,388 of the samples are unique patients. We are going to be using those 17,018 samples that contain HbAlc measurement to create models to do predictions on samples that do not contain HbAlc measurement. In this EDA, the HbAlc level measured in % is labelled as normal (<7%), >7% and >8%. The readmission rate is labelled as "No readmission", "Readmitted in <30 days" and "Readmitted in >30 days". Because we are predicting labelled data and not continous data, we are going to be using supervised learning (classification) type of models.

Features
--------

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



### Data Understanding
The main purpose of this EDA is to study the impact of HbAlc measurement on Hospital Readmission rate. Next is to see how other features affect the HbAlc measurements. Each feature is analysed carefully to see the relationships with each other. Questions are raised to carry out further analysis

* How many distinct patients in the dataset? How many of them are male and female? Out of all patients. How many of them were readmitted? and classify them by race, gender and age
* 
<br>






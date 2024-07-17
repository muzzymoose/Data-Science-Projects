/*	Question Set 1 - Easy */
/* Q1: Show first name, last name, and gender of patients whose gender is 'M' */

SELECT first_name, last_name, gender 
FROM patients
WHERE gender = 'M'


/*	Question Set 2 - Easy */
/* Q2: Show first name and last name of patients who does not have allergies. (null) */

SELECT first_name, last_name
FROM patients
WHERE allergies ISNULL


/*	Question Set 3 - Easy */
/* Q3: Show first name of patients that start with the letter 'C' */

SELECT first_name
FROM patients
WHERE first_name LIKE "C%"


/*	Question Set 4 - Easy */
/* Q4: Show first name and last name of patients that weight within the range of 100 to 120 (inclusive) */

SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;


/*	Question Set 5 - Easy */
/* Q5: Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA' */

UPDATE patients
SET allergies = "NKA"
WHERE allergies IS NULL


/*	Question Set 6 - Easy */
/* Q6: Show first name and last name concatinated into one column to show their full name. */

SELECT concat(first_name,' ',last_name) AS full_name
FROM patients


/*	Question Set 7 - Easy */
/* Q7: Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON' */

SELECT first_name, last_name, b.province_name 
FROM patients AS a 
LEFT JOIN province_names AS b 
USING (province_id)


/*	Question Set 8 - Easy */
/* Q8: Show how many patients have a birth_date with 2010 as the birth year. */

SELECT COUNT(birth_date)
FROM patients
WHERE birth_date LIKE "2010%"


/*	Question Set 9 - Easy */
/* Q9: Show the first_name, last_name, and height of the patient with the greatest height. */

SELECT first_name, last_name, MAX(height) AS Max_height
FROM patients
LIMIT 1;


/*	Question Set 10 - Easy */
/* Q10: Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000 */

SELECT *
FROM patients
WHERE 
	patient_id = 1 OR 
	patient_id = 45 OR 
	patient_id = 534 OR 
	patient_id = 879 OR 
	patient_id = 1000


/*	Question Set 11 - Easy */
/* Q11: Show the total number of admissions */

SELECT COUNT(*)
FROM admissions


/*	Question Set 12 - Easy */
/* Q12: Show all the columns from admissions where the patient was admitted and discharged on the same day. */

SELECT *
FROM admissions
WHERE 
	admission_date = discharge_date


/*	Question Set 13 - Easy */
/* Q13: Show the patient id and the total number of admissions for patient_id 579. */

SELECT patient_id, COUNT(admission_date)
FROM admissions
WHERE 
	patient_id = 579


/*	Question Set 14 - Easy */
/* Q14: Based on the cities that our patients live in, show unique cities that are in province_id 'NS'? */

SELECT DISTINCT city
FROM patients
WHERE 
	province_id = 'NS'


/*	Question Set 15 - Easy */
/* Q15: Write a query to find the first_name, last name, and birth date of patients who has height greater than 160 and weight greater than 70 */

SELECT first_name, last_name, birth_date
FROM patients
WHERE 
    	height > 160 AND
    	weight > 70


/*	Question Set 16 - Easy */
/* Q16: Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton' */

SELECT first_name, last_name, allergies
FROM patients
WHERE 
	allergies IS NOT NULL AND
    	city = 'Hamilton'


/* Question Set17 -  Medium */
/* Q17: Show unique birth years from patients and order them by ascending.  */

SELECT DISTINCT YEAR(birth_date)
FROM patients
ORDER BY birth_date ASC


/* Question Set18 -  Medium */
/* Q18: Show unique first names from the patients table which only occurs once in the list. For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.  */

SELECT DISTINCT first_name
FROM patients
GROUP BY first_name 
HAVING COUNT(first_name) = 1


/* Question Set19 -  Medium */
/* Q19: Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.  */

SELECT patient_id,first_name
FROM patients
WHERE 	first_name LIKE 'S%' AND
	first_name LIKE '%s' AND
   	len(first_name) >= 6


/* Question Set20 -  Medium */
/* Q20: Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.  */

SELECT a.patient_id, p.first_name, p.last_name
FROM admissions AS a 
LEFT JOIN patients AS p 
USING (patient_id)
WHERE diagnosis = 'Dementia'


/* Question Set21 -  Medium */
/* Q21: Display every patient's first_name. Order the list by the length of each name and then by alphabetically  */

SELECT first_name
FROM patients
ORDER BY len(first_name) ASC, first_name ASC


/* Question Set22 -  Medium */
/* Q22: Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.  */

SELECT
    (SELECT COUNT(*) FROM patients WHERE gender = 'M'),
    (SELECT COUNT(*) FROM patients WHERE gender = 'F')


/* Question Set23 -  Medium */
/* Q23: Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.  */

SELECT first_name, last_name, allergies
FROM patients
WHERE allergies = 'Penicillin' OR allergies = 'Morphine'
ORDER BY allergies ASC, first_name ASC, last_name ASC


/* Question Set24 -  Medium */
/* Q24: Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.  */

SELECT patient_id , diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING 	COUNT(patient_id) >=2 AND
	COUNT(diagnosis) >=2


/* Question Set25 -  Medium */
/* Q25: Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.  */

SELECT city, COUNT(patient_id) AS count_patient
FROM patients
GROUP BY city
ORDER BY count_patient DESC, city


/* Question Set26 -  Medium */
/* Q26: Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"  */

SELECT first_name, last_name, 'Patient' AS role 
FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' 
FROM doctors;


/* Question Set27 -  Medium */
/* Q27: Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query.  */

SELECT allergies, COUNT(*) AS total_diagnosis
FROM patients AS p 
WHERE allergies IS not null
GROUP BY p.allergies
ORDER BY total_diagnosis DESC


/* Question Set28 -  Medium */
/* Q28: Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.  */

SELECT first_name, last_name, birth_date
FROM patients
WHERE year(birth_date) IN (1970,1971,1972,1973,1974,1975,1976,1977,1978,1979)
ORDER BY birth_date ASC


/* Question Set29 -  Medium */
/* Q29: We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order. EX: SMITH,jane  */

SELECT concat(upper(last_name),",",LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC


/* Question Set30 -  Medium */
/* Q30: Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.  */

SELECT province_id, SUM(height)
FROM patients
GROUP BY province_id
HAVING SUM(height) > 7000


/* Question Set31 -  Medium */
/* Q31: Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'  */

SELECT MAX(weight) - MIN(weight) AS weight_diff
FROM patients
WHERE last_name LIKE '%Maroni'


/* Question Set32 -  Medium */
/* Q32: Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.  */

SELECT day(admission_date), COUNT(*) AS count_days
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY count_days DESC


/* Question Set33 -  Medium */
/* Q33: Show the all columns for patient_id 542's most recent admission_date.  */

SELECT *
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1


/* Question Set34 -  Medium */
/* Q34: Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria: (1) patient_id is an odd number and attending_doctor_id is either 1, 5, or 19. (2) attending_doctor_id contains a 2 and the length of patient_id is 3 characters.  */

SELECT patient_id,attending_doctor_id,diagnosis
FROM admissions
WHERE ((patient_id%2) IS NOT 0 AND (attending_doctor_id = 1 or 
                                    attending_doctor_id = 5 or 
                                    attending_doctor_id = 19)) 
                                    OR 
                                   ((STR(attending_doctor_id) LIKE '%2' or
                                     STR(attending_doctor_id) LIKE '2%')AND 
                                    LEN(patient_id) = 3)


/* Question Set35 -  Medium */
/* Q35: Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.  */

SELECT 
    (SELECT first_name
     FROM	doctors
    WHERE doctors.doctor_id = admissions.attending_doctor_id) AS doc_firstname,
    (SELECT last_name
     FROM	doctors
    WHERE doctors.doctor_id = admissions.attending_doctor_id) AS doc_lastname , COUNT(admission_date)
FROM admissions
GROUP BY attending_doctor_id


/* Question Set36 -  Medium */
/* Q36: For each doctor, display their id, full name, and the first and last admission date they attended.  */

SELECT 
    (SELECT doctor_id
     FROM	doctors
    WHERE doctors.doctor_id = admissions.attending_doctor_id),
    (SELECT concat(first_name,' ',last_name)
     FROM	doctors
    WHERE doctors.doctor_id = admissions.attending_doctor_id) AS doc_fullname,
    min(admission_date), max(admission_date)
FROM admissions
GROUP BY attending_doctor_id


/* Question Set37 -  Medium */
/* Q37: Display the total amount of patients for each province. Order by descending.  */

SELECT 
     (SELECT province_names.province_name
     FROM province_names
     WHERE province_names.province_id=patients.province_id) AS province, COUNT(*) AS patient_count
FROM patients
LEFT JOIN province_names
ON patients.province_id = province_names.province_id
GROUP BY province_names.province_name 
ORDER BY patient_count DESC


/* Question Set38 -  Medium */
/* Q38: For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.  */

SELECT 
     (SELECT concat(first_name,' ',last_name)
     FROM patients
     WHERE patients.patient_id=admissions.patient_id) AS patient_fullname, diagnosis,
     (SELECT concat(first_name,' ',last_name)
      FROM doctors
      WHERE doctors.doctor_id=admissions.attending_doctor_id) AS doctor_fullname
FROM admissions


/* Question Set39 -  Medium */
/* Q39: display the first name, last name and number of duplicate patients based on their first name and last name.  */

SELECT first_name, last_name, COUNT(*) count_patientsname
FROM patients
GROUP BY first_name,last_name
HAVING count_patientsname >1


/* Question Set40 -  Medium */
/* Q40: Display patient's full name, height in the unit feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated. Convert CM to feet by dividing by 30.48. Convert KG to pounds by multiplying by 2.205.  */

SELECT 
    concat(first_name,' ',last_name) AS full_name, 
    round(height/30.48,1) AS ft, 
    round(weight*2.205,0) AS lbs,
    birth_date,
    	CASE WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
        END AS 'gender type'
FROM patients


/* Question Set41 -  Medium */
/* Q41: Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)  */

SELECT patient_id, first_name, last_name
FROM patients
WHERE patient_id NOT IN 
		(SELECT patient_id
		FROM admissions
		WHERE admissions.patient_id = patients.patient_id) 


/* Question Set42 -  Hard */
/* Q42: Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending. For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.  */

SELECT
  COUNT(*) AS patients_in_group,
  FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;


/* Question Set43 -  Hard */
/* Q43: Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m)2) >= 30. weight is in units kg. height is in units cm.  */

SELECT patient_id, weight, height, 
  (CASE 
      WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
          1
      ELSE
          0
      END) AS isObese
FROM patients;


/* Question Set44 -  Hard */
/* Q44: Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Dementia' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.  */

SELECT patient_id,  
      (SELECT first_name
      FROM patients
      WHERE patients.patient_id = admissions.patient_id) AS patient_firstname,
      (SELECT last_name
      FROM patients
      WHERE patients.patient_id = admissions.patient_id) AS patient_lastname, 
      (SELECT specialty
       FROM doctors
       WHERE doctors.doctor_id=admissions.attending_doctor_id) AS doc_specialty
FROM admissions
WHERE diagnosis = 'Epilepsy' AND
	attending_doctor_id IN 
    	(SELECT doctor_id
         FROM doctors
         WHERE doctors.doctor_id = admissions.attending_doctor_id AND
         first_name = 'Lisa')


/* Question Set45 -  Hard */
/* Q45: All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password. The password must be the following, in order:  */
/*  1. patient_id  */
/*  2. the numerical length of patient's last_name  */
/*  3. year of patient's birth_date  */

SELECT DISTINCT a.patient_id, 
	(SELECT CONCAT(patient_id,len(last_name),YEAR(birth_date))
         FROM patients AS p 
         WHERE p.patient_id = a.patient_id) AS 'temp_password'
FROM admissions AS a 


/* Question Set46 -  Hard */
/* Q46: Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance. Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.  */

SELECT
    (CASE when patient_id%2 = 0 THEN 'Yes' ELSE 'No' END) AS 'has_insurance',
    SUM((CASE WHEN patient_id%2 = 0 THEN 10 ELSE 50 END)) AS 'admission_cost'
FROM admissions
GROUP BY has_insurance


/* Question Set47 -  Hard */
/* Q47: Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name  */

SELECT
     (SELECT p2.province_name
     FROM province_names AS p2
     WHERE p2.province_id = p1.province_id) AS province_name1
FROM patients AS p1
GROUP BY province_name1
HAVING CASE WHEN SUM(gender = 'M') > SUM(gender = 'F') THEN 1 ELSE 0 END


/* Question Set48 -  Hard */
/* Q48: We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:  */
/*  - First_name contains an 'r' after the first two letters.  */
/*  - Identifies their gender as 'F'  */
/*  - Born in February, May, or December  */
/*  - Their weight would be between 60kg and 80kg  */
/*  - Their patient_id is an odd number  */
/*  - They are from the city 'Kingston'  */

SELECT *
FROM patients AS p1
WHERE 	month(birth_date) IN (2, 5, 12) AND
	gender = 'F' AND
        weight BETWEEN 60 AND 80 AND
        (patient_id%2) IS NOT 0 AND
        first_name LIKE '__r%' AND
        city = 'Kingston'


/* Question Set49 -  Hard */
/* Q49: Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.  */



/* Question Set50 -  Hard */
/* Q50: For each day display the total amount of admissions on that day. Display the amount changed from the previous date.  */



/* Question Set51 -  Hard */
/* Q51: Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.  */



/* Question Set52 -  Hard */
/* Q52: We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.  */





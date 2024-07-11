# Analyzing Students' Mental Health
![](https://incontact.com.sg/wp-content/uploads/2021/05/Student-Stress.jpg)
## Project Overview:
Does going to university in a different country affect your mental health? A Japanese international university surveyed its students in 2018 and published a study the following year that was approved by several ethical and regulatory boards.
The dataset provides an expansive compilation of salary and demographic information, augmented by details regarding years of professional experience. It serves as a valuable resource for investigating the intricate relationship between income and various socio-demographic factors. Demographic features such as age, gender, education level, country of origin, and race constitute the foundation for a comprehensive analysis. This dataset empowers researchers to uncover patterns and trends in income distribution across diverse demographic categories, shedding light on potential variations or inequalities in earning potential. Additionally, the dataset incorporates a crucial dimension - "Years of Experience" - offering a lens into the impact of accumulated professional tenure on salary levels. This dynamic facet enables in-depth exploration of how income is influenced by both demographic attributes and the evolution of professional expertise. Overall, the dataset presents an opportunity for conducting exhaustive studies on income diversity and gaining insights into the multifaceted determinants that shape earning prospects in today's workforce.
## Data Dictionary:
The dataset includes the following columns:

| Field Name      | Description                                        |
| --------------  | -------------------------------------------------- |
| `inter_dom`     | Types of students (international or domestic)      |
| `japanese_cate` | Japanese language proficiency                      |
| `english_cate`  | English language proficiency                       |
| `academic`      | Current academic level (undergraduate or graduate) |
| `age`           | Current age of student                             |
| `stay`          | Current length of stay in years                    |
| `todep`         | Total score of depression (PHQ-9 test)             |
| `tosc`          | Total score of social connectedness (SCS test)     |
| `toas`          | Total score of acculturative stress (ASISS test)   |

## PostgreSQL Tasks:
Explore the `students` data using PostgreSQL to find out if you would come to a similar conclusion for international students and see if the length of stay is a contributing factor.
Here is a data description of the columns you may find helpful.<br>
  
  1 - Return a table with nine rows and five columns. <br>
  2 - The five columns should be aliased as: `stay`, `count_int`, `average_phq`, `average_scs`, and `average_as`, in that order. <br>
  3 - The average columns should contain the average of the `todep` (PHQ-9 test), `tosc` (SCS test), and `toas` (ASISS test) columns for each length of stay, rounded to two decimal places.<br>
  4 - The `count_int` column should be the number of international students for each length of stay. Sort the results by the length of stay in descending order.

  ## Python Correlation and Prediction Tests:
From the original dataset. Obtain the following insights. <br>

  1 - Check class proportion of `inter_dom`, `region` and `gender `. Describe findings <br>
  2 - Check `dep` rate and `suicide` rate in both male and female. Describe findings <br>
  3 - Check student's `age` and `todep` distribution. Describe findings <br>
  4 - Is there any relation between `age` and `todep`? Describe findings <br>
  5 - Is there any relation between `stay` and `todep`? Describe findings <br>
  6 - Is there any relation between `gender` and `todep`? Describe findings <br>
  7 - Is there any relation between `region` and `todep`? Describe findings <br>
  
  

## Coursera Courses Analysis
---

### Table of Contents
- [Overview](#Overview)
- [Data source](#Data-source)
- [Tools](#Tools)
- [Data Cleaning and Preparation](#Data-Cleaning-and-Preparation)
- [Data Analysis](#Data-Analysis)
- [Findings](#Findings)
- [Recommendations](#Recommendations)
- [Limitations](#Limitations)

###  Overview 
The purpose of the analysis is to gain insights into the most popular courses offered on Coursera, the most popular organizations, and the distribution of students and courses across certificate types, course levels, and course durations.

![overview1](https://github.com/Robert-Kirui/coursera-courses-analysis/assets/151769501/605376b0-ba41-4a9c-a35d-45f9499cd886)
![overview2](https://github.com/Robert-Kirui/coursera-courses-analysis/assets/151769501/f0ab0617-283b-4ad0-96b3-3343e2c3284c)


### Data source 
The dataset was obtained from Kaggle and can be downloaded [here](https://www.kaggle.com/datasets/tianyimasf/coursera-course-dataset)
The dataset contains 1,000 records of courses offered by various organizations across different fields. Each record in the dataset contains course title, organization, course duration, certificate type, course level (beginner, intermediate, advanced, or mixed), skills, number of students enrolled, number of reviews, course rating, and URL. 

### Tools
- MS Excel
- MS SQL Server
- Power BI

### Data Cleaning and Preparation
- Missing Values:
  - Course rating - Missing values in 6 rows. All the 6 rows were also missing values in the number of reviews column, and were deleted given the importance of the two columns in the analysis.
  - Number of reviews - Missing values in 6 rows. All the 6 rows were also missing values in the course rating column, and were deleted given the importance of the two columns in the analysis.
  - Number of students enrolled – Missing values in 36 rows, a significant number. All rows kept.
  - Course skills - Missing values in 355 rows. All rows kept.

- Duplicate values: Since we're looking at different courses offered by different institutions, both the course_title and organization columns can be combined to form a primary key. A course title alone cannot uniquely identify a course because many organizations can use the same title for their courses. However, the same course title offered by the same organization is considered duplicate in this case. For example, a course titled “Business Analytics” offered by the University of Pennsylvania is different another course with same title offered by University of Illinois at Urbana-Champaign. However, two courses titled “Google Data Analytics” both offered by Google is considered duplicate.
- Removing columns that are irrelevant for analysis
  - Course description, Course URL, and course summary columns were removed.
- Formatting values
  - Course titles, organizations names, and column names.

### Data Analysis 
The analysis seeks to answer the following key questions, among others: 
1. What are the most popular courses based on the number of students enrolled?
2. What are the most popular organizations?
3. Which certificate types (Courses, Specializations, Professional Certificates, and Guided Projects) are the most in-demand?
4. What is the distribution of courses across course levels(e.g., beginner, intermediate, advanced)? Are certain levels more prevalent than others?

```SQL
/* Most popular courses based on the number of students enrolled */
SELECT TOP 20 
course_title, 
course_organization, 
course_certificate_type, 
course_students_enrolled, 
course_duration
FROM coursera_courses
ORDER BY course_students_enrolled DESC;
```


```SQL
/* Stand-out organizations */
SELECT 
	course_organization, 
	COUNT(course_organization) AS Number_of_Courses,
	(COUNT(course_organization)*100.0/(SELECT COUNT(course_organization) FROM coursera_courses)) AS Percentage_of_all_Courses,
	SUM(course_students_enrolled) AS Number_of_Students, 
	(SUM(course_students_enrolled)*100.0/(SELECT SUM(course_students_enrolled) FROM coursera_courses)) AS Percentage_of_all_Students
FROM coursera_courses
GROUP BY course_organization
ORDER BY Number_of_Students DESC;
```

```SQL
/* Distribution of certificate types */
SELECT
	course_certificate_type, 
	COUNT(course_certificate_type) AS Number_of_Courses, 
	(COUNT(course_certificate_type)*100.0/(SELECT COUNT(course_certificate_type) FROM coursera_courses)) AS In_Percentage
FROM coursera_courses
GROUP BY course_certificate_type
ORDER BY Number_of_Courses DESC;
```

```SQL
/* Distribution of courses across course levels */
SELECT 
	course_level, 
	COUNT(course_level) AS Number_of_Courses,
	(COUNT(course_level)*100.0/ (SELECT COUNT(course_level) FROM coursera_courses)) AS Percentage_of_all_Courses
FROM coursera_courses
GROUP BY course_level
ORDER BY Number_of_Courses DESC;
```

```SQL
/* Most popular course duration */
SELECT 
	course_duration, 
	COUNT(course_duration) AS Total_in_Number, 
	(COUNT(course_duration)*100.0/(SELECT COUNT(course_duration) FROM coursera_courses)) AS In_Percentage
FROM coursera_courses
GROUP BY course_duration
ORDER BY Total_in_Number DESC;
```

### Findings
- Longer courses are more popular than shorter courses. 45.6% of all courses have 3 – 6 months duration and 34.0% have 1 – 3 months duration. Only 8.0% of the courses have less than 2 hours duration. Additionally, 16 out of the top 20 popular courses (based on the number of students enrolled) have a duration of at least 1 – 3 months. Those with one month or less are only 4.
- Google is a stand out organization in terms of both the number of students enrolled and the number of courses offered. Google attracts 18.5% of all students enrolled and offers 9.5% of all courses. IBM, University of Pennsylvania, University of Michigan, and Deep Learning.AI are also in the top 5 in terms of students enrolled and number of courses offered. 
- Courses are the most in-demand compared to other certificate types. 49.5% of all the certificates are Courses, 39.6% are Specializations, and 10.1% are Professional certificates. Also, 17 out of the top 20 most popular courses (based on the number of students enrolled) are Courses; 2 are Professional certificates, and one is a specialization.
- Beginner courses are more popular compared to intermediate, advanced, and mixed courses. A whopping 67.6% of all courses offered on Coursera are beginner level, 20.6% are intermediate level, 8.3% are mixed, and only 3.5% are advanced level.
- No courses have exceptionally high rating. About 90 courses have a rating of 4.9 and above. However, 2 courses, ‘GPU Programming’ from Johns Hopkins University and ‘Coding for Beginners: An Easy Introduction’ from IBM have exceptionally low rating of 2.7 and 2.9 respectively. In terms of student enrolment, ‘The Science of Well-Being’ from Yale University and ‘Learning how to Learn: Powerful mental tools to help you master tough subjects’ have exceptionally high number of students enrolled with over 4.5 million and 3.6 million students enrolled respectively.
- Courses with longer duration attract the highest number of students, with those taking 1 – 3 months (53.6%) and 3 – 6 months (21.4%) attracting a whopping combined 75% of all students. Courses with the least duration of time (Less than 2 hours) attract a meagre 0.11% of all students. In terms of certificate types, Courses attract the highest number of students at 78.9% of all students, while Specializations and Professional Certificates attract 14.8% and 6.2% of all students respectively. Guided Projects attract the least number of students, with only 0.11% of all students. In terms of course levels, Beginner courses attract the highest number of students at 68.2%, with mixed and intermediate courses attracting 18.0% and 12.5% of all students respectively. Only 1.2% of all students enroll for advanced level courses on Coursera.
- Google, Meta, and IBM offer the most in-demand professional certificates while guided projects from Coursera Project Network are the most in-demand.


### Recommendations 
- Organizations should publish more courses with longer durations (1 - 3 months and 3 - 6 months) and should focus more on beginner level courses.
- Organizations should publish more courses and specializations and less professional certificates and guided projects.


### Limitations 
- The dataset did not categorize courses according to fields (such as Data analytics, programming, cyber security, marketing, etc.). It would have been useful to establish the most popular courses in each of these fields. 




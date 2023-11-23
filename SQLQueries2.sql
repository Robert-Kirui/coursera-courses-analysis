SELECT TOP 5 * FROM coursera_courses;

/* Courses with exceptionally high or low ratings and student enrollment */
SELECT TOP 100 
	course_title,
	course_organization,
	course_rating
FROM coursera_courses
ORDER BY course_rating DESC;


SELECT TOP 100 
	course_title,
	course_organization,
	course_rating
FROM coursera_courses
ORDER BY course_rating;



SELECT TOP 10 
	course_title,
	course_organization,
	course_students_enrolled
FROM coursera_courses
ORDER BY course_students_enrolled DESC;


/* Variation in the number of students enrolled based on course duration, certificate type, and course level */
SELECT 
	course_duration, 
	SUM(course_students_enrolled) AS Number_of_Students,
	(SUM(course_students_enrolled)*100.0/ (SELECT SUM(course_students_enrolled) FROM coursera_courses)) AS Percentage_of_All_Students 
FROM coursera_courses
GROUP BY course_duration
ORDER BY Percentage_of_All_Students DESC;


SELECT 
	course_certificate_type, 
	SUM(course_students_enrolled) AS Number_of_Students,
	(SUM(course_students_enrolled)*100.0/ (SELECT SUM(course_students_enrolled) FROM coursera_courses)) AS Percentage_of_All_Students 
FROM coursera_courses
GROUP BY course_certificate_type
ORDER BY Percentage_of_All_Students DESC;



SELECT 
	course_level, 
	SUM(course_students_enrolled) AS Number_of_Students,
	(SUM(course_students_enrolled)*100.0/ (SELECT SUM(course_students_enrolled) FROM coursera_courses)) AS Percentage_of_All_Students 
FROM coursera_courses
GROUP BY course_level
ORDER BY Percentage_of_All_Students DESC;



/* Underperforming courses in terms of student enrolment and course rating */
SELECT 
	course_title, 
	course_organization,
	course_students_enrolled
FROM coursera_courses
ORDER BY course_students_enrolled;


SELECT 
	course_title, 
	course_organization,
	course_rating
FROM coursera_courses
ORDER BY course_rating;



/* Top 10 performing courses in each level - beginner, intermediate, advanced, and mixed */
SELECT TOP 10 
	course_title,
	course_organization, 
	course_level,
	course_students_enrolled
FROM coursera_courses
WHERE course_level = 'Beginner'
ORDER BY course_students_enrolled DESC;


SELECT TOP 10 
	course_title,
	course_organization, 
	course_level,
	course_students_enrolled
FROM coursera_courses
WHERE course_level = 'Intermediate'
ORDER BY course_students_enrolled DESC;



SELECT TOP 10 
	course_title,
	course_organization, 
	course_level,
	course_students_enrolled
FROM coursera_courses
WHERE course_level = 'Advanced'
ORDER BY course_students_enrolled DESC;


SELECT TOP 10 
	course_title,
	course_organization, 
	course_level,
	course_students_enrolled
FROM coursera_courses
WHERE course_level = 'Mixed'
ORDER BY course_students_enrolled DESC;


/* Top 10 performing courses in each certificate type (Course, Specialization, Professional Certificate, and Guided Project) */
SELECT TOP 10 
	course_title,
	course_organization, 
	course_certificate_type,
	course_students_enrolled
FROM coursera_courses
WHERE course_certificate_type = 'Course'
ORDER BY course_students_enrolled DESC;


SELECT TOP 10 
	course_title,
	course_organization, 
	course_certificate_type,
	course_students_enrolled
FROM coursera_courses
WHERE course_certificate_type = 'Specialization'
ORDER BY course_students_enrolled DESC;



SELECT TOP 10 
	course_title,
	course_organization, 
	course_certificate_type,
	course_students_enrolled
FROM coursera_courses
WHERE course_certificate_type = 'Professional Certificate'
ORDER BY course_students_enrolled DESC;



SELECT TOP 10 
	course_title,
	course_organization, 
	course_certificate_type,
	course_students_enrolled
FROM coursera_courses
WHERE course_certificate_type = 'Guided Project'
ORDER BY course_students_enrolled DESC;


/* Top 10 performing courses in both the number of students enrolled and course rating  */


/* Top 10 performing courses in both the number of students enrolled and number of reviews */


/* What is the relationship between the number of students enrolled and the number of reviews? Does courses with high number of
students enrolled necessaily have high number of reviews? */



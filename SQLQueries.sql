SELECT TOP 5 * FROM coursera_courses;

/* Trends or patterns in the duration of courses */
SELECT 
	course_duration, 
	COUNT(course_duration) AS Total_in_Number, 
	(COUNT(course_duration)*100.0/(SELECT COUNT(course_duration) FROM coursera_courses)) AS In_Percentage
FROM coursera_courses
GROUP BY course_duration
ORDER BY Total_in_Number DESC;


SELECT TOP 20 course_title, course_organization, course_certificate_type, course_duration, course_students_enrolled
FROM coursera_courses
ORDER BY course_students_enrolled DESC;



/* Which certificate types are most in-demand? */
SELECT
	course_certificate_type, 
	COUNT(course_certificate_type) AS Number_of_Courses, 
	(COUNT(course_certificate_type)*100.0/(SELECT COUNT(course_certificate_type) FROM coursera_courses)) AS In_Percentage
FROM coursera_courses
GROUP BY course_certificate_type
ORDER BY Number_of_Courses DESC;


SELECT TOP 20 course_title, course_organization, course_students_enrolled, course_certificate_type
FROM coursera_courses
ORDER BY course_students_enrolled DESC;



/*stand out organizations */
SELECT 
	course_organization, 
	COUNT(course_organization) AS Number_of_Courses,
	(COUNT(course_organization)*100.0/(SELECT COUNT(course_organization) FROM coursera_courses)) AS Percentage_of_all_Courses,
	SUM(course_students_enrolled) AS Number_of_Students, 
	(SUM(course_students_enrolled)*100.0/(SELECT SUM(course_students_enrolled) FROM coursera_courses)) AS Percentage_of_all_Students
FROM coursera_courses
GROUP BY course_organization
ORDER BY Number_of_Students DESC;



/* Distribution of Course Levels */
SELECT 
	course_level, 
	COUNT(course_level) AS Number_of_Courses,
	(COUNT(course_level)*100.0/ (SELECT COUNT(course_level) FROM coursera_courses)) AS Percentage_of_all_Courses
FROM coursera_courses
GROUP BY course_level
ORDER BY Number_of_Courses DESC;
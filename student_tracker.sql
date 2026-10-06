-- ============================================================
-- STUDENT PERFORMANCE & ATTENDANCE TRACKER
-- COMPLETE QUESTIONS + QUERIES
-- Includes: CREATE TABLE + INSERT DATA + Required Queries
-- ============================================================

-- ============================================================
-- DATABASE
-- ============================================================

CREATE DATABASE student_tracker;
USE student_tracker;


-- ============================================================
-- 1) TABLE: Students
-- ============================================================

-- Question: Create the Students table.

CREATE TABLE Students(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    gender VARCHAR(7),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(255),
    admission_date DATE NOT NULL,
    department_id INT,
    CONSTRAINT fk_student_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
);

-- Question: Insert data into Students.

INSERT INTO Students
(name, dob, gender, email, phone_number, address, admission_date, department_id)
VALUES
('Aarav Patel', '2003-05-12', 'Male', 'aarav@gmail.com', '9000000001', 'Ahmedabad', '2023-06-15', 1),
('Bhavya Shah', '2002-08-20', 'Female', 'bhavya@gmail.com', '9000000002', 'Bhavnagar', '2022-07-10', 1),
('Chirag Mehta', '2003-01-15', 'Male', 'chirag@gmail.com', '9000000003', 'Rajkot', '2024-01-05', 2),
('Diya Patel', '2002-11-25', 'Female', 'diya@gmail.com', '9000000004', 'Surat', '2023-08-20', 2),
('Eshan Joshi', '2003-03-18', 'Male', NULL, '9000000005', 'Vadodara', '2021-06-12', 3),
('Falguni Shah', '2002-09-09', 'Female', 'falguni@gmail.com', '9000000006', 'Ahmedabad', '2024-02-15', 3),
('Harsh Patel', '2003-07-21', 'Male', 'harsh@gmail.com', '9000000007', 'Rajkot', '2022-06-18', 1),
('Isha Mehta', '2002-12-30', 'Female', 'isha@gmail.com', '9000000008', 'Bhavnagar', '2023-07-12', 2),
('Jay Shah', '2003-04-14', 'Male', 'jay@gmail.com', '9000000009', 'Surat', '2021-07-20', 1),
('Krisha Patel', '2002-10-05', 'Female', 'krisha@gmail.com', '9000000010', 'Ahmedabad', '2024-06-10', 4);


-- ============================================================
-- 2) TABLE: Faculty
-- ============================================================

-- Question: Create the Faculty table.

CREATE TABLE Faculty(
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    experience_years INT DEFAULT 0,
    department_id INT,
    CONSTRAINT fk_faculty_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
);

-- Question: Insert data into Faculty.

INSERT INTO Faculty
(name, email, phone_number, experience_years, department_id)
VALUES
('Dr. Amit Shah', 'amit.shah@gmail.com', '9876500001', 10, 1),
('Prof. Neha Patel', 'neha.patel@gmail.com', '9876500002', 6, 1),
('Prof. Rahul Mehta', 'rahul.mehta@gmail.com', '9876500003', 3, 2),
('Prof. Priya Desai', 'priya.desai@gmail.com', '9876500004', 8, 2),
('Prof. Karan Joshi', 'karan.joshi@gmail.com', '9876500005', 2, 3);


-- ============================================================
-- 3) TABLE: Departments
-- ============================================================

-- Question: Create the Departments table.

CREATE TABLE Departments(
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Question: Insert data into Departments.

INSERT INTO Departments (department_name)
VALUES
('Computer Science'),
('Information Technology'),
('Commerce'),
('Management');


-- ============================================================
-- 4) TABLE: Courses
-- ============================================================

-- Question: Create the Courses table.

CREATE TABLE Courses(
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    faculty_id INT NULL,
    CONSTRAINT fk_course_faculty
        FOREIGN KEY (faculty_id)
        REFERENCES Faculty(faculty_id)
        ON DELETE SET NULL
);

-- Question: Insert data into Courses.

INSERT INTO Courses(course_name, faculty_id)
VALUES
('Database Management System', 1),
('Data Structures', 2),
('Web Development', 3),
('Python Programming', 4),
('Computer Networks', 1),
('Software Engineering', 2),
('Business Accounting', NULL);


-- ============================================================
-- 5) TABLE: Enrollments
-- ============================================================

-- Question: Create the Enrollments table.

CREATE TABLE Enrollments(
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_student_course
        UNIQUE (student_id, course_id)
);

-- Question: Insert data into Enrollments.

INSERT INTO Enrollments(student_id, course_id, enrollment_date)
VALUES
(1, 1, '2023-07-01'),
(1, 2, '2023-07-02'),
(1, 5, '2023-07-03'),
(2, 1, '2022-07-15'),
(2, 2, '2022-07-16'),
(2, 6, '2022-07-17'),
(3, 3, '2024-01-15'),
(3, 4, '2024-01-16'),
(3, 5, '2024-01-17'),
(4, 3, '2023-09-01'),
(4, 4, '2023-09-02'),
(4, 6, '2023-09-03'),
(5, 7, '2021-07-01'),
(5, 6, '2021-07-02'),
(6, 7, '2024-03-01'),
(6, 6, '2024-03-02'),
(7, 1, '2022-07-01'),
(7, 5, '2022-07-02'),
(7, 6, '2022-07-03'),
(8, 3, '2023-08-01'),
(8, 4, '2023-08-02'),
(8, 5, '2023-08-03'),
(9, 1, '2021-08-01'),
(9, 2, '2021-08-02'),
(9, 5, '2021-08-03');


-- ============================================================
-- 6) TABLE: Attendance
-- ============================================================

-- Question: Create the Attendance table.

CREATE TABLE Attendance(
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    CONSTRAINT fk_attendance_student
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_attendance_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_attendance
        UNIQUE (student_id, course_id, attendance_date)
);

-- Question: Insert data into Attendance.

INSERT INTO Attendance(student_id, course_id, attendance_date, status)
VALUES
-- Student 1 - Mostly Present
(1, 1, '2023-07-05', 'Present'),
(1, 1, '2023-08-05', 'Present'),
(1, 1, '2023-09-05', 'Present'),
(1, 1, '2023-10-05', 'Present'),
(1, 1, '2023-11-05', 'Present'),
(1, 1, '2023-12-05', 'Late'),
(1, 2, '2023-07-06', 'Present'),
(1, 2, '2023-08-06', 'Present'),
(1, 2, '2023-09-06', 'Present'),
(1, 2, '2023-10-06', 'Present'),
(1, 2, '2023-11-06', 'Present'),

-- Student 2 - Medium Attendance
(2, 1, '2022-08-05', 'Present'),
(2, 1, '2022-09-05', 'Absent'),
(2, 1, '2022-10-05', 'Present'),
(2, 1, '2022-11-05', 'Absent'),
(2, 1, '2022-12-05', 'Present'),
(2, 1, '2023-01-05', 'Late'),
(2, 2, '2022-08-06', 'Present'),
(2, 2, '2022-09-06', 'Absent'),
(2, 2, '2022-10-06', 'Present'),
(2, 2, '2022-11-06', 'Present'),

-- Student 3 - High Attendance
(3, 3, '2024-02-05', 'Present'),
(3, 3, '2024-03-05', 'Present'),
(3, 3, '2024-04-05', 'Present'),
(3, 3, '2024-05-05', 'Present'),
(3, 3, '2024-06-05', 'Late'),
(3, 4, '2024-02-06', 'Present'),
(3, 4, '2024-03-06', 'Present'),
(3, 4, '2024-04-06', 'Present'),
(3, 4, '2024-05-06', 'Present'),

-- Student 4 - Good Attendance
(4, 3, '2023-09-10', 'Present'),
(4, 3, '2023-10-10', 'Present'),
(4, 3, '2023-11-10', 'Absent'),
(4, 3, '2023-12-10', 'Present'),
(4, 3, '2024-01-10', 'Present'),
(4, 4, '2023-09-11', 'Present'),
(4, 4, '2023-10-11', 'Present'),
(4, 4, '2023-11-11', 'Present'),
(4, 4, '2023-12-11', 'Absent'),

-- Student 5 - Low Attendance
(5, 7, '2021-08-01', 'Absent'),
(5, 7, '2021-09-01', 'Absent'),
(5, 7, '2021-10-01', 'Present'),
(5, 7, '2021-11-01', 'Absent'),
(5, 7, '2021-12-01', 'Absent'),
(5, 7, '2022-01-01', 'Absent'),
(5, 7, '2022-02-01', 'Absent'),
(5, 7, '2022-03-01', 'Present'),
(5, 7, '2022-04-01', 'Absent'),
(5, 7, '2022-05-01', 'Absent'),
(5, 7, '2022-06-01', 'Absent'),
(5, 7, '2022-07-01', 'Absent'),
(5, 7, '2022-08-01', 'Absent'),
(5, 7, '2022-09-01', 'Present'),
(5, 7, '2022-10-01', 'Absent'),

-- Student 6 - Excellent Attendance
(6, 7, '2024-03-10', 'Present'),
(6, 7, '2024-04-10', 'Present'),
(6, 7, '2024-05-10', 'Present'),
(6, 7, '2024-06-10', 'Present'),
(6, 7, '2024-07-10', 'Present'),
(6, 6, '2024-03-11', 'Present'),
(6, 6, '2024-04-11', 'Present'),
(6, 6, '2024-05-11', 'Present'),
(6, 6, '2024-06-11', 'Present'),

-- Student 7 - Low Attendance
(7, 1, '2022-08-05', 'Absent'),
(7, 1, '2022-09-05', 'Absent'),
(7, 1, '2022-10-05', 'Absent'),
(7, 1, '2022-11-05', 'Present'),
(7, 1, '2022-12-05', 'Absent'),
(7, 1, '2023-01-05', 'Absent'),
(7, 5, '2022-08-06', 'Absent'),
(7, 5, '2022-09-06', 'Present'),
(7, 5, '2022-10-06', 'Absent'),
(7, 5, '2022-11-06', 'Absent'),

-- Student 8 - High Attendance
(8, 3, '2023-09-01', 'Present'),
(8, 3, '2023-10-01', 'Present'),
(8, 3, '2023-11-01', 'Present'),
(8, 3, '2023-12-01', 'Present'),
(8, 3, '2024-01-01', 'Late'),
(8, 4, '2023-09-02', 'Present'),
(8, 4, '2023-10-02', 'Present'),
(8, 4, '2023-11-02', 'Present'),
(8, 4, '2023-12-02', 'Present'),

-- Student 9 - Good Attendance
(9, 1, '2021-09-05', 'Present'),
(9, 1, '2021-10-05', 'Present'),
(9, 1, '2021-11-05', 'Present'),
(9, 1, '2021-12-05', 'Absent'),
(9, 1, '2022-01-05', 'Present'),
(9, 2, '2021-09-06', 'Present'),
(9, 2, '2021-10-06', 'Present'),
(9, 2, '2021-11-06', 'Present'),
(9, 2, '2021-12-06', 'Present');


-- ============================================================
-- 7) TABLE: Grades
-- ============================================================

-- Question: Create the Grades table.

CREATE TABLE Grades(
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL,
    grade VARCHAR(5),
    CONSTRAINT fk_grade_student
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_grade_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_student_course_grade
        UNIQUE (student_id, course_id)
);

-- Question: Insert data into Grades.

INSERT INTO Grades(student_id, course_id, marks_obtained, grade)
VALUES
(1, 1, 95, 'A+'),
(1, 2, 88, 'A'),
(1, 5, 92, 'A+'),
(2, 1, 78, 'B+'),
(2, 2, 69, 'C'),
(2, 6, 82, 'A'),
(3, 3, 91, 'A+'),
(3, 4, 85, 'A'),
(3, 5, 76, 'B+'),
(4, 3, 72, 'B'),
(4, 4, 94, 'A+'),
(4, 6, 88, 'A'),
(5, 7, 65, 'C'),
(5, 6, 58, 'D'),
(6, 7, 93, 'A+'),
(6, 6, 79, 'B+'),
(7, 1, 55, 'D'),
(7, 5, 61, 'C'),
(7, 6, 73, 'B'),
(8, 3, 89, 'A'),
(8, 4, 97, 'A+'),
(8, 5, 90, 'A'),
(9, 1, 84, 'A'),
(9, 2, 96, 'A+'),
(9, 5, 87, 'A');


-- ============================================================
-- QUERIES
-- ============================================================

-- 1) Add new student
INSERT INTO Students
(name, dob, gender, email, phone_number, address, admission_date, department_id)
VALUES
('Manav Patel', '2003-06-15', 'Male', 'manav@gmail.com',
 '9000000011', 'Ahmedabad', '2025-06-15', 1);

-- 2) Update student record
UPDATE Students
SET phone_number = '9111111111',
    address = 'Rajkot'
WHERE student_id = 11;

-- 3) Search Student
SELECT *
FROM Students
WHERE student_id = 11;

-- 4) Delete Student
DELETE FROM Students
WHERE student_id = 11;

-- 5) Where Clause
SELECT *
FROM Students
WHERE department_id = 1;

-- 6) Limit
SELECT student_id, marks_obtained
FROM Grades
ORDER BY marks_obtained DESC
LIMIT 10;

-- 7) Having
SELECT course_id, AVG(marks_obtained) AS average_marks
FROM Grades
GROUP BY course_id
HAVING AVG(marks_obtained) > 80;

-- 8) Attendance below 75%
SELECT
    student_id,
    COUNT(*) AS total_classes,
    SUM(status = 'Present') AS present_classes,
    ROUND(
        SUM(status = 'Present') * 100.0 / COUNT(*), 2
    ) AS attendance_percentage
FROM Attendance
GROUP BY student_id
HAVING attendance_percentage < 75;

-- 9) And Operator
SELECT
    s.student_id,
    s.name,
    g.marks_obtained
FROM Students s
JOIN Grades g
    ON s.student_id = g.student_id
WHERE g.marks_obtained < 60
AND s.student_id IN (
    SELECT student_id
    FROM Attendance
    GROUP BY student_id
    HAVING SUM(status = 'Present') * 100.0 / COUNT(*) < 50
);

-- 10) Or Operator
SELECT DISTINCT
    s.student_id,
    s.name
FROM Students s
LEFT JOIN Grades g
    ON s.student_id = g.student_id
WHERE g.marks_obtained > 90
OR s.student_id IN (
    SELECT student_id
    FROM Attendance
    GROUP BY student_id
    HAVING SUM(status = 'Present') * 100.0 / COUNT(*) = 100
);

-- 11) Not Operator
SELECT
    f.faculty_id,
    f.name
FROM Faculty f
WHERE NOT EXISTS (
    SELECT 1
    FROM Courses c
    WHERE c.faculty_id = f.faculty_id
);

-- 12) Order By
SELECT *
FROM Students
ORDER BY name ASC;

-- 13) Group By
SELECT
    department_id,
    COUNT(*) AS total_students
FROM Students
GROUP BY department_id;

-- 14) Group By + Avg
SELECT
    course_id,
    AVG(marks_obtained) AS average_marks
FROM Grades
GROUP BY course_id;


-- ============================================================
-- AGGREGATE FUNCTIONS + PK/FK RELATIONSHIPS
-- ============================================================

-- 1) AVG (Average Attendance Percentage)
SELECT
    ROUND(AVG(attendance_percentage), 2) AS average_attendance_percentage
FROM (
    SELECT
        student_id,
        SUM(status = 'Present') * 100.0 / COUNT(*) AS attendance_percentage
    FROM Attendance
    GROUP BY student_id
) AS attendance_summary;

-- 2) Max
SELECT
    course_id,
    MAX(marks_obtained) AS highest_marks
FROM Grades
GROUP BY course_id;

-- 3) Min
SELECT
    course_id,
    MIN(marks_obtained) AS lowest_marks
FROM Grades
GROUP BY course_id;

-- 4) Count
SELECT
    department_id,
    COUNT(*) AS total_students
FROM Students
GROUP BY department_id;

-- 5) Sum
SELECT
    course_id,
    SUM(marks_obtained) AS total_marks
FROM Grades
GROUP BY course_id;

-- 6) Verify the Primary Keys of all project tables.
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'student_tracker'
AND CONSTRAINT_NAME = 'PRIMARY';

-- 7) Verify all Foreign Key relationships in the database.
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'student_tracker'
AND REFERENCED_TABLE_NAME IS NOT NULL;

-- 8) Ensure that a student cannot enroll in the same course more than once.
SHOW CREATE TABLE Enrollments;


-- ============================================================
-- JOINS
-- ============================================================

-- 1) Retrieve student details along with their department using INNER JOIN.
SELECT
    s.student_id,
    s.name AS student_name,
    s.email,
    d.department_id,
    d.department_name
FROM Students s
INNER JOIN Departments d
    ON s.department_id = d.department_id;

-- 2) Get a list of students who have not enrolled in any course using LEFT JOIN.
SELECT
    s.student_id,
    s.name AS student_name
FROM Students s
LEFT JOIN Enrollments e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- 3) List courses that have no faculty assigned using RIGHT JOIN.
SELECT
    c.course_id,
    c.course_name,
    f.faculty_id,
    f.name AS faculty_name
FROM Faculty f
RIGHT JOIN Courses c
    ON f.faculty_id = c.faculty_id
WHERE f.faculty_id IS NULL;

-- 4) Show students without grades using FULL OUTER JOIN.
-- MySQL/MariaDB does not support FULL OUTER JOIN directly.
SELECT
    s.student_id,
    s.name AS student_name,
    g.grade_id,
    g.marks_obtained
FROM Students s
LEFT JOIN Grades g
    ON s.student_id = g.student_id
WHERE g.grade_id IS NULL
UNION
SELECT
    s.student_id,
    s.name AS student_name,
    g.grade_id,
    g.marks_obtained
FROM Students s
RIGHT JOIN Grades g
    ON s.student_id = g.student_id
WHERE s.student_id IS NULL;


-- ============================================================
-- SUBQUERIES
-- ============================================================

-- 1) Find students with marks above the average score.
SELECT
    s.student_id,
    s.name,
    g.marks_obtained
FROM Students s
INNER JOIN Grades g
    ON s.student_id = g.student_id
WHERE g.marks_obtained > (
    SELECT AVG(marks_obtained)
    FROM Grades
);

-- 2) Retrieve courses taught by faculty members with at least 5 years of experience.
SELECT
    course_id,
    course_name,
    faculty_id
FROM Courses
WHERE faculty_id IN (
    SELECT faculty_id
    FROM Faculty
    WHERE experience_years >= 5
);

-- 3) Identify students who have missed more than 10 classes.
SELECT
    s.student_id,
    s.name,
    COUNT(a.attendance_id) AS missed_classes
FROM Students s
INNER JOIN Attendance a
    ON s.student_id = a.student_id
WHERE a.status = 'Absent'
GROUP BY s.student_id, s.name
HAVING COUNT(a.attendance_id) > 10;


-- ============================================================
-- DATE & TIME FUNCTION
-- ============================================================

-- 1) Extract the month from attendance_date to analyze attendance trends.
SELECT
    attendance_id,
    student_id,
    course_id,
    attendance_date,
    MONTH(attendance_date) AS attendance_month
FROM Attendance;

-- 2) Calculate the number of years since a student's admission.
SELECT
    student_id,
    name,
    admission_date,
    TIMESTAMPDIFF(
        YEAR,
        admission_date,
        CURDATE()
    ) AS years_since_admission
FROM Students;

-- 3) Format attendance_date as DD-MM-YYYY.
SELECT
    attendance_id,
    attendance_date,
    DATE_FORMAT(attendance_date, '%d-%m-%Y') AS formatted_date
FROM Attendance;


-- ============================================================
-- STRING FUNCTION
-- ============================================================

-- 1) Convert all faculty names to uppercase.
SELECT
    faculty_id,
    UPPER(name) AS faculty_name
FROM Faculty;

-- 2) Trim unnecessary spaces from student names.
SELECT
    student_id,
    TRIM(name) AS cleaned_name
FROM Students;

-- 3) Replace NULL email fields with "Email Not Provided".
SELECT
    student_id,
    name,
    COALESCE(email, 'Email Not Provided') AS email
FROM Students;


-- ============================================================
-- WINDOW FUNCTION
-- ============================================================

-- 1) Rank students based on their overall marks.
SELECT
    student_id,
    student_name,
    overall_marks,
    RANK() OVER (
        ORDER BY overall_marks DESC
    ) AS student_rank
FROM (
    SELECT
        s.student_id,
        s.name AS student_name,
        AVG(g.marks_obtained) AS overall_marks
    FROM Students s
    INNER JOIN Grades g
        ON s.student_id = g.student_id
    GROUP BY s.student_id, s.name
) AS student_scores
ORDER BY student_rank;

-- 2) Show the cumulative attendance percentage per course.
SELECT
    attendance_id,
    course_id,
    attendance_date,
    status,
    SUM(status = 'Present') OVER (
        PARTITION BY course_id
        ORDER BY attendance_date, attendance_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_present,
    COUNT(*) OVER (
        PARTITION BY course_id
        ORDER BY attendance_date, attendance_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_classes,
    ROUND(
        SUM(status = 'Present') OVER (
            PARTITION BY course_id
            ORDER BY attendance_date, attendance_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) * 100.0
        /
        COUNT(*) OVER (
            PARTITION BY course_id
            ORDER BY attendance_date, attendance_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_attendance_percentage
FROM Attendance
ORDER BY course_id, attendance_date, attendance_id;

-- 3) Display the running total of students enrolled per month.
SELECT
    enrollment_month,
    monthly_enrollments,
    SUM(monthly_enrollments) OVER (
        ORDER BY enrollment_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM (
    SELECT
        DATE_FORMAT(enrollment_date, '%Y-%m') AS enrollment_month,
        COUNT(*) AS monthly_enrollments
    FROM Enrollments
    GROUP BY DATE_FORMAT(enrollment_date, '%Y-%m')
) AS monthly_data
ORDER BY enrollment_month;


-- ============================================================
-- CASE EXPRESSION
-- ============================================================

-- 1) Assign student performance levels:
-- Excellent -> marks > 90
-- Good -> 75-90
-- Needs Improvement -> otherwise

SELECT
    student_id,
    course_id,
    marks_obtained,
    CASE
        WHEN marks_obtained > 90 THEN 'Excellent'
        WHEN marks_obtained BETWEEN 75 AND 90 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS performance_level
FROM Grades;

-- 2) Categorize attendance records:
-- Regular -> attendance above 80%
-- Irregular -> 50%-80%
-- Defaulter -> otherwise

SELECT
    student_id,
    total_classes,
    present_classes,
    attendance_percentage,
    CASE
        WHEN attendance_percentage > 80 THEN 'Regular'
        WHEN attendance_percentage BETWEEN 50 AND 80 THEN 'Irregular'
        ELSE 'Defaulter'
    END AS attendance_category
FROM (
    SELECT
        student_id,
        COUNT(*) AS total_classes,
        SUM(status = 'Present') AS present_classes,
        ROUND(
            SUM(status = 'Present') * 100.0 / COUNT(*),
            2
        ) AS attendance_percentage
    FROM Attendance
    GROUP BY student_id
) AS attendance_summary;

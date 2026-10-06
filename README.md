# Student Performance & Attendance Tracker

A MySQL database project designed to manage and analyze student academic performance, course enrollment, faculty information, and attendance records.

---

## 📌 Project Overview

The **Student Performance & Attendance Tracker** stores student, faculty, department, course, enrollment, attendance, and grade information in a relational MySQL database.

The project demonstrates important SQL concepts including:

- Database and table creation
- Primary Keys and Foreign Keys
- CRUD operations
- `WHERE`, `HAVING`, and `LIMIT`
- `AND`, `OR`, and `NOT`
- `ORDER BY` and `GROUP BY`
- Aggregate functions
- `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`
- MySQL-compatible `FULL OUTER JOIN` emulation
- Subqueries
- Date and Time functions
- String functions
- Window functions
- `ROWS BETWEEN`
- Ranking and cumulative calculations
- `CASE` expressions

---

## 🗂️ Database Name

```sql
student_tracker
```

---

## 🧱 Database Structure

The project contains **7 tables**:

1. `Departments`
2. `Faculty`
3. `Students`
4. `Courses`
5. `Enrollments`
6. `Attendance`
7. `Grades`

### Relationship Overview

```text
Departments
    │
    ├── Students
    │
    └── Faculty
          │
          └── Courses
                 │
                 ├── Enrollments
                 ├── Attendance
                 └── Grades

Students
    ├── Enrollments
    ├── Attendance
    └── Grades
```

---

## 📋 Tables

### 1. Departments

Stores department information.

| Column | Description |
|---|---|
| `department_id` | Primary key |
| `department_name` | Department name |

---

### 2. Faculty

Stores faculty information.

| Column | Description |
|---|---|
| `faculty_id` | Primary key |
| `name` | Faculty name |
| `email` | Unique email |
| `phone_number` | Contact number |
| `experience_years` | Years of experience |
| `department_id` | Foreign key to Departments |

---

### 3. Students

Stores student personal and admission information.

| Column | Description |
|---|---|
| `student_id` | Primary key |
| `name` | Student name |
| `dob` | Date of birth |
| `gender` | Gender |
| `email` | Unique email |
| `phone_number` | Contact number |
| `address` | Address |
| `admission_date` | Admission date |
| `department_id` | Foreign key to Departments |

---

### 4. Courses

Stores course information and faculty assignment.

| Column | Description |
|---|---|
| `course_id` | Primary key |
| `course_name` | Course name |
| `faculty_id` | Foreign key to Faculty |

`faculty_id` can be `NULL` when a course has no faculty assigned.

---

### 5. Enrollments

Stores student course enrollment information.

| Column | Description |
|---|---|
| `enrollment_id` | Primary key |
| `student_id` | Foreign key to Students |
| `course_id` | Foreign key to Courses |
| `enrollment_date` | Enrollment date |

A unique constraint on `(student_id, course_id)` prevents the same student from enrolling in the same course more than once.

---

### 6. Attendance

Stores daily attendance information.

| Column | Description |
|---|---|
| `attendance_id` | Primary key |
| `student_id` | Foreign key to Students |
| `course_id` | Foreign key to Courses |
| `attendance_date` | Attendance date |
| `status` | Present / Absent / Late |

A unique constraint on `(student_id, course_id, attendance_date)` prevents duplicate attendance records for the same student, course, and date.

---

### 7. Grades

Stores student marks and grades for courses.

| Column | Description |
|---|---|
| `grade_id` | Primary key |
| `student_id` | Foreign key to Students |
| `course_id` | Foreign key to Courses |
| `marks_obtained` | Marks obtained |
| `grade` | Grade |

A unique constraint on `(student_id, course_id)` prevents duplicate grade records for the same student and course.

---

## 🔗 Key Relationships

- `Students.department_id` → `Departments.department_id`
- `Faculty.department_id` → `Departments.department_id`
- `Courses.faculty_id` → `Faculty.faculty_id`
- `Enrollments.student_id` → `Students.student_id`
- `Enrollments.course_id` → `Courses.course_id`
- `Attendance.student_id` → `Students.student_id`
- `Attendance.course_id` → `Courses.course_id`
- `Grades.student_id` → `Students.student_id`
- `Grades.course_id` → `Courses.course_id`

---

## 📊 Sample Data

The project contains sample records for:

| Table | Records |
|---|---:|
| Departments | 4 |
| Faculty | 5 |
| Students | 10 |
| Courses | 7 |
| Enrollments | 25 |
| Attendance | 91 |
| Grades | 25 |

---

## 🧪 SQL Concepts Demonstrated

### CRUD Operations

The project demonstrates:

- `INSERT`
- `SELECT`
- `UPDATE`
- `DELETE`

Example:

```sql
SELECT *
FROM Students
WHERE student_id = 11;
```

---

### Filtering and Conditions

The project includes:

- `WHERE`
- `HAVING`
- `LIMIT`
- `AND`
- `OR`
- `NOT`

---

### Sorting and Grouping

The project demonstrates:

```sql
ORDER BY
GROUP BY
```

and grouping with aggregate functions such as `AVG()` and `COUNT()`.

---

### Aggregate Functions

The following aggregate functions are used:

```text
AVG()
MAX()
MIN()
COUNT()
SUM()
```

Examples include calculating average attendance, highest marks, lowest marks, number of students, and total marks.

---

## 🔄 Joins

The project demonstrates:

### INNER JOIN

Used to retrieve matching records from related tables.

### LEFT JOIN

Used to find students who have not enrolled in any course.

### RIGHT JOIN

Used to identify courses that do not have a faculty assigned.

### FULL OUTER JOIN

MySQL/MariaDB does not directly support `FULL OUTER JOIN`, so the project demonstrates it using a combination of:

```text
LEFT JOIN
UNION
RIGHT JOIN
```

---

## 🔍 Subqueries

The project includes subqueries for:

1. Finding students whose marks are above the average score.
2. Finding courses taught by faculty members with at least 5 years of experience.
3. Identifying students who have missed more than 10 classes.

---

## 📅 Date & Time Functions

The project demonstrates:

```text
MONTH()
TIMESTAMPDIFF()
CURDATE()
DATE_FORMAT()
```

Examples include:

- Extracting the month from attendance dates.
- Calculating years since admission.
- Formatting dates as `DD-MM-YYYY`.

---

## 🔤 String Functions

The project demonstrates:

```text
UPPER()
TRIM()
COALESCE()
```

Examples include:

- Converting faculty names to uppercase.
- Removing unnecessary spaces from names.
- Replacing `NULL` email values with `"Email Not Provided"`.

---

## 🪟 Window Functions

Window functions are an important part of this project.

The project demonstrates:

### RANK()

Ranks students according to their overall marks.

### PARTITION BY

Used to perform calculations separately for each course.

### ORDER BY inside Window Functions

Controls the order in which window calculations are performed.

### ROWS BETWEEN

The project uses:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

for cumulative calculations.

### Cumulative Attendance

The project calculates cumulative present classes, cumulative classes, and cumulative attendance percentage per course.

### Running Total

The project calculates the running total of students enrolled per month.

---

## 🧠 CASE Expressions

The project uses `CASE` expressions to classify:

### Student Performance

```text
Marks > 90       → Excellent
75–90            → Good
Otherwise        → Needs Improvement
```

### Attendance Category

```text
Above 80%        → Regular
50%–80%          → Irregular
Otherwise        → Defaulter
```

---

## ▶️ How to Run the Project

### Step 1: Start MySQL / XAMPP

Start the MySQL service from XAMPP or your MySQL environment.

### Step 2: Open MySQL / phpMyAdmin

Open your preferred MySQL interface.

### Step 3: Run the SQL File

Import or execute:

```text
student_tracker_complete.sql
```

The SQL file contains:

1. Database creation
2. Table creation
3. Sample data insertion
4. Required SQL queries

### Step 4: Select the Database

```sql
USE student_tracker;
```

### Step 5: Execute the Required Queries

The query section can then be executed individually for practice, testing, and demonstration.

---

## 📁 Project Files

```text
Student-Performance-Attendance-Tracker/
│
├── student_tracker_complete.sql
└── README.md
```

---

## 🛠️ Technologies Used

- **Database:** MySQL / MariaDB
- **Query Language:** SQL
- **Environment:** XAMPP / phpMyAdmin
- **Version Control:** Git & GitHub

---

## 🎯 Project Objective

The main objective of this project is to build a relational database that can manage student academic information and demonstrate practical SQL skills through real-world queries.

The project focuses especially on:

- Relational database design
- Data integrity
- Table relationships
- Data analysis
- Advanced SQL queries
- Window functions
- Attendance analysis
- Student performance analysis

---

## 👨‍💻 Author

**Student Performance & Attendance Tracker**

SQL Database Project

# 📊 SQL Assignment – Nairobi Academy Database

## 📌 Overview
This project involves designing and querying a relational database for a secondary school (Nairobi Academy).  
It demonstrates SQL fundamentals including schema design, data manipulation, filtering, and transformation.

---

## 🗂️ Project Structure

SQL-projects/
   └── assignment/
         ├── kevin_osioma_sql_assignment.sql
         ├── article.md
         ├── README.md
         └── images/

---

## 🧱 Database Design

### Schema
- nairobi_academy

### Tables
- students
- subjects
- exam_results

### Relationships
- exam_results.student_id → students.student_id
- exam_results.subject_id → subjects.subject_id

---

## 📸 Database Schema (ER Diagram)

![Schema](images/schema.png)

---

## 🗃️ Tables in DBeaver

![Tables](images/tables.png)

---

## ⚙️ SQL Concepts Covered

### DDL (Data Definition Language)
Used to define structure:
- CREATE
- ALTER
- DROP

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

---

### DML (Data Manipulation Language)
Used to manage data:
- INSERT
- UPDATE
- DELETE

```sql
INSERT INTO students VALUES (1, 'Amina', 'Wanjiku');
```

---

## 🔍 Data Filtering with WHERE

Examples:

```sql
WHERE gender = 'F';
WHERE marks > 70;
WHERE marks BETWEEN 50 AND 80;
WHERE city IN ('Nairobi', 'Mombasa');
WHERE first_name LIKE 'A%';
```

---

## 📸 Query Results Example

![Query Results](images/query_results.png)

---

## 🔄 Data Transformation (CASE WHEN)

```sql
SELECT marks,
CASE
    WHEN marks >= 80 THEN 'Distinction'
    WHEN marks >= 60 THEN 'Merit'
    WHEN marks >= 40 THEN 'Pass'
    ELSE 'Fail'
END AS performance
FROM exam_results;
```

---

## 📸 CASE WHEN Output

![CASE WHEN](images/case_when.png)

---

## 📊 Key Queries Implemented

- Student filtering (class, gender, city)
- Range queries (BETWEEN)
- Pattern matching (LIKE)
- Aggregation using COUNT
- Data transformation using CASE WHEN

---

## 🧠 Reflection

This assignment improved my ability to:

- Design relational databases
- Write structured SQL queries
- Apply filtering logic using multiple conditions
- Transform raw data into meaningful insights

### Challenges
- Combining multiple conditions (AND, OR)
- Managing schema context (search_path)
- Maintaining referential integrity

### Key Learning
CASE WHEN is powerful for transforming raw data into meaningful categories for reporting.

---

## 🚀 How to Run

1. Open DBeaver
2. Run:
   kevin_osioma_sql_assignment.sql

3. Set schema:
   SET search_path TO nairobi_academy;

---

## 📸 DBeaver Environment

![DBeaver](images/dbeaver_view.png)

---

## 🔗 Submission

Push to GitHub and share the repository link.

---

## 📬 Contact

dataanalysis@luxdevhq.com

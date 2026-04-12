# 📊 SQL Assignment – Nairobi Academy Database

## 📌 Overview
This project involves designing and querying a relational database for a secondary school (Nairobi Academy).  
It demonstrates SQL fundamentals, including schema design, data manipulation, filtering, and transformation.

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

![Schema]<img width="601" height="688" alt="image" src="https://github.com/user-attachments/assets/f94c444c-f72e-477f-a18e-cfee6943fb78" />

---

## 🗃️ Tables in DBeaver

![Tables](<img width="1284" height="766" alt="image" src="https://github.com/user-attachments/assets/425bc0ec-9733-4828-96e1-542f1c52c6f2" />)

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

![Query Results](<img width="1194" height="483" alt="image" src="https://github.com/user-attachments/assets/39b22ccc-063f-4923-a801-04829e912e47" />)
![Query Results](<img width="1101" height="486" alt="image" src="https://github.com/user-attachments/assets/56124214-bc75-4ead-95df-6d46b2effec6" />)
![Query Results](<img width="1070" height="479" alt="image" src="https://github.com/user-attachments/assets/d1445413-8fa5-4c86-86a1-5cf2b901754b" />)

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

![CASE WHEN](<img width="1122" height="781" alt="image" src="https://github.com/user-attachments/assets/d50ee563-e1be-4e49-a8ce-807bd12caad7" />)

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

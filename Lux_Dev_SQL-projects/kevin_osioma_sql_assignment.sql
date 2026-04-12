/* =========================================================
   INTRODUCTION TO SQL ASSIGNMENT
   Schema: nairobi_academy
   ========================================================= */


/* =========================
   SECTION A: DDL
   ========================= */

/* Q1. Create schema and use it */
CREATE SCHEMA nairobi_academy;

SET search_path TO nairobi_academy;

/* Q2. Create students table */
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(1),
    date_of_birth DATE,
    class VARCHAR(10),
    city VARCHAR(50)
);

select * from students;

/* Q3. Create subjects table */
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50),
    teacher_name VARCHAR(100),
    credits INT
);

select * from subjects;

/* Q4. Create exam_results table */
CREATE TABLE exam_results (
    result_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    marks INT NOT NULL,
    exam_date DATE,
    grade VARCHAR(2),
    CONSTRAINT fk_exam_student
        FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_exam_subject
        FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

select * from exam_results;


/* Q5. Add phone_number column */
ALTER TABLE students
ADD COLUMN phone_number VARCHAR(20);

select * from students;

/* Q6. Rename credits to credit_hours */
ALTER TABLE subjects
RENAME COLUMN credits TO credit_hours;

select * from subjects;

/* Q7. Remove phone_number column */
ALTER TABLE students
DROP COLUMN phone_number;

select * from students;


/* =========================
   SECTION B: DML
   ========================= */

/* Q8. Insert 10 students */
INSERT INTO students (student_id, first_name, last_name, gender, date_of_birth, class, city)
VALUES
    (1, 'Amina', 'Wanjiku', 'F', '2008-03-12', 'Form 3', 'Nairobi'),
    (2, 'Brian', 'Ochieng', 'M', '2007-07-25', 'Form 4', 'Mombasa'),
    (3, 'Cynthia', 'Mutua', 'F', '2008-11-05', 'Form 3', 'Kisumu'),
    (4, 'David', 'Kamau', 'M', '2007-02-18', 'Form 4', 'Nairobi'),
    (5, 'Esther', 'Akinyi', 'F', '2009-06-30', 'Form 2', 'Nakuru'),
    (6, 'Felix', 'Otieno', 'M', '2009-09-14', 'Form 2', 'Eldoret'),
    (7, 'Grace', 'Mwangi', 'F', '2008-01-22', 'Form 3', 'Nairobi'),
    (8, 'Hassan', 'Abdi', 'M', '2007-04-09', 'Form 4', 'Mombasa'),
    (9, 'Ivy', 'Chebet', 'F', '2009-12-01', 'Form 2', 'Nakuru'),
    (10, 'James', 'Kariuki', 'M', '2008-08-17', 'Form 3', 'Nairobi');

select * from students;

/* Q9. Insert 10 subjects */
INSERT INTO subjects (subject_id, subject_name, department, teacher_name, credit_hours)
VALUES
    (1, 'Mathematics', 'Sciences', 'Mr. Njoroge', 4),
    (2, 'English', 'Languages', 'Ms. Adhiambo', 3),
    (3, 'Biology', 'Sciences', 'Ms. Otieno', 4),
    (4, 'History', 'Humanities', 'Mr. Waweru', 3),
    (5, 'Kiswahili', 'Languages', 'Ms. Nduta', 3),
    (6, 'Physics', 'Sciences', 'Mr. Kamande', 4),
    (7, 'Geography', 'Humanities', 'Ms. Chebet', 3),
    (8, 'Chemistry', 'Sciences', 'Ms. Muthoni', 4),
    (9, 'Computer Studies', 'Sciences', 'Mr. Oduya', 3),
    (10, 'Business Studies', 'Humanities', 'Ms. Wangari', 3);

select * from subjects;

/* Q10. Insert 10 exam results */
INSERT INTO exam_results (result_id, student_id, subject_id, marks, exam_date, grade)
VALUES
    (1, 1, 1, 78, '2024-03-15', 'B'),
    (2, 1, 2, 85, '2024-03-16', 'A'),
    (3, 2, 1, 92, '2024-03-15', 'A'),
    (4, 2, 3, 55, '2024-03-17', 'C'),
    (5, 3, 2, 49, '2024-03-16', 'D'),
    (6, 3, 4, 71, '2024-03-18', 'B'),
    (7, 4, 1, 88, '2024-03-15', 'A'),
    (8, 4, 6, 63, '2024-03-19', 'C'),
    (9, 5, 5, 39, '2024-03-20', 'F'),
    (10, 6, 9, 95, '2024-03-21', 'A');

select * from exam_results;

/* Q11. Confirm all 10 rows exist */
SELECT COUNT(*) AS total_students
FROM students;

SELECT COUNT(*) AS total_subjects
FROM subjects;

SELECT COUNT(*) AS total_exam_results
FROM exam_results;

/* Q12. Update Esther's city from Nakuru to Nairobi */
UPDATE students
SET city = 'Nairobi'
WHERE student_id = 5;

select * from students;

/* Q13. Correct marks for result_id 5 from 49 to 59 */
UPDATE exam_results
SET marks = 59
WHERE result_id = 5;

select * from exam_results;

/* Q14. Delete exam result with result_id 9 */
DELETE FROM exam_results
WHERE result_id = 9;

select * from exam_results;

/* =========================
   SECTION C: WHERE FILTERS
   ========================= */

/* Q15. Students in Form 4 */
SELECT *
FROM students
WHERE class = 'Form 4';


/* Q16. Subjects in Sciences department */
SELECT *
FROM subjects
WHERE department = 'Sciences';

/* Q17. Exam results with marks >= 70 */
SELECT *
FROM exam_results
WHERE marks >= 70;

/* Q18. Female students only */
SELECT *
FROM students
WHERE gender = 'F';

/* Q19. Students in Form 3 AND from Nairobi */
SELECT *
FROM students
WHERE class = 'Form 3'
  AND city = 'Nairobi';

/* Q20. Students in Form 2 OR Form 4 */
SELECT *
FROM students
WHERE class = 'Form 2'
   OR class = 'Form 4';

/* =========================================================
   PART 2
   BETWEEN, IN/NOT IN, LIKE, COUNT, CASE WHEN
   ========================================================= */

/* =========================
   SECTION A: RANGE / IN / LIKE
   ========================= */

/* Q1. Exam results where marks are between 50 and 80 */

SELECT *
FROM exam_results
WHERE marks BETWEEN 50 AND 80;

/* Q2. Exams between 15th March 2024 and 18th March 2024 */
SELECT *
FROM exam_results
WHERE exam_date BETWEEN '2024-03-15' AND '2024-03-18';

/* Q3. Students who live in Nairobi, Mombasa, or Kisumu */
SELECT *
FROM students
WHERE city IN ('Nairobi', 'Mombasa', 'Kisumu');

/* Q4. Students NOT in Form 2 or Form 3 */
SELECT *
FROM students
WHERE class NOT IN ('Form 2', 'Form 3');

/* Q5. Students whose first name starts with A or E */
SELECT *
FROM students
WHERE first_name LIKE 'A%'
   OR first_name LIKE 'E%';

/* Q6. Subjects whose name contains the word Studies */
SELECT *
FROM subjects
WHERE subject_name LIKE '%Studies%';

/* =========================
   SECTION B: COUNT
   ========================= */

/* Q7. Number of students in Form 3 */
SELECT COUNT(*) AS form_3_students
FROM students
WHERE class = 'Form 3';

/* Q8. Number of exam results with marks >= 70 */
SELECT COUNT(*) AS results_70_and_above
FROM exam_results
WHERE marks >= 70;

/* =========================
   SECTION C: CASE WHEN
   ========================= */

/* Q9. Label each exam result with performance */
SELECT
    result_id,
    student_id,
    subject_id,
    marks,
    exam_date,
    grade,
    CASE
        WHEN marks >= 80 THEN 'Distinction'
        WHEN marks >= 60 THEN 'Merit'
        WHEN marks >= 40 THEN 'Pass'
        ELSE 'Fail'
    END AS performance
FROM exam_results;


/* Q10. Label each student as Senior or Junior */
SELECT
    first_name,
    last_name,
    class,
    CASE
        WHEN class IN ('Form 3', 'Form 4') THEN 'Senior'
        WHEN class IN ('Form 1', 'Form 2') THEN 'Junior'
        ELSE 'Unknown'
    END AS student_level
FROM students;







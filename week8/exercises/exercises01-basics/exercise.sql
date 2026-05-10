.headers on
.mode column
.separator "  "

-- 1.1: Retrieve first_name and last_name of every student

SELECT first_name, last_name
FROM students;

-- 1.2: Get the email of every student, ordered alphabetically

SELECT email
FROM students
ORDER BY email ASC;

-- 1.3: Find all students with a GPA greater than 3.5 (show name and GPA)

SELECT first_name, last_name, gpa
FROM students
WHERE gpa > 3.5;

-- 1.4: Find all students who enrolled in 2021

SELECT *
FROM students
WHERE enrollment_year = 2021;

-- 1.5: Find students with GPA between 3.0 and 3.5 (inclusive)

SELECT first_name, last_name, gpa
FROM students
WHERE gpa BETWEEN 3.0 AND 3.5;

-- 1.6: Find the student with email 'grace@school.edu'

SELECT *
FROM students
WHERE email = 'grace@school.edu';

-- 1.7: Retrieve only the first 5 students (by id)

SELECT *
FROM students
ORDER BY id
LIMIT 5;

-- 1.8: Find students whose gpa is NULL

SELECT *
FROM students
WHERE gpa IS NULL;

-- 1.9: Find teachers with salary greater than 80000 (show name and salary)

SELECT first_name, last_name, salary
FROM teachers
WHERE salary > 80000;

-- 1.10: Find all 4-credit courses (show code and title)

SELECT code, title
FROM courses
WHERE credits = 4;

-- 2.1: Students whose last name contains 's' (school.db)

SELECT *
FROM students
WHERE last_name LIKE '%s%';

-- 2.2: Teachers with email ending in @cs50.harvard.edu (school.db)

SELECT *
FROM teachers
WHERE email LIKE '%@cs50.harvard.edu';

-- 2.3: Top 5 students by GPA, highest first (school.db)

SELECT first_name, last_name, gpa
FROM students
ORDER BY gpa DESC
LIMIT 5;

-- 2.4: Distinct enrollment years (school.db)

SELECT DISTINCT enrollment_year
FROM students
ORDER BY enrollment_year;

-- 2.5: Courses in department 1 OR 2, using IN (school.db)

SELECT *
FROM courses
WHERE department_id IN (1, 2);

-- 2.6: Students who did NOT enroll in 2018, using NOT IN (school.db)

SELECT *
FROM students
WHERE enrollment_year NOT IN (2018);

-- 2.7: Courses sorted by credits (desc), then title (asc) (school.db)

SELECT *
FROM courses
ORDER BY credits DESC, title ASC;

-- 2.8: Books whose title starts with 'The' (library.db)

SELECT *
FROM books
WHERE title LIKE 'The%';

-- 2.9: Loans where return_date is NULL (library.db)

SELECT id, member_id, due_date
FROM loans
WHERE return_date IS NULL;

-- 2.10: British authors sorted by last name (library.db)

SELECT *
FROM authors
WHERE nationality = 'British'
ORDER BY last_name ASC;

-- 2.11: Members with membership_type 'premium' or 'student' (library.db)

SELECT *
FROM members
WHERE membership_type IN ('premium', 'student');

-- 2.12 CHALLENGE: Students with exactly 4-letter first names (school.db)

SELECT *
FROM students
WHERE first_name LIKE '____';

-- 3.1 Student + Course
-- =========================
SELECT s.first_name || ' ' || s.last_name AS student_name,
       c.title AS course_title
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id;

-- =========================
-- 3.2 Course + Teacher
-- =========================
SELECT c.title AS course_title,
       t.first_name || ' ' || t.last_name AS teacher_name
FROM courses c
JOIN teachers t ON c.teacher_id = t.id;

-- =========================
-- 3.3 Teacher + Department
-- =========================
SELECT t.first_name || ' ' || t.last_name AS teacher_name,
       d.name AS department_name
FROM teachers t
JOIN departments d ON t.department_id = d.id;

-- =========================
-- 3.4 Student + Course + Teacher + Grade
-- =========================
SELECT s.first_name || ' ' || s.last_name AS student_name,
       c.title AS course_title,
       t.first_name || ' ' || t.last_name AS teacher_name,
       e.grade AS letter_grade
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
JOIN teachers t ON c.teacher_id = t.id;

-- =========================
-- 3.5 Students with NO enrollments
-- =========================
SELECT s.first_name || ' ' || s.last_name AS student_name
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
WHERE e.student_id IS NULL;

-- =========================
-- 3.6 Courses with NO students
-- =========================
SELECT c.title AS course_title
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
WHERE e.course_id IS NULL;

-- =========================
-- 3.7 Book + Author
-- =========================
SELECT b.title AS book_title,
       a.first_name || ' ' || a.last_name AS author_name
FROM books b
JOIN authors a ON b.author_id = a.id;

-- =========================
-- 3.8 Genre + Books (include empty)
-- =========================
SELECT g.name AS genre_name,
       b.title AS book_title
FROM genres g
LEFT JOIN books b ON g.id = b.genre_id;

-- =========================
-- 3.9 Member + Borrowed Books (include non-borrowers)
-- =========================
SELECT m.first_name || ' ' || m.last_name AS member_name,
       b.title AS book_title
FROM members m
LEFT JOIN loans l ON m.id = l.member_id
LEFT JOIN books b ON l.book_id = b.id;

-- =========================
-- 3.10 Loans + COALESCE
-- =========================
SELECT m.first_name || ' ' || m.last_name AS member_name,
       b.title AS book_title,
       l.loan_date,
       COALESCE(l.return_date, 'Not returned') AS return_status
FROM loans l
JOIN members m ON l.member_id = m.id
JOIN books b ON l.book_id = b.id;

-- 4.1 Total number of students
-- =========================
SELECT COUNT(*) AS total_students
FROM students;

-- =========================
-- 4.2 Students per enrollment year
-- =========================
SELECT enrollment_year,
       COUNT(*) AS student_count
FROM students
GROUP BY enrollment_year;

-- =========================
-- 4.3 Average GPA (2 decimals)
-- =========================
SELECT ROUND(AVG(gpa), 2) AS avg_gpa
FROM students;

-- =========================
-- 4.4 GPA stats (max, min, avg)
-- =========================
SELECT
    MAX(gpa) AS max_gpa,
    MIN(gpa) AS min_gpa,
    ROUND(AVG(gpa), 2) AS avg_gpa
FROM students;

-- =========================
-- 4.5 Courses per department
-- =========================
SELECT department_id,
       COUNT(*) AS course_count
FROM courses
GROUP BY department_id;

-- =========================
-- 4.6 Students per course (desc)
-- =========================
SELECT c.title AS course_title,
       COUNT(e.student_id) AS student_count
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id
ORDER BY student_count DESC;

-- =========================
-- 4.7 Courses with > 3 students
-- =========================
SELECT c.title AS course_title,
       COUNT(e.student_id) AS student_count
FROM courses c
JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id
HAVING COUNT(e.student_id) > 3;

-- =========================
-- 4.8 Avg final exam score per course
-- =========================
SELECT c.title AS course_title,
       ROUND(AVG(e.final_exam_score), 1) AS avg_score
FROM courses c
JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id;

-- =========================
-- 4.9 Department stats (teacher count, avg & max salary)
-- =========================
SELECT d.name AS department_name,
       COUNT(t.id) AS teacher_count,
       ROUND(AVG(t.salary), 2) AS avg_salary,
       MAX(t.salary) AS max_salary
FROM departments d
LEFT JOIN teachers t ON d.id = t.department_id
GROUP BY d.id;

-- =========================
-- 4.10 Library: fines > 0
-- =========================
SELECT SUM(fine) AS total_fines,
       ROUND(AVG(fine), 2) AS avg_fine
FROM loans
WHERE fine > 0;

-- =========================
-- 4.11 Books per genre
-- =========================
SELECT genre_id,
       COUNT(*) AS book_count
FROM books
GROUP BY genre_id;

-- =========================
-- 4.12 Departments avg salary > 75000
-- =========================
SELECT d.name AS department_name,
       ROUND(AVG(t.salary), 2) AS avg_salary
FROM departments d
JOIN teachers t ON d.id = t.department_id
GROUP BY d.id
HAVING AVG(t.salary) > 75000;

-- 5.1 Above average GPA
-- =========================
SELECT first_name, last_name, gpa
FROM students
WHERE gpa > (SELECT AVG(gpa) FROM students);

-- =========================
-- 5.2 Students in CS50
-- =========================
SELECT first_name, last_name
FROM students
WHERE id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = (
        SELECT id FROM courses WHERE code = 'CS50'
    )
);

-- =========================
-- 5.3 Students NOT in CS50
-- =========================
SELECT first_name, last_name
FROM students
WHERE id NOT IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = (
        SELECT id FROM courses WHERE code = 'CS50'
    )
);

-- =========================
-- 5.4 Courses by highest-paid teacher
-- =========================
SELECT title AS course_title
FROM courses
WHERE teacher_id = (
    SELECT id
    FROM teachers
    WHERE salary = (SELECT MAX(salary) FROM teachers)
);

-- =========================
-- 5.5 Students with 3+ courses
-- =========================
SELECT s.first_name, s.last_name
FROM students s
JOIN (
    SELECT student_id
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(course_id) >= 3
) ec ON s.id = ec.student_id;

-- =========================
-- 5.6 Members with >2 borrowed books
-- =========================
SELECT m.first_name, m.last_name
FROM members m
JOIN (
    SELECT member_id
    FROM loans
    GROUP BY member_id
    HAVING COUNT(book_id) > 2
) l ON m.id = l.member_id;

-- =========================
-- 5.7 Books above average page count
-- =========================
SELECT title, pages
FROM books
WHERE pages > (SELECT AVG(pages) FROM books);

-- =========================
-- 5.8 Students with at least one grade (EXISTS)
-- =========================
SELECT first_name, last_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
    AND e.grade IS NOT NULL
);

-- =========================
-- 5.9 Courses with no grades (NOT EXISTS)
-- =========================
SELECT title
FROM courses c
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.course_id = c.id
    AND e.grade IS NOT NULL
);

-- =========================
-- 5.10 Course(s) with most enrollments
-- =========================
SELECT title
FROM courses
WHERE id IN (
    SELECT course_id
    FROM enrollments
    GROUP BY course_id
    HAVING COUNT(student_id) = (
        SELECT MAX(cnt)
        FROM (
            SELECT COUNT(student_id) AS cnt
            FROM enrollments
            GROUP BY course_id
        )
    )
);

-- 6.1 Social Media Schema
-- ============================================================

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at TEXT
);

CREATE TABLE posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    created_at TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE follows (
    follower_id INTEGER,
    following_id INTEGER,
    created_at TEXT,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (following_id) REFERENCES users(id)
);

CREATE TABLE likes (
    user_id INTEGER,
    post_id INTEGER,
    created_at TEXT,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

CREATE TABLE comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    post_id INTEGER,
    content TEXT,
    created_at TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- ============================================================
-- 6.2 Movie Rental Schema
-- ============================================================

CREATE TABLE genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    genre_id INTEGER,
    release_year INTEGER,
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE copies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id INTEGER,
    available INTEGER DEFAULT 1,
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE
);

CREATE TABLE rentals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    copy_id INTEGER,
    rent_date TEXT,
    return_date TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (copy_id) REFERENCES copies(id)
);

CREATE TABLE reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    movie_id INTEGER,
    rating INTEGER,
    comment TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

-- ============================================================
-- 6.3 E-Commerce Schema
-- ============================================================

CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    price REAL NOT NULL,
    stock INTEGER,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE customers_ecom (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    order_date TEXT,
    total REAL,
    FOREIGN KEY (customer_id) REFERENCES customers_ecom(id)
);

CREATE TABLE order_items (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price REAL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- ============================================================
-- 6.4 FIXED BAD SCHEMA
-- ============================================================

CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    gpa REAL
);

CREATE TABLE teachers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    salary REAL
);

CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    teacher_id INTEGER,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE enrollments (
    student_id INTEGER,
    course_id INTEGER,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- ============================================================
-- 6.5 SEED DATA (Social Media)
-- ============================================================

INSERT INTO users (username, email) VALUES
('alice', 'alice@mail.com'),
('bob', 'bob@mail.com'),
('carol', 'carol@mail.com');

INSERT INTO posts (user_id, content) VALUES
(1, 'Hello world'),
(1, 'My second post'),
(2, 'Bob here!');

INSERT INTO follows VALUES
(1,2),
(1,3),
(2,3);

INSERT INTO likes VALUES
(2,1),
(3,1),
(3,2);

INSERT INTO comments (user_id, post_id, content) VALUES
(2,1,'Nice post!'),
(3,1,'Cool!'),
(1,3,'Welcome!');

-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================

-- Q1: Who does user 1 follow?
SELECT u.username
FROM follows f
JOIN users u ON f.following_id = u.id
WHERE f.follower_id = 1;

-- Q2: Most liked posts
SELECT post_id, COUNT(*) AS like_count
FROM likes
GROUP BY post_id
ORDER BY like_count DESC;

-- Q3: User who posted most
SELECT u.username, COUNT(p.id) AS post_count
FROM users u
JOIN posts p ON u.id = p.user_id
GROUP BY u.id
ORDER BY post_count DESC;

-- 7.1 Index on students.gpa + EXPLAIN QUERY PLAN
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_students_gpa ON students(gpa);

EXPLAIN QUERY PLAN
SELECT *
FROM students
WHERE gpa > 3.5;

-- ============================================================
-- 7.2 View: enrollment_details (A grades only query later)
-- ============================================================

CREATE VIEW enrollment_details AS
SELECT
    s.first_name || ' ' || s.last_name AS student_name,
    c.title AS course_title,
    g.midterm,
    g.final,
    g.assignments,
    g.letter_grade
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
JOIN grades g ON g.enrollment_id = e.id;

-- Query A grades
SELECT *
FROM enrollment_details
WHERE letter_grade = 'A';

-- ============================================================
-- 7.3 View: course_statistics
-- ============================================================

CREATE VIEW course_statistics AS
SELECT
    c.id,
    c.title,
    COUNT(e.student_id) AS student_count,
    ROUND(AVG(g.final), 2) AS avg_final_score
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
LEFT JOIN grades g ON e.id = g.enrollment_id
GROUP BY c.id;

-- ============================================================
-- 7.4 Insert new student
-- ============================================================

INSERT INTO students (first_name, last_name, email, enrollment_year, gpa)
VALUES ('New', 'Student', 'newstudent@school.edu', 2024, NULL);

-- ============================================================
-- 7.5 Update Quinn Moore GPA
-- ============================================================

UPDATE students
SET gpa = 3.22
WHERE id = 17;

-- ============================================================
-- 7.6 DELETE F grades (preview first)
-- ============================================================

-- STEP 1: Preview
SELECT *
FROM grades
WHERE letter_grade = 'F';

-- STEP 2: Delete (uncomment when ready)
-- DELETE FROM grades
-- WHERE letter_grade = 'F';

-- ============================================================
-- 7.7 TRANSACTION: enroll + grade
-- ============================================================

BEGIN TRANSACTION;

INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES (1, 13, '2024-09-01');

INSERT INTO grades (enrollment_id, midterm, final, assignments, letter_grade)
VALUES (
    (SELECT id FROM enrollments WHERE student_id = 1 AND course_id = 13),
    85, 90, 88, 'A'
);

COMMIT;

-- ============================================================
-- 7.8 TRANSACTION: library loan + update stock
-- ============================================================

BEGIN TRANSACTION;

UPDATE books
SET available_copies = available_copies - 1
WHERE id = 3;

INSERT INTO loans (member_id, book_id, loan_date, due_date, return_date, fine)
VALUES (1, 3, '2024-05-10', '2024-05-24', NULL, 0);

COMMIT;

-- ============================================================
-- 7.9 EXPLAIN QUERY PLAN comparison
-- ============================================================

-- Version A (no index usage likely)
EXPLAIN QUERY PLAN
SELECT * FROM students WHERE gpa + 0 > 3.5;

-- Version B (index-friendly)
EXPLAIN QUERY PLAN
SELECT * FROM students WHERE gpa > 3.5;

-- Explanation:
-- Version A applies an operation on the column (gpa + 0),
-- so SQLite cannot use the index efficiently.
-- Version B directly uses the indexed column (gpa),
-- so it can perform an index lookup, making it faster.

-- ============================================================
-- 7.10 Compound index
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_enrollments_student_course
ON enrollments(student_id, course_id);


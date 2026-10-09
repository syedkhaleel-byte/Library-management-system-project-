-- LIBRARY MANAGEMENT SYSTEM
-- 02_insertion.sql

USE library_management;

INSERT INTO Books (BookID, BookName, Author)
VALUES
('B101', 'DBMS Concepts', 'Korth'),
('B102', 'Java Complete', 'Herbert Schildt'),
('B103', 'Python Basics', 'Mark Lutz');

INSERT INTO Members (MemberID, Name, Department)
VALUES
(1, 'Rahul', 'CSE'),
(2, 'Anjali', 'ECE'),
(3, 'Sneha', 'IT');

INSERT INTO Issue (IssueID, BookID, MemberID, IssueDate, ReturnDate)
VALUES
(1, 'B101', 1, '2026-01-01', '2026-01-05'),
(2, 'B102', 2, '2026-01-03', NULL);

-- LIBRARY MANAGEMENT SYSTEM
-- 03_queries.sql

USE library_management;

-- 1. Find overdue/unreturned books
SELECT
    b.BookID,
    b.BookName,
    b.Author,
    i.IssueDate,
    i.ReturnDate
FROM Books b
JOIN Issue i ON b.BookID = i.BookID
WHERE i.ReturnDate IS NULL;

-- 2. Find books never issued
SELECT
    b.BookID,
    b.BookName,
    b.Author
FROM Books b
LEFT JOIN Issue i ON b.BookID = i.BookID
WHERE i.BookID IS NULL;

-- 3. Find member who borrowed maximum books
SELECT
    m.MemberID,
    m.Name,
    m.Department,
    COUNT(i.BookID) AS Books_Borrowed
FROM Members m
JOIN Issue i ON m.MemberID = i.MemberID
GROUP BY m.MemberID, m.Name, m.Department
ORDER BY Books_Borrowed DESC
LIMIT 1;

-- 4. Find most popular book
SELECT
    b.BookID,
    b.BookName,
    b.Author,
    COUNT(i.IssueID) AS Issue_Count
FROM Books b
JOIN Issue i ON b.BookID = i.BookID
GROUP BY b.BookID, b.BookName, b.Author
ORDER BY Issue_Count DESC
LIMIT 1;

-- 5. Count available books
-- A book is available when it has no current unreturned issue.
SELECT
    COUNT(*) AS Available_Books
FROM Books b
WHERE NOT EXISTS (
    SELECT 1
    FROM Issue i
    WHERE i.BookID = b.BookID
      AND i.ReturnDate IS NULL
);

-- 6. Display all books
SELECT * FROM Books;

-- 7. Display all members
SELECT * FROM Members;

-- 8. Display complete issue details
SELECT
    i.IssueID,
    b.BookName,
    b.Author,
    m.Name AS MemberName,
    m.Department,
    i.IssueDate,
    i.ReturnDate
FROM Issue i
JOIN Books b ON i.BookID = b.BookID
JOIN Members m ON i.MemberID = m.MemberID
ORDER BY i.IssueID;

-- 9. Count total books
SELECT COUNT(*) AS Total_Books
FROM Books;

-- 10. Count total members
SELECT COUNT(*) AS Total_Members
FROM Members;

-- 11. Count books borrowed by each member
SELECT
    m.MemberID,
    m.Name,
    COUNT(i.IssueID) AS Books_Borrowed
FROM Members m
LEFT JOIN Issue i ON m.MemberID = i.MemberID
GROUP BY m.MemberID, m.Name
ORDER BY Books_Borrowed DESC;

-- 12. Find currently borrowed books
SELECT
    b.BookID,
    b.BookName,
    m.Name AS Borrowed_By,
    i.IssueDate
FROM Books b
JOIN Issue i ON b.BookID = i.BookID
JOIN Members m ON i.MemberID = m.MemberID
WHERE i.ReturnDate IS NULL;

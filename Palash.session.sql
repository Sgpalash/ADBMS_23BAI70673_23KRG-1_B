CREATE DATABASE ADBMS;
USE ADBMS;

create table author(
	AUTHOR_ID int primary key,
	AUTHOR_NAME varchar(20),
    AUTHOR_Age int,
    Author_Gender char(1)
);

create table book_table(
    BOOK_ID int primary key,
    BOOK_NAME varchar(20),
    AUTHOR_ID int,
    foreign key(AUTHOR_ID) references author(AUTHOR_ID)
);

insert into author values(554, 'Ruskin Bond', 43, "M"), (130, 'Robert Greene', 37, "M"), (145, 'Zadie Smith', 23, "F"), (786, 'Arundhati Khan', 50, "F");
insert into author values(250, 'Robert Frost', 60, "M"), (120, 'Schewa Zaitsev', 25, "F"), (200, 'J.K. Rowling', 55, "F");
alter table author add COUNTRY varchar(20);
update author set COUNTRY = 'India' where AUTHOR_ID = 786;
update author set COUNTRY = 'USA' where AUTHOR_ID in (554, 130, 250);
update author set COUNTRY = 'Australia' where AUTHOR_ID in (145, 200);
UPDATE author SET COUNTRY = 'Russia' WHERE AUTHOR_ID = 120;
select A.AUTHOR_ID as 'Author Id', A.AUTHOR_NAME as 'Author Name', A.COUNTRY as 'Country' from author as A;
UPDATE author SET AUTHOR_NAME = 'Aruna Nair' WHERE AUTHOR_ID = 786;
select * from author;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------MEDIUM LEVEL---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create table dept(
	Dept_Id smallint AUTO_INCREMENT PRIMARY KEY ,
	Dept_Name varchar(12) NOT NULL
);

drop table course;
drop table dept;
create table course(
	Dept SMALLINT ,
    FOREIGN KEY(Dept) references dept(Dept_Id),
	Course varchar(12)
);

exec sp_help course;

insert into dept(Dept_Name) values('AI&ML'), ('CSE'), ('Bio-Tech'), ('Finance'), ('Psychology');
select * from dept;


INSERT INTO course VALUES
(1, 'Data Science'), (1, 'Neural Networks'),
(1, 'Machine Learning'), (1, 'AI'),
(2, 'Data Analytics'), (2, 'Data Mining'),
(2, 'Full Stack Development'), (2, 'Web Development'),
(3, 'Cyber Security'), (3, 'Network Security'),
(3, 'Bioinformatics'), (3, 'Genetics'),
(3, 'Biology'),
(2, 'Full Stacks'),
(4, 'Economics'), (4, 'Socio-Psycho'),
(5, 'Socio-Psycho'), (5, 'Psychology');

SELECT 
    C.Dept, 
    C.Course, 
    D.Dept_Name AS `Department Name`
FROM 
    course AS C
LEFT JOIN 
    dept AS D ON C.Dept = D.Dept_Id

UNION

SELECT 
    C.Dept, 
    C.Course, 
    D.Dept_Name AS `Department Name`
FROM 
    course AS C
RIGHT JOIN 
    dept AS D ON C.Dept = D.Dept_Id;

SELECT 
    D.Dept_Name AS Department, 
    D.Dept_Id, 
    C.COUNT AS `COUNT`
FROM 
    dept AS D
INNER JOIN (
    SELECT 
        Dept, 
        COUNT(Dept) AS COUNT
    FROM 
        course 
    GROUP BY 
        Dept
) AS C 
ON D.Dept_Id = C.Dept;

SELECT 
    D.Dept_Name AS Department, 
    D.Dept_Id
FROM 
    dept AS D
INNER JOIN (
    SELECT 
        Dept, 
        COUNT(Dept) AS `COUNT`
    FROM 
        course 
    GROUP BY 
        Dept
) AS C 
ON D.Dept_Id = C.Dept
WHERE 
    C.COUNT >= 2;


CREATE USER 'SG_user'@'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON course TO 'SG_user'@'localhost';
FLUSH PRIVILEGES;

select * from course;
show databases;
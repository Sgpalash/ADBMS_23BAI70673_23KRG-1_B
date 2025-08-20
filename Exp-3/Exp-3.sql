SHOW Databases;
use ADBMS;

/*--------------Exp-3: SUB-QUERIES -----------------

DEF: SUB-Query / NESTED Query 
    Q1: OUTER QUERY / MAIN QUERY (Q2 (Q3)) - INNER QUERIES

    EXECUTION ORDER:
    Q3>Q2>Q1

    TYPES OF SUB QUERIES
        1. SCALER SQ --> Returns Single Output;
        2. MULTI - VALUED / MULTI - ROW -> RETURNS MULTIPLE ROWS 
            OPERATORS: IN, NOT IN, ANY(OR), ALL(AND)
        3. SELF-CONTAINED SQ: SQ WHICH HAVE NO DEPENDENCY ON MAIN QUERY
            Q1(Q2) --> we can run q2 alone only.
        4. CO-RELATED SQ: INNER QUERY WILL BE DEPENDENT ON OUTER QUERY
            Q1(Q2) --> we cant run q2 alone only.

    PLACEMENT OF SUB QUERIES:
        1. WE CAN SQ WITH WHERE CLAUSE STATEMENT
        */


use ADBMS;
SELECT * FROM author;

SELECT * FROM emp;

SELECT AUTHOR_ID FROM author IN ()


CREATE TABLE Employee(EmpID INT, Name VARCHAR(20));
INSERT INTO Employee VALUES(2,"A");
INSERT INTO Employee VALUES(4,"B");
INSERT INTO Employee VALUES(4,"C");
INSERT INTO Employee VALUES(6,"D");
INSERT INTO Employee VALUES(6,"E");
INSERT INTO Employee VALUES(7,"F");
INSERT INTO Employee VALUES(8,"G");
INSERT INTO Employee VALUES(8,"H");

SELECT * FROM Employee

SELECT MAX(EmpID) FROM Employee WHERE EmpID NOT IN 
(
    SELECT EmpID FROM Employee GROUP BY EmpID HAVING COUNT(EmpID) > 1
);


CREATE TABLE TBL_PRODUCTS
(
	ID INT PRIMARY KEY,
	NAME VARCHAR(50),
	DESCRIPTION VARCHAR(250) 
);

CREATE TABLE TBL_PRODUCTSALES
(
    ID INT PRIMARY KEY,
    PRODUCT_ID INT,
    UNITPRICE INT,
    QUANTITYSOLD INT,
    FOREIGN KEY (PRODUCT_ID) REFERENCES TBL_PRODUCTS(ID)
)

INSERT INTO TBL_PRODUCTS VALUES (1,"TV","52 INCH BLACK COLOR LCD TV");
INSERT INTO TBL_PRODUCTS VALUES (2,"LAPTOP","VERY THIIN BLACK COLOR ACER LAPTOP");
INSERT INTO TBL_PRODUCTS VALUES (3,"DESKTOP","HP HIGH PERFORMANCE DESKTOP");


INSERT INTO TBL_PRODUCTSALES VALUES (1,3,450,5);
INSERT INTO TBL_PRODUCTSALES VALUES (2,2,250,7);
INSERT INTO TBL_PRODUCTSALES VALUES (3,3,450,4);
INSERT INTO TBL_PRODUCTSALES VALUES (4,3,450,9);


SELECT *FROM TBL_PRODUCTS
SELECT *FROM TBL_PRODUCTSALES

SELECT 
    NAME,
    (SELECT SUM(QUANTITYSOLD) FROM TBL_PRODUCTSALES WHERE PRODUCT_ID = P.ID) AS QUANTITYSOLD_SUM
FROM TBL_PRODUCTS P;

SELECT Name, 
(
    SELECT SUM(QUANTITYSOLD) FROM TBL_PRODUCTSALES WHERE PRODUCT_ID = TBL_PRODUCT.ID
)AS QUANTITYSOLD_SUM FROM TBL_PRODUCTS;


CREATE TABLE FootballParticipants (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE HockeyParticipants (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100)
);




INSERT INTO FootballParticipants (Name, Email)
VALUES
(1,'John', 'john.doe@example.com'),
(2,'Jane', 'jane.smith@example.com'),
(3,'Michael', 'michael.brown@example.com'),
(4,'Emily', 'emily.davis@example.com'),
(5,'David', 'david.wilson@example.com');


INSERT INTO HockeyParticipants (Name, Email)
VALUES
(1,'John', 'john.doe@example.com'),
(2,'Patricia', 'patricia.taylor@example.com'),
(3, 'Michael', 'michael.brown@example.com'),
(4,'Emily', 'emily.davis@example.com'),
(5,'Kevin', 'kevin.martinez@example.com');


SELECT *FROM  FootballParticipants
SELECT *FROM  HockeyParticipants


/*------------------------------------------------Medium LEVEL-------------------------------------------------------------------------------------

How many ways are there to join the tables


*/

CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);


--1. TO JOIN TABLES

SELECT E.*, D.* FROM Employee as E INNER JOIN department as D ON E.department_id = D.id WHERE (
    SELECT MAX(salary) from Employee WHERE department_id = E.department_id
) ORDER BY D.dept_name;

select d.dept_name, e.name, e.salary 
 from employee e INNER JOIN department d on e.department_id = d.id  where salary in  
 ( 
	  	select max(e2.salary) 
	  	 	from employee e2 group by e2.department_id 
 )  ORDER BY D.dept_name;


CREATE TABLE TABLE_A(EmpID INT(20) PRIMARY KEY, Ename VARCHAR(5), salary int(20));

CREATE TABLE TABLE_B(EmpID INT(20) PRIMARY KEY, Ename VARCHAR(5), salary int(20));

INSERT INTO TABLE_A VALUES(1, "AA", 1000), (2, "BB", 300);

INSERT INTO TABLE_B VALUES(2, "BB", 400), (3, "CC", 100);

SELECT EmpID, Ename, salary from (SELECT * FROM TABLE_A UNION ALL SELECT * FROM TABLE_B) AS RESULT;

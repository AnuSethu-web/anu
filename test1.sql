/*
PatientStay Example - Foundation Course
Introduction to SQL and the SELECT statement
*/
-- Single line comments start with two dashes
 
/*
Comments can also be across several lines
SQL does not care about white space or capitalisation but you should!
*/
-- simplest statement, bring back all data from a table
SELECT
    *
FROM
    PatientStay;
 
/*
Rather than * to select all columns, choose the columns you want
*/
SELECT
    ps.PatientId
    ,ps.Hospital
    ,ps.Ward
    ,ps.AdmittedDate
    ,ps.Dischargedate
FROM
    PatientStay ps
WHERE
    ps.Hospital = 'Pruh';
 
/*
Using a table alias (ps in the example below) is good practice and helps in a few ways
1. the autocomplete will list the column names
2. when there are several tables, it is easier to identify which column from which table
*/
SELECT
    p.PatientId
    , p.Ward
    , p.Tariff
    , p.Hospital
FROM
    PatientStay p;
 
/*
Filter rows  with the WHERE clause
Note: we can also AND and OR clauses
*/

SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.Dischargedate
    , DATEADD(WEEK,-2,ps.AdmittedDate) as REMINDERDATE
    , DATEADD(MONTH,3,ps.Dischargedate) as APPOINTMENTDATE
    , DATEDIFF(DAY,AdmittedDate,Dischargedate)  AS DaysInHospital
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps
 WHERE ps.Hospital IN('kingston','pruh') 
 AND PS.Ward LIKE '%Surgery'
 AND ps.AdmittedDate BETWEEN DATEFROMPARTS(2024,02,26)  AND DATEFROMPARTS(2024,03,01)
 ORDER BY PS.AdmittedDate DESC, 
          PS.Ward

SELECT 
PS.Hospital
, COUNT(*) AS NumberOfPatients
, SUM(PS.Tariff) AS TotalTariff
, AVG (ps.Tariff) AS AverageTariff
FROM PatientStay ps 
GROUP BY ps.Hospital
ORDER   BY NumberOfPatients DESC

SELECT DATEFROMPARTS(2025,07,30) as TheDate

/*
some alternative WHERE clauses.  Try these out
 
WHERE ps.Hospital = 'PRUH'; -- column = value
WHERE ps.Tariff >= 5; -- only return large tariffs
WHERE ps.Hospital IN ('PRUH', 'Kingston'); -- column in (list of values)
WHERE ps.AdmittedDate BETWEEN '2024-03-02' AND '2024-03-04';
 
LIKE allows partial matches
_ means any single character
% means 0 or more characters
*/
 
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps
WHERE
    ps.Hospital IN ('Kingston', 'PRUH');
    --WHERE ps.Hospital LIKE 'Kin%'
 
/*
Sort: by the values of one or more columns with the ORDER BY clause
Sorts smallest to largest (ASCending) by default
*/
 
-- ORDER BY a single column
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps
ORDER BY
    ps.Tariff;
 
-- ORDER BY several columns
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps
ORDER BY
    ps.Tariff DESC
    , ps.AdmittedDate
    , ps.PatientId;
 
/*
Add a column with an expression in the column list and a column alias
*/
SELECT
    ps.PatientId
    , ps.AdmittedDate
    -- See documentation for DATEADD at https://www.w3schools.com/sql/func_sqlserver_dateadd.asp
    , DATEADD(WEEK, -2, ps.AdmittedDate) AS ReminderDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps;
 
/*
 * Exercise: Add a column, DaysInHospital - the number of  days (inclusive) between the admitted and discharge dates
 */
 
/*
GROUP BY and aggregate
Aggregate is to get a single result from a set of numbers
Aggregation functions include SUM() and COUNT(*) but also MIN(), MAX(), AVERAGE()..
We can group by at whatever level of aggregation we need and calculate several aggregations
*/
   
-- Aggregate over the entire dataset
SELECT
    COUNT(*) AS NumberOfPatients
    , SUM(ps.Tariff) AS TotalTariff
FROM
    PatientStay ps;
 
-- GROUP BY a single column
SELECT
    ps.AdmittedDate
    , COUNT(*) AS NumberOfPatients
    , SUM(ps.Tariff) AS TotalTariff
FROM
    PatientStay ps
GROUP BY
    ps.AdmittedDate;
 
-- GROUP BY two columns
SELECT
    ps.AdmittedDate
    , ps.Hospital
    , COUNT(*) AS NumberOfPatients
    , SUM(ps.Tariff) AS TotalTariff
FROM
    PatientStay ps
GROUP BY
    ps.AdmittedDate
    , ps.Hospital;
 
/*
Filter the grouped result with the HAVING clause
Remember that the WHERE clause filters the data before it is aggregated
*/
SELECT
    AdmittedDate
    , SUM(ps.Tariff) AS TotalTariff
    , MIN(ps.Tariff) AS SmallestTariff
    , AVG(ps.Tariff) AS AverageTariff
    , COUNT(*) AS NumberOfTariffs
FROM
    PatientStay ps
WHERE
    ps.Ward LIKE '%Surgery'
GROUP BY
    ps.AdmittedDate
HAVING
    SUM(ps.Tariff) >= 20;
 
/*
Joining 2 (or more) tables generates a resultset with the columns from several tables
We can join the PatientStay and DimHospital on the column columns, named Hospital in both tables.
*/
SELECT
    *
FROM
    DimHospital;
 
SELECT
    *
FROM
    PatientStay ps
JOIN DimHospital h ON
    ps.Hospital = h.Hospital;
 
/*
 A more precise way of doing a JOIN
*/
 
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , h.HospitalType
    , h.HospitalSize
FROM
    PatientStay ps
JOIN DimHospital h ON
    ps.Hospital = h.Hospital;
 
/*SQL Server DATEADD() Function
Well organized and easy to understand Web building tutorials with lots of examples of how to use HTML, CSS, JavaScript, SQL, Python, PHP, Bootstrap, Java, XML and more.
 
Ok thank you!
 
Thank you Mark, resources will be great.
 
Hi mark, I'm just leaving the meeting & will rejoin on my personal device, I'm now getting information in my terminal when on personal device so looks like code space is going to work on that 
 
Jess Thomson  (Unverified) was invited to the meeting.

 
I’ve joined on my personal device but now nothing in teams chat, it says muted so work laptop best option I think if IT can unblock the website
 
MarkWilcock/sql-student-template: Template that sets up a CodeSpace for students of the SQL courses
GitHub - MarkWilcock/sql-student-template: Template that sets up a CodeSpace for students of the SQL courses
Template that sets up a CodeSpace for students of the SQL courses - MarkWilcock/sql-student-template
 
/*
PatientStay Example - Foundation Course
Introduction to SQL and the SELECT statement
*/
-- Single line comments start with two dashes
 
/*
Comments can also be across several lines
SQL does not care about white space or capitalisation but you should!
*/
-- simplest statement, bring back all data from a table
SELECT
    *
FROM
    PatientStay;
 
/*
Rather than * to select all columns, choose the columns you want
*/
SELECT
    PatientId
    , Tariff
    , Ward
    , Hospital
FROM
    PatientStay;
 
/*
Using a table alias (ps in the example below) is good practice and helps in a few ways
1. the autocomplete will list the column names
2. when there are several tables, it is easier to identify which column from which table
*/
SELECT
    p.PatientId
    , p.Ward
    , p.Tariff
    , p.Hospital
FROM
    PatientStay p;
 
/*
Filter rows  with the WHERE clause
Note: we can also AND and OR clauses
*/
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps;
 
/*
some alternative WHERE clauses.  Try these out
 
WHERE ps.Hospital = 'PRUH'; -- column = value
WHERE ps.Tariff >= 5; -- only return large tariffs
WHERE ps.Hospital IN ('PRUH', 'Kingston'); -- column in (list of values)
WHERE ps.AdmittedDate BETWEEN '2024-03-02' AND '2024-03-04';
 
LIKE allows partial matches
_ means any single character
% means 0 or more characters
*/
 
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps
WHERE
    ps.Hospital IN ('Kingston', 'PRUH');
    --WHERE ps.Hospital LIKE 'Kin%'
 
/*
Sort: by the values of one or more columns with the ORDER BY clause
Sorts smallest to largest (ASCending) by default
*/
 
-- ORDER BY a single column
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps
ORDER BY
    ps.Tariff;
 
-- ORDER BY several columns
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps
ORDER BY
    ps.Tariff DESC
    , ps.AdmittedDate
    , ps.PatientId;
 
/*
Add a column with an expression in the column list and a column alias
*/
SELECT
    ps.PatientId
    , ps.AdmittedDate
    -- See documentation for DATEADD at https://www.w3schools.com/sql/func_sqlserver_dateadd.asp
    , DATEADD(WEEK, -2, ps.AdmittedDate) AS ReminderDate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
FROM
    PatientStay ps;
 
/*
 * Exercise: Add a column, DaysInHospital - the number of  days (inclusive) between the admitted and discharge dates
 */
 
/*
GROUP BY and aggregate
Aggregate is to get a single result from a set of numbers
Aggregation functions include SUM() and COUNT(*) but also MIN(), MAX(), AVERAGE()..
We can group by at whatever level of aggregation we need and calculate several aggregations
*/
   
-- Aggregate over the entire dataset
SELECT
    COUNT(*) AS NumberOfPatients
    , SUM(ps.Tariff) AS TotalTariff
FROM
    PatientStay ps;
 
-- GROUP BY a single column
SELECT
    ps.AdmittedDate
    , COUNT(*) AS NumberOfPatients
    , SUM(ps.Tariff) AS TotalTariff
FROM
    PatientStay ps
GROUP BY
    ps.AdmittedDate;
 
-- GROUP BY two columns
SELECT
    ps.AdmittedDate
    , ps.Hospital
    , COUNT(*) AS NumberOfPatients
    , SUM(ps.Tariff) AS TotalTariff
FROM
    PatientStay ps
GROUP BY
    ps.AdmittedDate
    , ps.Hospital;
 
/*
Filter the grouped result with the HAVING clause
Remember that the WHERE clause filters the data before it is aggregated
*/
SELECT
    AdmittedDate
    , SUM(ps.Tariff) AS TotalTariff
    , MIN(ps.Tariff) AS SmallestTariff
    , AVG(ps.Tariff) AS AverageTariff
    , COUNT(*) AS NumberOfTariffs
FROM
    PatientStay ps
WHERE
    ps.Ward LIKE '%Surgery'
GROUP BY
    ps.AdmittedDate
HAVING
    SUM(ps.Tariff) >= 20;
 
/*
Joining 2 (or more) tables generates a resultset with the columns from several tables
We can join the PatientStay and DimHospital on the column columns, named Hospital in both tables.
*/
SELECT
    *
FROM
    DimHospital;
 
SELECT
    *
FROM
    PatientStay ps
JOIN DimHospital h ON
    ps.Hospital = h.Hospital;
 
/*
 A more precise way of doing a JOIN
*/
 
SELECT
    ps.PatientId
    , ps.AdmittedDate
    , h.HospitalType
    , h.HospitalSize
FROM
    PatientStay ps
JOIN DimHospital h ON
    ps.Hospital = h.Hospital;
 
SQL Server DATEADD() Function
Well organized and easy to understand Web building tutorials with lots of examples of how to use HTML, CSS, JavaScript, SQL, Python, PHP, Bootstrap, Java, XML and more.
 
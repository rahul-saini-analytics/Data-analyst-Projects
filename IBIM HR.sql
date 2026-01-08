USE IBM

select * from IBM01

-- 1. List all employees who are older than 40 years


select * from IBM01
where Age > 40

-- 2. Get the distinct departments available in the company

select distinct(department) from IBM01

-- 3. Show the average Monthly Income per Department

select department,AVG(monthlyincome) as avgsalary from IBM01
group by Department

-- 4. Find employees who are working overtime and have a performance rating greater than 3

select * from IBM01
where OverTime = '1' and PerformanceRating > '3'


-- 5. Which Job Role has the highest average Monthly Income?

select top 1  jobrole , AVG(monthlyincome) as maxaverge from IBM01
group by JobRole
order by maxaverge desc

-- 6. Find the total number of employees who left the company by Education Field

SELECT EducationField, COUNT(*) AS EmployeesLeft
FROM IBM01
WHERE Attrition = '1'
GROUP BY EducationField;

-- 7. List top 5 employees with the highest Total Working Years

SELECT TOP 5 EmployeeNumber, TotalWorkingYears
FROM IBM01
ORDER BY TotalWorkingYears  DESC;

--8. Average years in current role for each Job Role

SELECT JobRole, AVG(YearsInCurrentRole) AS AvgYearsInRole
FROM IBM01
GROUP BY JobRole;

-- 9. Create a view showing performance analysis
CREATE VIEW vw_PerformanceAnalysis AS
SELECT EmployeeNumber, JobRole, MonthlyIncome, PerformanceRating, YearsAtCompany
FROM IBM01;

select * from vw_PerformanceAnalysis


-- 10. Rank employees within each department based on their MonthlyIncome
SELECT *,
       RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS IncomeRank
FROM IBM01;


-- 11. Create a temp table to track employee turnover trends (assuming hire or exit date exists)
-- Since there's no date, this is just an example structure

CREATE TABLE #TurnoverTrends (
    Year INT,
    EmployeesLeft INT
);


IF NOT EXISTS (SELECT TABLE_NAME 
      FROM UK_Staging.INFORMATION_SCHEMA.TABLES 
            WHERE TABLE_TYPE = 'BASE TABLE' and TABLE_NAME = 'Calendar'
   )
   exec('CREATE TABLE [dim].[Calendar](
  [kDate] [int] NOT NULL,
  [Date] [date] NOT NULL,
  [Day] [int] NULL,
  [DayName] [nvarchar](30) NULL,
  [Week] [int] NULL,
  [ISOWeek] [int] NULL,
  [DayOfWeek] [int] NULL,
  [Month] [int] NULL,
  [MonthName] [nvarchar](30) NULL,
  [Quarter] [int] NULL,
  [Year] [int] NULL,
  [FirstOfMonth] [date] NULL,
  [LastOfYear] [date] NULL,
  [DayOfYear] [int] NULL
   )'
	 );
GO 

IF NOT EXISTS ( SELECT *
			 FROM sys.key_constraints
			 WHERE name = 'pkCalendar'
			 )
	exec('ALTER TABLE dim.Calendar
		ADD CONSTRAINT pkCalendar PRIMARY KEY(kDate)'
		)
;
GO

TRUNCATE TABLE dim.Calendar
GO

DECLARE @StartDate  date = '20180101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 25, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    kDate		  = CAST(REPLACE(CAST ([d] as varchar(10)),'-','') as INT),			
    Date		  = CONVERT(date, d),
    Day          = DATEPART(DAY,       d),
    DayName      = DATENAME(WEEKDAY,   d),
    Week         = DATEPART(WEEK,      d),
    ISOWeek      = DATEPART(ISO_WEEK,  d),
    DayOfWeek    = DATEPART(WEEKDAY,   d),
    Month        = DATEPART(MONTH,     d),
    MonthName    = DATENAME(MONTH,     d),
    Quarter      = DATEPART(Quarter,   d),
    Year         = DATEPART(YEAR,      d),
    FirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    LastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    DayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
)
INSERT INTO dim.Calendar
SELECT * 
FROM src
ORDER BY Date
OPTION (MAXRECURSION 0);
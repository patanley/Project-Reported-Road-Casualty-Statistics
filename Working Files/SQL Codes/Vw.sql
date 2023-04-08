/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Year]
	  ,LEFT(kDate, 6) as 'YearMonth'
      ,[Month]
      ,sum([Count_of_Casualty]) as 'Count_of_Casualty'
  FROM [UK_Staging].[vw].[Casualty_rpt]
  GROUP BY Year, Month, LEFT(kDate, 6)
  ORDER BY 1, 2
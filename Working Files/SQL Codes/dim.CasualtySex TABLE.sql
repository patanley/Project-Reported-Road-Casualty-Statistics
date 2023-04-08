USE UK_Staging;
GO


DROP TABLE if exists Casualty_Sex;
GO

SELECT DISTINCT [sex_of_casualty]
		,CASE
			WHEN sex_of_casualty = -1 THEN 'Unknown'
			WHEN sex_of_casualty = 1 THEN 'Male'
			WHEN sex_of_casualty = 2 THEN 'Female'
			WHEN sex_of_casualty = 9 THEN 'Unknown'
		END as 'CasualtySexDescription'
INTO dim.Casualty_Sex
FROM [UK_Staging].[stg].[casualites]


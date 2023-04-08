USE UK_Staging;
GO


DROP TABLE if exists Casualty_Class;
GO

SELECT DISTINCT [casualty_class]
		,CASE
			WHEN casualty_class = 1 THEN 'Driver/Rider'
			WHEN casualty_class = 2 THEN 'Passenger'
			WHEN casualty_class = 3 THEN 'Pedestrian'
		END as 'CasualtyClassDescription'
INTO dim.Casualty_Class
FROM [UK_Staging].[stg].[casualites]
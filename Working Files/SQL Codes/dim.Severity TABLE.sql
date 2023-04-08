USE UK_Staging;
GO


DROP TABLE if exists dim.Severity;
GO

SELECT DISTINCT casualty_severity
		,CASE
			WHEN casualty_severity = 1 THEN 'FATAL'
			WHEN casualty_severity = 2 THEN 'Serious'
			WHEN casualty_severity = 3 THEN 'Slight'
		END as 'SeverityDescription'
INTO dim.Severity
FROM [UK_Staging].[stg].[casualites]


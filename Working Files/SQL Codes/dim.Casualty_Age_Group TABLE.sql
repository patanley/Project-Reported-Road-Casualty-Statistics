/****** Script for SelectTopNRows command from SSMS  ******/
USE UK_Staging;
GO

DROP TABLE if exists dim.Casualty_Age_Group;
GO

SELECT DISTINCT [age_of_casualty]
--      ,[age_band_of_casualty]
	  ,CASE
			WHEN age_of_casualty >= 0 AND age_of_casualty <= 15 THEN '0 - 15'
			WHEN age_of_casualty >= 16 AND age_of_casualty <= 24 THEN '16 - 24'
			WHEN age_of_casualty >= 25 AND age_of_casualty <= 59 THEN '25 - 59'
			WHEN age_of_casualty >= 60 AND age_of_casualty <= 102 THEN '60+'
			WHEN age_of_casualty >= -1 THEN 'Unknown'
	  END as age_band_of_casualty
INTO dim.Casualty_Age_Group
  FROM [stg].[casualties]






 
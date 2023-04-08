/****** Script for SelectTopNRows command from SSMS  ******/
USE UK_Staging;
GO


DROP TABLE if exists dim.Speed_limit;
GO


SELECT DISTINCT [speed_limit]
INTO dim.Speed_limit
  FROM [UK_Staging].[stg].[accidents]
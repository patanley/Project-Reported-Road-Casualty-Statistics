USE UK_Staging;


DROP VIEW IF EXISTS vw.Casualty_rpt
GO

CREATE or ALTER VIEW vw.Casualty_rpt
AS

SELECT acc.accident_year as 'Year'
		,cal.Date as 'Date'
		,cal.kDate
		,cal.[MonthName] as 'Month_Name'
		,cal.Month as'Month'
		,age.age_band_of_casualty as 'Casualty_Age_Group'
		,sex.CasualtySexDescription as 'Casualty_sex'
		,rut.[Road Type User]
		,lha.Local_Highway_Authority_Name as 'Local_Highway_Authority'
		,lh.Local_Highway_Auth as 'LHA_Map'
		,pfa.PoliceForceDesc as 'Police_Force_Area'
		,sev.SeverityDescription as 'Severity'
		,class.CasualtyClassDescription as 'Casualty_class'        
		,(CASE        
			WHEN  first_road_class IN (1,2) THEN 'Motorway'        
			WHEN acc.urban_or_rural_area = 1 AND first_road_class NOT IN (1,2) THEN 'Urban'        
			WHEN acc.urban_or_rural_area = 2 AND acc.first_road_class NOT IN (1,2) THEN 'Rural'        
			ELSE 'Unknown'    
		END) as 'Road_Type'
		,sl.speed_limit as 'Speed_Limit'
		,w.Weather_Label
		,1 as 'Count_of_Casualty'
FROM [stg].[casualties] cas
	INNER JOIN stg.accidents acc
	ON cas.accident_index = acc.accident_index
	INNER JOIN dim.Calendar cal
	ON cal.Date = acc.acc_date
	INNER JOIN dim.Casualty_Age_Group age
	ON cas.age_of_casualty = age.age_of_casualty
	INNER JOIN dim.Casualty_Class class
	ON class.casualty_class = cas.casualty_class
	INNER JOIN dim.Casualty_Sex sex
	ON sex.sex_of_casualty = cas.sex_of_casualty
	INNER JOIN dim.Local_Highway_Authority lha
	ON acc.local_authority_highway = lha.local_authority_highway_Id
	INNER JOIN dim.Police_Force_Area pfa
	ON acc.police_force = pfa.PoliceForceCode
	INNER JOIN dim.Road_User_Type rut
	ON rut.road_type = cas.casualty_type
	INNER JOIN dim.Severity sev
	ON sev.casualty_severity = cas.casualty_severity
	INNER JOIN dim.Speed_limit sl
	ON sl.speed_limit = acc.speed_limit
	INNER JOIN dim.Weather w
	ON w.code = acc.weather_conditions
	INNER JOIN dim.LoHiAu lh
	ON lh.LHA_Code = acc.local_authority_highway

-- 557,548 Rows

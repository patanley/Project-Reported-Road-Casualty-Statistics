/****** Script for SelectTopNRows command from SSMS  ******/
SELECT count (*)
FROM [stg].[casualties] cas
	INNER JOIN stg.accidents acc
	ON cas.accident_index = acc.accident_index
	INNER JOIN dim.Calendar cal
	ON cal.Date = acc.acc_date
	INNER JOIN dim.Casualty_Age_Group age
	ON cas.age_of_casualty = age.age_of_casualty
	INNER JOIN dim.Casualty_Class cc
	ON cc.casualty_class = cas.casualty_class
	INNER JOIN dim.Casualty_Sex cs
	ON cs.sex_of_casualty = cas.sex_of_casualty
	INNER JOIN dim.Local_Highway_Authority lha
	ON acc.local_authority_highway = lha.local_authority_highway_Id
	INNER JOIN dim.Police_Force_Area pfa
	ON acc.police_force = pfa.PoliceForceCode
	INNER JOIN dim.Road_User_Type rut
	ON rut.road_type = cas.casualty_type
	INNER JOIN dim.Severity s
	ON s.casualty_severity = cas.casualty_severity
	INNER JOIN dim.Speed_limit sl
	ON sl.speed_limit = acc.speed_limit
WHERE cal.Year = 2018 and 
	 cs.CasualtySexDescription = 'Female'	
; --728,541 rows

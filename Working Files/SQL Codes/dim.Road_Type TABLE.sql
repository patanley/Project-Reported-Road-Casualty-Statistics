

DROP TABLE if exists dim.Road_Type; 

SELECT acc.urban_or_rural_area     
	,acc.first_road_class     
	,(CASE        
		WHEN  first_road_class IN (1,2) THEN 'Motorway'        
		WHEN acc.urban_or_rural_area = 1 AND first_road_class NOT IN (1,2) THEN 'Urban'        
		WHEN acc.urban_or_rural_area = 2 AND acc.first_road_class NOT IN (1,2) THEN 'Rural'        
		ELSE 'Unknown'    
	END) as 'Road_Type'
INTO dim.Road_Type
FROM stg.accidents acc
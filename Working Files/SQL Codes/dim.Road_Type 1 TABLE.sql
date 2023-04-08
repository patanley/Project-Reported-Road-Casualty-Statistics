SELECT DISTINCT first_road_class
		,urban_or_rural_area
		,CASE
			WHEN first_road_class in (1,2) THEN 'Motorway'
			WHEN urban_or_rural_area = 1 AND first_road_class not in (1,2) THEN 'Urban'
			WHEN urban_or_rural_area = 2 AND first_road_class not in (1,2) THEN 'Rural'
			ELSE 'Unkown'
		END AS 'Calc_Road_Type'
FROM stg.accidents
ORDER BY 1
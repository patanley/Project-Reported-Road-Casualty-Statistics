USE UK_Staging;
GO

SELECT distinct casualty_type as 'Road_Type'
     ,(CASE
        WHEN casualty_type = 0 THEN 'Pedestrian'
        WHEN casualty_type = 1 THEN 'Pedal Cyclist'
        WHEN casualty_type IN (8, 9, 10) THEN 'Car Occupant'
        WHEN casualty_type = 11 THEN 'Bus Occupant'
        WHEN casualty_type = 19 THEN 'Van Occupant'
        WHEN casualty_type IN (2,3,4,5,23,97)  THEN 'Motor Cyclist'
        WHEN casualty_type IN (20, 21) THEN 'HGV Occupant'
        WHEN casualty_type IN (16,17,18,22,90,98) THEN 'Other Veh Occupant'
        WHEN casualty_type IN (-1,99) THEN 'Unknown'
     END) as 'Road Type User'
INTO dim.Road_User_Type
FROM stg.casualites
ORDER BY 1
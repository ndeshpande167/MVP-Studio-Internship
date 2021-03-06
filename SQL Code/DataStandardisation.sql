/* 1. Fix typo for Chester Hil */
UPDATE Stations 
SET StationSuburb = 'Chester Hill' 
WHERE StationSuburb = 'Chester Hil';

/* 2. Change suburb name to match suburb name from Suburbs table */
UPDATE Stations 
SET StationSuburb = 'Sydney Domestic Airport' 
WHERE StationSuburb = 'Domestic';

/* 3. Change suburb name to match suburb name from Suburbs table */
UPDATE Stations 
SET StationSuburb = 'Sydney International Airport' 
WHERE StationSuburb = 'International';

/* 4. Insert SuburbID to Stations table */
UPDATE Stations
SET SuburbID = b.SuburbID
FROM Stations t
INNER JOIN Suburbs b ON t.StationSuburb = b.SuburbName;

/* 5. Insert SuburbID to Schools table */
UPDATE Schools
SET SuburbID = b.SuburbID
FROM Schools c
INNER JOIN Suburbs b ON c.SchoolSuburb = b.SuburbName;

/* 6. Add new column to Stations table to uniquely identify each station */
UPDATE Stations
SET StationName = StationSuburb + ' ' + Street_Name + ' ' + Street_Type + ' ' + Entrance_Type;

/* 7. Remove Street_Name, Street_Type, Entrance_Type */

/* 8. Add new column 'City' and convert names to lowercase*/
UPDATE Suburbs
SET City = 
CASE
	/* Case when suburb name has just one word */
	WHEN CHARINDEX(' ', CityTown) < 1 THEN 
	LEFT(CityTown, 1) + LOWER(RIGHT(CityTown, LEN(CityTown) - 1))
	/* Case when suburb name has two words */
	WHEN CHARINDEX(' ', CityTown) >= 1 THEN
	LEFT(CityTown, 1) + LOWER(LEFT(RIGHT(CityTown, LEN(CityTown) -1), CHARINDEX(' ', CityTown) - 1)) + 
	LEFT(RIGHT(CityTown, LEN(CityTown) - CHARINDEX(' ', CityTown)), 1) +
	LOWER(RIGHT(CityTown, LEN(CityTown) - CHARINDEX(' ', CityTown) - 1))
END

/* 9. Update city name to suburb name where city name is currently #n/a */
UPDATE Suburbs
SET City = SuburbName
WHERE City = '#n/a';

/* 10. Remove column 'CityTown' from Suburbs table */
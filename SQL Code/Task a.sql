/* TASK ONE
List of all property ID's and property names for owner with ID 1426. */
SELECT p.Name, p.Id
FROM Property p
INNER JOIN OwnerProperty op ON p.Id = op.PropertyId
WHERE OwnerId = 1426;
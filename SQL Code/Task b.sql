/* TASK TWO
List of all property ID's, property names, and home values for owner with ID 1426. */
SELECT p.Name AS PropertyName, p.Id AS PropertyId, phv.Value AS HomeValue
FROM Property p
INNER JOIN OwnerProperty op ON p.Id = op.PropertyId
INNER JOIN PropertyHomeValue phv ON p.Id = phv.PropertyId
WHERE OwnerId = 1426 AND phv.IsActive = 1;
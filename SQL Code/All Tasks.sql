/* TASK ONE
List of all property ID's and property names for owner with ID 1426. */
SELECT p.Name, p.Id
FROM Property p
INNER JOIN OwnerProperty op ON p.Id = op.PropertyId
WHERE OwnerId = 1426;

/* TASK TWO
List of all property ID's, property names, and home values for owner with ID 1426. */
SELECT p.Name AS PropertyName, p.Id AS PropertyId, phv.Value AS HomeValue
FROM Property p
INNER JOIN OwnerProperty op ON p.Id = op.PropertyId
INNER JOIN PropertyHomeValue phv ON p.Id = phv.PropertyId
WHERE OwnerId = 1426 AND phv.IsActive = 1;

/* TASK THREE
List of all properties, their ID's, names, and the total rent amount from start date to end date (present date if no end date specified). */
SELECT tp.PropertyId AS PropertyId, p.Name AS PropertyName,
CASE
	WHEN tp.PaymentFrequencyId = 1 THEN (DATEDIFF(WEEK, tp.StartDate, ISNULL(tp.EndDate, GETDATE()))) * tp.PaymentAmount
	WHEN tp.PaymentFrequencyId = 2 THEN (DATEDIFF(WEEK, tp.StartDate, ISNULL(tp.EndDate, GETDATE())) / 2) * tp.PaymentAmount
	WHEN tp.PaymentFrequencyId = 3 THEN (DATEDIFF(MONTH, tp.StartDate, ISNULL(tp.EndDate, GETDATE()))) * tp.PaymentAmount
END AS TotalRentalPayment
FROM TenantProperty tp
INNER JOIN OwnerProperty op ON tp.PropertyId = op.PropertyId
INNER JOIN Property p ON tp.PropertyId = p.Id
WHERE OwnerId = 1426;

/* TASK FOUR
List of all open jobs in the marketplace, advertised ONLY by owners. */
SELECT jwl.Id, jwl.MarketJobId, jwl.PersonId, jwl.CreatedBy, jwl.CreatedOn, jwl.UpdatedOn, jwl.IsActive
FROM JobWatchList jwl
INNER JOIN Owners o ON jwl.PersonId = o.Id
WHERE jwl.IsActive = 1;

/* TASK FIVE
List of all properties, their tenant names, and the amount of rent due per week, fortnight, or month. */
SELECT p.Name AS PropertyName, RTRIM(pr.FirstName) + ' ' + RTRIM(pr.LastName) AS TenantName,
CASE
	WHEN tp.PaymentFrequencyId = 1 THEN '$' + CONVERT(VARCHAR(10), tp.PaymentAmount) + ' per week.'
	WHEN tp.PaymentFrequencyId = 2 THEN '$' + CONVERT(VARCHAR(10), tp.PaymentAmount) + ' per fortnight.'
	WHEN tp.PaymentFrequencyId = 3 THEN '$' + CONVERT(VARCHAR(10), tp.PaymentAmount) + ' per month.'
END AS TotalRentalPayment
FROM TenantProperty tp
INNER JOIN OwnerProperty op ON tp.PropertyId = op.PropertyId
INNER JOIN Property p ON tp.PropertyId = p.Id
INNER JOIN Person pr ON tp.TenantId = pr.Id
WHERE OwnerId = 1426;
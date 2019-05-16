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
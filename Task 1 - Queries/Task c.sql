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
/* TASK FOUR
List of all open jobs in the marketplace, advertised ONLY by owners. */
SELECT jwl.Id, jwl.MarketJobId, jwl.PersonId, jwl.CreatedBy, jwl.CreatedOn, jwl.UpdatedOn, jwl.IsActive
FROM JobWatchList jwl
INNER JOIN Owners o ON jwl.PersonId = o.Id
WHERE jwl.IsActive = 1;
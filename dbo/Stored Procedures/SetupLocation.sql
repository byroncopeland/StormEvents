/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.9.17
COMMENTS:	Populate dbo.Location - the zone and county bridge table
			Zone and County is Many-To-Many relationship
			A zone can contain several counties
			A county can have multiple zones 
==========================================================

*/
CREATE PROCEDURE [dbo].[SetupLocation]
AS

SET NOCOUNT ON;
BEGIN TRY
	BEGIN TRANSACTION;
---------------------------------------------------------
-- LOCATION 
--------------------------------------------------------- 
--get all combinations of zone and county
	INSERT [dbo].[Location] (CountyID, ZoneID)
	SELECT c.CountyID, z.zoneID
	  FROM zonecounty AS zc
		   INNER JOIN Zone AS z 
		   ON StateCode = state 
			  AND z.zone = zc.zone
		   INNER JOIN County AS c 
		   ON c.StateID = left(fips,2) 
			  AND c.CountyFIPS = right(fips,3)

	COMMIT TRANSACTION;
END TRY

BEGIN CATCH
IF @@trancount > 0 ROLLBACK TRANSACTION
   ;THROW
   RETURN 1
END CATCH
GO


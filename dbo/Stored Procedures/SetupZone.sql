/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.9.17
COMMENTS:	Populate geographical zones within each state
			A zone can contain several counties
			A county can have multiple zones
==========================================================

*/
CREATE PROCEDURE [dbo].[SetupZone]
AS

SET NOCOUNT ON;
BEGIN TRY
	BEGIN TRANSACTION;
---------------------------------------------------------
-- ZONES 
--------------------------------------------------------- 
	INSERT dbo.Zone 
		   (zoneName, 
		   StateZone, 
		   StateCode, 
		   Zone)
	SELECT DISTINCT 
	       name, 
		   statezone, 
		   state, 
		   zone 
	  FROM zonecounty
	 WHERE name <> '';

	 	 COMMIT TRANSACTION;
END TRY

BEGIN CATCH
IF @@trancount > 0 ROLLBACK TRANSACTION
   ;THROW
   RETURN 1
END CATCH

GO



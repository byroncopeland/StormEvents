/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.9.17
COMMENTS:	Populate geographical zones within each state
			A zone can contain several counties
			A county can have multiple zones
==========================================================
UPDATED By: Byron Copeland
DATE:		10.29.17
COMMENTS:	Added left join to only insert new records
===========================================================
*/
CREATE procedure [dbo].[SetupZone]
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
		   zc.statezone, 
		   state, 
		   zc.zone 
	  FROM zonecounty zc
	       INNER JOIN dbo.Zone z
		   ON zc.state = z.StateCode
		   AND zc.zone = z.Zone
	 WHERE name <> ''
	   AND z.zoneName is NULL;

	 	 COMMIT TRANSACTION;
END TRY

BEGIN CATCH
IF @@trancount > 0 ROLLBACK TRANSACTION
   ;THROW
   RETURN 1
END CATCH

GO


